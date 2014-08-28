//
//  VAMControllerStore.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/26/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMControllerStore.h"
#import "VAMVoidController.h"

@implementation VAMControllerStore

+(VAMControllerStore *)sharedInstance
{
    static VAMControllerStore *store = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[VAMControllerStore alloc] init];
    });
    
    return store;
}

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _activeViewControllers = [[NSMutableArray alloc] initWithCapacity:8];
        for (int i = 0; i < 8; i++)
        {
            VAMVoidController *voidController = [[VAMVoidController alloc] init];
            [_activeViewControllers addObject:voidController];
        }
    }
    
    return self;
}

-(UINavigationController *)viewControllerForIndex:(int)index
{
    if ([[_activeViewControllers objectAtIndex:index] class] != [VAMVoidController class])
    {
        return [_activeViewControllers objectAtIndex:index];
    }
    
    UIStoryboard *storyboard = nil;
    
    switch (index)
    {
        case 0:
            storyboard = [UIStoryboard storyboardWithName:@"Home_Storyboard" bundle:[NSBundle mainBundle]];
            break;
        case 1:
            storyboard = [UIStoryboard storyboardWithName:@"Committees_Storyboard" bundle:[NSBundle mainBundle]];
            break;
        case 2:
            storyboard = [UIStoryboard storyboardWithName:@"Map_Storyboard" bundle:[NSBundle mainBundle]];
            break;
        case 3:
            storyboard = [UIStoryboard storyboardWithName:@"Food_Storyboard" bundle:[NSBundle mainBundle]];
            break;
        case 4:
            storyboard = [UIStoryboard storyboardWithName:@"Merchandise_Storyboard" bundle:[NSBundle mainBundle]];
            break;
        case 5:
            storyboard = [UIStoryboard storyboardWithName:@"Charity_Storyboard" bundle:[NSBundle mainBundle]];
            break;
        case 6:
            storyboard = [UIStoryboard storyboardWithName:@"VAMUN_Web_Storyboard" bundle:[NSBundle mainBundle]];
            break;
        default:
            storyboard = [UIStoryboard storyboardWithName:@"Contact_Info_Storyboard" bundle:[NSBundle mainBundle]];
            break;
    }
    
    UINavigationController *navigationController = [storyboard instantiateInitialViewController];
    [_activeViewControllers setObject:navigationController atIndexedSubscript:index];
    return navigationController;
}



@end
