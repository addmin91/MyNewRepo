//
//  NSURL+Unretina.m
//  Unretiner
//
//  Created by Stuart Hall on 31/07/11.
//

#import "NSURL+Unretina.h"
#import "NSBitmapImageRep+Resizing.h"

@implementation NSURL (Unretina)

static NSString* const kRetinaString = @"@2x";
static NSString* const kHdString = @"-hd";

- (BOOL)unretina:(NSURL*)folder errors:(NSMutableArray*)errors warnings:(NSMutableArray*)warnings overwrite:(BOOL)overwrite {
    BOOL success = NO;
    if (1+1 == 2) {
        // New path is the same file minus the @2x
        NSString* newFilename = [[self lastPathComponent] stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        newFilename = [newFilename stringByReplacingOccurrencesOfString:@"-hd" withString:@""];
        NSString* newPath = [NSString stringWithFormat:@"%@%@", [folder relativeString], newFilename];
        NSURL* newUrl = [NSURL URLWithString:newPath];
        
        // Check if file exists
		if (!overwrite && [newUrl checkResourceIsReachableAndReturnError:nil]) {
			// Exists already
			[warnings addObject:[NSString stringWithFormat:@"%@ : Skipped (exists)", [[newUrl absoluteString] lastPathComponent]]];
			return NO;
		}
        
		NSImage *sourceImage = [[NSImage alloc] initWithContentsOfURL:self];
        if (sourceImage && [sourceImage isValid]) {
            // Hack to ensure the size is set correctly independent of the dpi
            
            
            
            
            
            NSImageRep *rep = [[sourceImage representations] objectAtIndex:0]; 
			[sourceImage setScalesWhenResized:YES]; 
			[sourceImage setSize:NSMakeSize([rep pixelsWide], [rep pixelsHigh])]; 
            
            
            
            // Determine the image type
            NSBitmapImageFileType imageType = [self imageType];
            if ((int)imageType >= 0) {
                
                
                //iphone 4
                newPath = [NSString stringWithFormat:@"%@%@%@", [folder relativeString], @"640x960", newFilename];
                newUrl = [NSURL URLWithString:newPath];
                // Create a bitmap representation
                NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithWidth:640.0 andHeight:960.0];
                [imageRep setImage:sourceImage];

                // Write out the new image
                NSData *imageData = [imageRep representationUsingType:imageType properties:nil];
                if (![imageData writeToURL:newUrl atomically:YES]) {
                    [errors addObject:[NSString stringWithFormat:@"%@ : Error creating file", newPath]];
                } 
                else {
                    success = YES;
                }
                
                
                //iphone 5
                newPath = [NSString stringWithFormat:@"%@%@%@", [folder relativeString], @"640x1136", newFilename];
                newUrl = [NSURL URLWithString:newPath];
                // Create a bitmap representation
                imageRep = [NSBitmapImageRep imageRepWithWidth:640.0 andHeight:1136.0];
                [imageRep setImage:sourceImage];
                
                // Write out the new image
                imageData = [imageRep representationUsingType:imageType properties:nil];
                if (![imageData writeToURL:newUrl atomically:YES]) {
                    [errors addObject:[NSString stringWithFormat:@"%@ : Error creating file", newPath]];
                }
                else {
                    success = YES;
                }
                
                //iphone 6
                newPath = [NSString stringWithFormat:@"%@%@%@", [folder relativeString], @"750x1334", newFilename];
                newUrl = [NSURL URLWithString:newPath];
                // Create a bitmap representation
                imageRep = [NSBitmapImageRep imageRepWithWidth:750.0 andHeight:1334.0];
                [imageRep setImage:sourceImage];
                
                // Write out the new image
                imageData = [imageRep representationUsingType:imageType properties:nil];
                if (![imageData writeToURL:newUrl atomically:YES]) {
                    [errors addObject:[NSString stringWithFormat:@"%@ : Error creating file", newPath]];
                }
                else {
                    success = YES;
                }
                
                //iphone 6 plus
                newPath = [NSString stringWithFormat:@"%@%@%@", [folder relativeString], @"1242x2208", newFilename];
                newUrl = [NSURL URLWithString:newPath];
                // Create a bitmap representation
                imageRep = [NSBitmapImageRep imageRepWithWidth:1242.0 andHeight:2208.0];
                [imageRep setImage:sourceImage];
                
                // Write out the new image
                imageData = [imageRep representationUsingType:imageType properties:nil];
                if (![imageData writeToURL:newUrl atomically:YES]) {
                    [errors addObject:[NSString stringWithFormat:@"%@ : Error creating file", newPath]];
                }
                else {
                    success = YES;
                }
                
                //ipad
                newPath = [NSString stringWithFormat:@"%@%@%@", [folder relativeString], @"768x1024", newFilename];
                newUrl = [NSURL URLWithString:newPath];
                // Create a bitmap representation
                imageRep = [NSBitmapImageRep imageRepWithWidth:768.0 andHeight:1024.0];
                [imageRep setImage:sourceImage];
                
                // Write out the new image
                imageData = [imageRep representationUsingType:imageType properties:nil];
                if (![imageData writeToURL:newUrl atomically:YES]) {
                    [errors addObject:[NSString stringWithFormat:@"%@ : Error creating file", newPath]];
                }
                else {
                    success = YES;
                }
                
                //ipad pro
                newPath = [NSString stringWithFormat:@"%@%@%@", [folder relativeString], @"2048x2732", newFilename];
                newUrl = [NSURL URLWithString:newPath];
                // Create a bitmap representation
                imageRep = [NSBitmapImageRep imageRepWithWidth:2048.0 andHeight:2732.0];
                [imageRep setImage:sourceImage];
                
                // Write out the new image
                imageData = [imageRep representationUsingType:imageType properties:nil];
                if (![imageData writeToURL:newUrl atomically:YES]) {
                    [errors addObject:[NSString stringWithFormat:@"%@ : Error creating file", newPath]];
                }
                else {
                    success = YES;
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            }
            
            else {
                [errors addObject:[NSString stringWithFormat:@"%@ : Unknown image type", [[self absoluteString] lastPathComponent]]];
            }
        }
        else {
            // Invalid
            [errors addObject:[NSString stringWithFormat:@"%@ : Appears to be invalid", [[self absoluteString] lastPathComponent]]];
        }
        
        // Cleanup
        if (sourceImage) {
            [sourceImage release];
        }
    }
    else if (errors) {
        // Not a valid retina file
        [errors addObject:[NSString stringWithFormat:@"%@ : Not a @2x or -hd file", [[self absoluteString] lastPathComponent]]];
    }
    
    return success;
}

- (NSBitmapImageFileType)imageType {
    NSString* extension = [[self pathExtension] lowercaseString];
    if ([extension caseInsensitiveCompare:@"jpg"] == NSOrderedSame || [extension caseInsensitiveCompare:@"jpeg"] == NSOrderedSame) {
        // JPG
        return NSJPEGFileType;
    }
    else if ([extension caseInsensitiveCompare:@"png"] == NSOrderedSame) {
        // PNG
        return NSPNGFileType;
    }
    else if ([extension caseInsensitiveCompare:@"gif"] == NSOrderedSame) {
        // GIF
        return NSGIFFileType;
    }
    else if ([extension caseInsensitiveCompare:@"tif"] == NSOrderedSame || [extension caseInsensitiveCompare:@"tiff"] == NSOrderedSame) {
        // TIFF
        return NSTIFFFileType;
    }
    
    // Hack
    return -1;
}

- (BOOL)isRetinaImage {
    // See if the file is a retina image
    NSString* lastComponent = [[self absoluteString] lastPathComponent];
    lastComponent = [lastComponent stringByDeletingPathExtension];
    return [lastComponent hasSuffix:kRetinaString] || [lastComponent hasSuffix:kHdString];
}

@end
