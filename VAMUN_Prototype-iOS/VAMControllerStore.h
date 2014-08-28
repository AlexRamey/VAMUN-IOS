//
//  VAMControllerStore.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/26/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAMControllerStore : NSObject

@property (nonatomic, strong) NSMutableArray *activeViewControllers;

+(VAMControllerStore *)sharedInstance;

-(UINavigationController *)viewControllerForIndex:(int) index;

@end
