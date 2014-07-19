//
//  UIImage+Extras.m
//  Overcast Network
//
//  Created by Yichen Cao on 4/30/14.
//  Copyright (c) 2014 Schem. All rights reserved.
//

#import "UIImage+Extras.h"

@implementation UIImage (Extras)

- (UIImage *)imageWithRoundedCornersRadius:(float)radius
{
    // Begin a new image that will be the new image with the rounded corners
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    
    // Draw your image
    [self drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

- (UIImage *)scaleImageToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
