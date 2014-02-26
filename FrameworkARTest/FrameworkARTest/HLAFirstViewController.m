//
//  HLAFirstViewController.m
//  FrameworkARTest
//
//  Created by Henri on 2/20/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "HLAFirstViewController.h"

@interface HLAFirstViewController ()

@end

@implementation HLAFirstViewController
@synthesize txtAlti, txtCourse, txtHori, txtSpeed, txtVerti, txtLat, txtLong, txtSF;

- (void)viewDidLoad
{
    [self startLocationUpdate];
    [self startRegionMonitoring];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *location = [locations lastObject];
    
    //check Apple's doc
    NSDate *eventDate = [location timestamp];
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        [txtLat setText:[NSString stringWithFormat:@" %f", location.coordinate.latitude]];
        [txtLong setText:[NSString stringWithFormat:@" %f", location.coordinate.longitude]];
        
        [txtAlti setText:[NSString stringWithFormat:@" %f", [location altitude]]];
        [txtCourse setText:[NSString stringWithFormat:@" %f", [location course]]];
        [txtHori setText:[NSString stringWithFormat:@" %f", [location horizontalAccuracy]]];
        [txtSpeed setText:[NSString stringWithFormat:@" %f", [location speed]]];
        [txtVerti setText:[NSString stringWithFormat:@" %f", [location verticalAccuracy]]];
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    [txtSF setText:@"YES"];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    [txtSF setText:@"NO"];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"ERROR : %@", [error description]);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"didUpdateHeading");
}

//Accuracy > Power
-(void)startLocationUpdate{
    
    if (locationManager == nil) {locationManager = [[CLLocationManager alloc] init];}
    
    [locationManager setDelegate:self];
    
    //locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //locationManager.distanceFilter = 5;
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"Location Services ENABLED");
    }else{ NSLog(@"Location Services DISABLED");}
    [locationManager startUpdatingLocation];
}

//Power > Accuracy
-(void)startSignificantLocationUpdate{
    
    if (locationManager == nil) {locationManager = [[CLLocationManager alloc] init];}
    [locationManager setDelegate:self];
    
    //locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //locationManager.distanceFilter = 5;
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"Location Services ENABLED");
    }else{ NSLog(@"Location Services DISABLED");}
    [locationManager startMonitoringSignificantLocationChanges];
}

-(void)startRegionMonitoring{
    
    if (locationManager == nil) {locationManager = [[CLLocationManager alloc] init];}
    [locationManager setDelegate:self];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(37.787359, -122.408227);
    
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:coord radius:1000.0 identifier:@"San Francisco"];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    [locationManager startMonitoringForRegion:region];
    
    //DEPRECATED
    //CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:coord radius:1000.0 identifier:@"San Francisco"];
    //[locationManager startMonitoringForRegion:region desiredAccuracy:kCLLocationAccuracyKilometer];
    
}



@end
