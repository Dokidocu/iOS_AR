//
//  HLASecondViewController.m
//  FrameworkARTest
//
//  Created by Henri on 2/20/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "HLASecondViewController.h"

@interface HLASecondViewController ()

@end

@implementation HLASecondViewController
@synthesize myMapView, btnSegControl;

- (void)viewDidLoad
{
    [myMapView setDelegate:self];
    //[[self view]addSubview:mapView];
    
    [NSThread detachNewThreadSelector:@selector(displayMap) toTarget:self withObject:nil];
    //[self displayMap];
    [self setupSegmentedControl];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayMap{
    
    CLLocationCoordinate2D coords;
    coords.latitude = 37.33188;
    coords.longitude = -122.029497;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.002389, 0.005681);
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, span);
    
    //MapAnnotation
    HLAMapAnnotation *addAnnotation = [[HLAMapAnnotation alloc] initWithCoordinate:coords];
    [addAnnotation setTitletext:@"My Annotation Title"];
    [addAnnotation setSubtitletext:@"this is my subtitle property"];
    [myMapView addAnnotation:addAnnotation];
    
    //Map attributs
    [myMapView setZoomEnabled:YES];
    [myMapView setShowsBuildings:YES];
    [myMapView setShowsPointsOfInterest:YES];
    
    //Map 3D
    MKMapCamera *mapCamera = [[MKMapCamera alloc]init];
    [mapCamera setCenterCoordinate:coords];
    mapCamera.pitch = 45;
    mapCamera.altitude = 5;
    mapCamera.heading = 90; //NORTH
   
    
    [myMapView setCamera:mapCamera animated:YES];
    
    //[mapView setRegion:region animated:YES];
    
}

-(void)setupSegmentedControl{
    btnSegControl = [[UISegmentedControl alloc] initWithItems:[NSArray
              arrayWithObjects:@"Standard", @"Satellite", @"Hybrid", nil]];
    
    CGFloat screenWidth = [[UIScreen mainScreen]bounds].size.width;
    
    [btnSegControl setFrame:CGRectMake((screenWidth/2)-125, 50, 280-30, 30)];
    btnSegControl.selectedSegmentIndex = 0.0; // start by showing the normal picker
    
    [btnSegControl addTarget:self action:@selector(toggleToolBarChange:) forControlEvents:UIControlEventValueChanged];
    
    //Set style
    //btnSegControl.segmentedControlStyle = UIScrollViewIndicatorStyleWhite;
    
    
    btnSegControl.backgroundColor = [UIColor clearColor];
    btnSegControl.tintColor = [UIColor blueColor];
    
    [btnSegControl setAlpha:0.8];
    
    [self.view addSubview:btnSegControl];
}

-(void)toggleToolBarChange:(id)sender{
    UISegmentedControl *segCtrnl = sender;
    switch ([segCtrnl selectedSegmentIndex]) {
        case 0: //Map
            [myMapView setMapType:MKMapTypeStandard];
            break;
        case 1: { //Satellite
            
            CLLocation *myLocation = [[CLLocation alloc]initWithLatitude:37.33188 longitude:-122.029497];
            [self reverseGecode:myLocation];
            
            
            [myMapView setMapType:MKMapTypeSatellite];
            
            break;
        }
        case 2: //Hybrid
            [myMapView setMapType:MKMapTypeHybrid];
            break;
    }
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
    
    
}


-(void)reverseGecode:(CLLocation *)location{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        
        CLPlacemark *placemark = [placemarks lastObject];
        NSLog(@"VALUE : %@",[placemark addressDictionary]);
        
    }];
}

@end
