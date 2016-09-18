//
//  UIImage+ResizeImage.m
//  TestTumblr
//
//  Created by Anton A on 18.09.16.
//  Copyright © 2016 Anton A. All rights reserved.
//

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)

-(UIImage *)resizeImage {
    CGFloat actualHeight = self.size.height;
    CGFloat actualWidth = self.size.width;
    CGFloat ratio = 300/actualWidth;
    actualHeight = actualHeight*ratio;
    CGRect rect = CGRectMake(0.0, 0.0, 300, actualHeight);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    [self drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
