//
//  VAMTheme.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/22/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMTheme.h"
#import "UIColor+Theme.h"

@implementation VAMTheme

+(void)setupTheme
{
    UINavigationBar* t = [UINavigationBar appearance];
    t.barStyle = UIBarStyleDefault;
    
    //Set navigation bar's background color to theme blue and button tints to white
    t.barTintColor = [UIColor UVAWhite];
    t.tintColor = [UIColor UVAOrange];
    
    //Sets navigation bar's title font and configures title shadow
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    t.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor UVAOrange] ,
                              NSShadowAttributeName : shadow,
                              NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:24.0]};
}

@end
