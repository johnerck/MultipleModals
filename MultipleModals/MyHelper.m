//
//  MyHelper.m
//  MultipleModals
//
//  Created by John Erck on 11/20/14.
//  Copyright (c) 2014 Above Market. All rights reserved.
//

#import "MyHelper.h"

@implementation MyHelper

+ (UIImage *)screenshot
{
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *appWindow = [app.windows objectAtIndex:0];
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(appWindow.bounds.size, NO, [UIScreen mainScreen].scale);
    }
    else
    {
        UIGraphicsBeginImageContext(appWindow.bounds.size);
    }
    [appWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
