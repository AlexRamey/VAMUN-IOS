//
//  VAMBuilding.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/12/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMBuilding.h"

@implementation VAMBuilding

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord buildingName:(NSString *)name
{
    self = [super init];
    
    if (self)
    {
        latLng = coord;
        buildingName = name;
    }
    
    return self;
}

#pragma mark - MKAnnotation Protocol Properties

-(CLLocationCoordinate2D)coordinate
{
    return latLng;
}

-(NSString *)title
{
    return buildingName;
}

-(NSString *)subtitle
{
    return @"Tap for Directions";
}

-(void)setSubtitle:(NSString *)subtitle
{
    return;
}

@end
