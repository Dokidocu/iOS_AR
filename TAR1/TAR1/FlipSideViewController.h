//
//  FlipSideViewController.h
//  TAR1
//
//  Created by Henri on 2/26/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import "ARKit.h"
#import "Place.h"

@class FlipSideViewController;

@protocol FlipSideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipSideViewController *)controller;
@end

@interface FlipSideViewController : UIViewController<ARLocationDelegate, ARDelegate, ARMarkerDelegate>

@property (weak, nonatomic) id <FlipSideViewControllerDelegate> delegate;

@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) MKUserLocation *userLocation;

- (IBAction)done:(id)sender;

- (void)generateGeoLocations;

@end
