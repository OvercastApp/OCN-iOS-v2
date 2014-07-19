//
//  UIImage+Extras.h
//  Overcast Network
//
//  Created by Yichen Cao on 4/30/14.
//  Copyright (c) 2014 Schem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extras)

- (UIImage *)imageWithRoundedCornersRadius:(float)radius;
- (UIImage *)scaleImageToSize:(CGSize)newSize;

@end
