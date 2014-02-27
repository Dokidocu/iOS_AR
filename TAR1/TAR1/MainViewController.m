//
//  MainViewController.m
//  TAR1
//
//  Created by Henri on 2/25/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "MainViewController.h"
#import "Place.h"
#import "PlaceAnnotation.h"

NSString * const kNameKey = @"name";
NSString * const kReferenceKey = @"reference";
NSString * const kAddressKey = @"vicinity";
NSString * const kLatitudeKeypath = @"geometry.location.lat";
NSString * const kLongitudeKeypath = @"geometry.location.lng";

@interface MainViewController ()

@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *locations;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _locationManager = [[CLLocationManager alloc]init];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager startUpdatingLocation];
    //[_mapView setMapType:MKMapTypeHybrid];
   
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipSideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        [[segue destinationViewController] setLocations:_locations];
        [[segue destinationViewController] setUserLocation:[_mapView userLocation]];
    }
}

#pragma mark - CLLocationDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	CLLocation *lastLocation = [locations lastObject];
	
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
	
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
	
	if(accuracy < 100.0) {
		MKCoordinateSpan span = MKCoordinateSpanMake(0.14, 0.14);
		MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
		
        [_mapView setShowsUserLocation:YES];
        
        MKUserLocation *me = [[MKUserLocation alloc]init];
        [_mapView addAnnotation:me];
        
		[_mapView setRegion:region animated:YES];
        [[PlacesLoader sharedInstance]loadPOIsForLocation:lastLocation radius:5000 successHandler:^(NSDictionary *response){
            NSLog(@"Response: %@", response);
			if([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
				id places = [response objectForKey:@"results"];
				NSMutableArray *temp = [NSMutableArray array];
				
				if([places isKindOfClass:[NSArray class]]) {
					for(NSDictionary *resultsDict in places) {
						CLLocation *location = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:kLatitudeKeypath] floatValue] longitude:[[resultsDict valueForKeyPath:kLongitudeKeypath] floatValue]];
						Place *currentPlace = [[Place alloc] initWithLocation:location reference:[resultsDict objectForKey:kReferenceKey] name:[resultsDict objectForKey:kNameKey] address:[resultsDict objectForKey:kAddressKey]];
						[temp addObject:currentPlace];
						
						PlaceAnnotation *annotation = [[PlaceAnnotation alloc] initWithPlace:currentPlace];
						[_mapView addAnnotation:annotation];
					}
				}
                
				_locations = [temp copy];
				
				NSLog(@"Locations: %@", _locations);
			}
        } errorHandler:^(NSError *error){
            NSLog(@"Error: %@", error);

        }];
        
        [manager stopUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
