//
//  HLAFourthViewController.m
//  FrameworkARTest
//
//  Created by Henri on 2/24/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "HLAFourthViewController.h"

@interface HLAFourthViewController ()

@end

@implementation HLAFourthViewController
@synthesize magneticLbl, trueLbl;
@synthesize compassImg;
@synthesize orienLbl;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    locationManager = [[CLLocationManager alloc]init];
    [locationManager setDelegate:self];
    [locationManager setHeadingFilter:5];
    
    if ([CLLocationManager locationServicesEnabled]
        && [CLLocationManager headingAvailable]) {
        [locationManager startUpdatingHeading];
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"Error starting location updates");
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    
    if ([newHeading headingAccuracy] > 0) {
        
        //float magneticHeading = [newHeading magneticHeading];
        //float trueHeading = [newHeading trueHeading];
        
        UIDevice *device = [UIDevice currentDevice];
        [orienLbl setText:[self stringFromOrientation:[device orientation]]];
        
        float magneticHeading = [self heading:[newHeading magneticHeading] fromOrientation:[device orientation]];
        float trueHeading = [self heading:[newHeading trueHeading] fromOrientation:[device orientation]];
        
        
        [magneticLbl setText:[NSString stringWithFormat:@"%f", magneticHeading]];
        [trueLbl setText:[NSString stringWithFormat:@"%f", trueHeading]];
        
        float heading = -1.0f * M_PI * magneticHeading / 180.0f;
        [compassImg setTransform:CGAffineTransformMakeRotation(heading)];
        
    }
    
}


- (float)heading:(float)heading fromOrientation:(UIDeviceOrientation) orientation{
    
    float correctedHeading = heading;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            correctedHeading = heading + 180.0f;
            break;
        case UIDeviceOrientationLandscapeLeft:
            correctedHeading = heading + 90.0f;
            break;
        case UIDeviceOrientationLandscapeRight:
            correctedHeading = heading - 90.0f;
            break;
        default:
            break;
    }
    
    while (heading > 360.0f) {
        correctedHeading = heading - 360;
    }
    
    return correctedHeading;
}
- (NSString *)stringFromOrientation:(UIDeviceOrientation) orientation{
    
    NSString *orientationString;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            orientationString = @"Portrait";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientationString = @"Portrait Upside Down";
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientationString = @"Landscape Left";
            break;
        case UIDeviceOrientationLandscapeRight:
            orientationString = @"Landscape Right";
            break;
        case UIDeviceOrientationFaceUp:
            orientationString = @"Face Up";
            break;
        case UIDeviceOrientationFaceDown:
            orientationString = @"Face Down";
            break;
        case UIDeviceOrientationUnknown:
            orientationString = @"Unknown";
        default:
            orientationString = @"Not Known";
            break;
    }
    return orientationString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
