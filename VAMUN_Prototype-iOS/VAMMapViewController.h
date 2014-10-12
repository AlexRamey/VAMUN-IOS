//
//  VAMMapViewController.h
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VAMContentViewController.h"

@interface VAMMapViewController : VAMContentViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray *buildingAnnotations;

@end
