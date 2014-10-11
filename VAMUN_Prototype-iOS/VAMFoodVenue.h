//
//  VAMFoodVenue.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/11/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VAMFoodVenue : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *venueDescription;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSNumber *isSponsor;
@property (nonatomic, strong) NSNumber *isOnGrounds;

@end
