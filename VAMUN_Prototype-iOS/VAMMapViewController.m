//
//  VAMMapViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMMapViewController.h"
#import <MapKit/MapKit.h>
#import "VAMBuilding.h"
#import "VAMAnnotationView.h"

@interface VAMMapViewController ()
{
    CLLocationCoordinate2D lawnCoordinate;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VAMMapViewController

static NSString * const VAMUN_PIN_IDENTIFIER = @"VAMUN_PIN_IDENTIFIER";

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager requestWhenInUseAuthorization];
        
        lawnCoordinate = CLLocationCoordinate2DMake(38.035400, -78.503398);
        
        NSMutableArray *buildings = [[NSMutableArray alloc] init];
        
        NSData *uvaBuildingJSONData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UVABuilding" ofType:@"json"]];
        NSError *error = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:uvaBuildingJSONData options:NSJSONReadingMutableContainers error:&error];
        NSArray *buildingObjectDictionary = [jsonObject objectForKey:@"results"];
        
        for (NSDictionary *dictionary in buildingObjectDictionary)
        {
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[dictionary objectForKey:@"Latitude"] doubleValue], [[dictionary objectForKey:@"Longitude"] doubleValue]);
            VAMBuilding *bld = [[VAMBuilding alloc] initWithCoordinate:coord buildingName:[dictionary objectForKey:@"Name"]];
            [buildings addObject:bld];
        }
        _buildingAnnotations = buildings;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (VAMBuilding *b in _buildingAnnotations)
    {
        [_mapView addAnnotation:b];
    }
    
    [_mapView setMapType:MKMapTypeHybrid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    //No need to set mapView's delegate property to nil because mapView will be destroyed when this gets destroyed b/c this alone holds the mapView's superview with a strong reference
    //Same for the location manager
}

#pragma mark - MKMapViewDelegate Methods

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[VAMBuilding class]])
    {
        //Get primary category of the venue that the annotation represents
        NSString *reuseIdentifier = VAMUN_PIN_IDENTIFIER;
        
        //Try to dequeue an existing pin first
        VAMAnnotationView *pinView = (VAMAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (!pinView)
        {
            pinView = [[VAMAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        }
        else
        {
            pinView = [pinView initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        }
        
        return pinView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //These options will launch a hybrid map with superimposed traffic information that provides walking directions
    NSDictionary *mapOptions = @{
                   MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking,
                   MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeHybrid],
                   MKLaunchOptionsShowsTrafficKey:@"YES"
                   };
    
    Class itemClass = [MKMapItem class];
    if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
        
        //Create placemark object, which will be used to create MKMapItem object
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:view.annotation.coordinate addressDictionary:nil];
        
        //By default, if one map item is provided, then directions are provided from current location to the map item
        MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        [destination setName:view.annotation.title];
        
        NSArray *param = [[NSArray alloc] initWithObjects:destination, nil];
        
        //Launch maps
        if (mapOptions)
        {
            [MKMapItem openMapsWithItems:param launchOptions:mapOptions];
        }
        
    }
    else
    {
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Directions Unavailable" message:@"Update." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [a show];
    }
}

-(void)spotlightMarkerWithTitleContainedIn:(NSString *)string
{
    NSArray *annotations = [_mapView annotations];
    for (VAMBuilding *b in annotations)
    {
        //MKUserLocation (Blue Dot) is an annotation on which .parseObjectID is an unrecognized selector
        if ([b class] != [VAMBuilding class])
        {
            continue;
        }
        
        if ([string containsString:b.title])
        {
            [_mapView setRegion:MKCoordinateRegionMakeWithDistance(b.coordinate, 50, 50) animated:YES];
            [_mapView selectAnnotation:b animated:YES];
            break;
        }
    }
}

#pragma mark - CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_activityIndicator stopAnimating];
    [_locationManager stopUpdatingLocation];
    
    //Get most recent location update
    CLLocation* userInitialPosition = [locations objectAtIndex:([locations count]-1)];
    
    //Create a CLLocation at UVA's lawn
    CLLocation *reference = [[CLLocation alloc] initWithLatitude:lawnCoordinate.latitude longitude:lawnCoordinate.longitude];
    
    if ([reference distanceFromLocation:userInitialPosition] > 1600)
    {
        //If more than 1 mile from rotunda, just zoom the map to the rotunda
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(lawnCoordinate, 750, 750);
        [_mapView setRegion:region animated:YES];
    }
    else //center on their position
    {
        CLLocationCoordinate2D coord = [userInitialPosition coordinate];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 750, 750);
        [_mapView setRegion:region animated:YES];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_activityIndicator stopAnimating];
    [_locationManager stopUpdatingLocation];
    
    //In this case, just zoom the map to the middle of the UVA Lawn
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(lawnCoordinate, 750, 750);
    [_mapView setRegion:region animated:YES];
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusDenied)
    {
        [_mapView setShowsUserLocation:NO];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(lawnCoordinate, 750, 750);
        [_mapView setRegion:region animated:YES];
    }
    else if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [_mapView setShowsUserLocation:YES];
        [_locationManager startUpdatingLocation];
        [_activityIndicator startAnimating];
    }
    else
    {
        //do nothing
    }
}

-(IBAction)centerMap:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.frame.origin.x == _centerUserBtn.frame.origin.x)
    {
        if ([_mapView userLocation])
        {
            [_mapView setCenterCoordinate:[[[_mapView userLocation] location] coordinate] animated:YES];
        }
    }
    else
    {
        [_mapView setCenterCoordinate:lawnCoordinate animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
