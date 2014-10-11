//
//  VAMMapViewController.m
//  VAMUN_Prototype-iOS
//
//  Created by Alex Ramey on 8/23/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "VAMMapViewController.h"
#import <MapKit/MapKit.h>

@interface VAMMapViewController ()
{
    CLLocationCoordinate2D lawnCoordinate;
}

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VAMMapViewController

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
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appToBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appReturnsActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [_locationManager startUpdatingLocation];
    [_activityIndicator startAnimating];
}

- (void)appToBackground
{
    [_mapView setShowsUserLocation:NO];
}

- (void)appReturnsActive
{
    [_mapView setShowsUserLocation:YES];
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - MKMapViewDelegate Methods

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //launch into directions . . .
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
    
    if ([reference distanceFromLocation:userInitialPosition] > 5000)
    {
        //If more than 5k from JeffTheater, just zoom the map to the middle of the downtown mall
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(lawnCoordinate, 500, 500);
        [_mapView setRegion:region animated:YES];
    }
    else //center on their position
    {
        CLLocationCoordinate2D coord = [userInitialPosition coordinate];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500, 500);
        [_mapView setRegion:region animated:YES];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_activityIndicator stopAnimating];
    [_locationManager stopUpdatingLocation];
    
    //In this case, just zoom the map to the middle of the UVA Lawn
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(lawnCoordinate, 500, 500);
    [_mapView setRegion:region animated:YES];
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
