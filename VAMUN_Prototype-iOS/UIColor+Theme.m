//
//  UIColor+Theme.m
//  Charlottesville Artfinder
//
//  Created by Alex Ramey on 7/23/14.
//  Copyright (c) 2014 HooApps. All rights reserved.
//

#import "UIColor+Theme.h"

//macro for setting RGB color
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (Theme)

+(UIColor *)UVABlue
{
    return UIColorFromRGB(0x0D3268);
}

+(UIColor *)UVAOrange
{
    return UIColorFromRGB(0xFF7003);
}

+(UIColor *)UVAWhite
{
    return UIColorFromRGB(0xF5F2DA);
}

@end
