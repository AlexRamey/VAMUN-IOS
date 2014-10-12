//
//  VAMBuilding.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 10/12/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface VAMBuilding : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D latLng;
    NSString *buildingName;
}


-(id)initWithCoordinate:(CLLocationCoordinate2D) coord buildingName:(NSString *)name;

//Required property from MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//Optional properties from MKAnnotation
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
