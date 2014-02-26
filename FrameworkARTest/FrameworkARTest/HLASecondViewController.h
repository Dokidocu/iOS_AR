//
//  HLASecondViewController.h
//  FrameworkARTest
//
//  Created by Henri on 2/20/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "HLAMapAnnotation.h"

@interface HLASecondViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *btnSegControl;

@end
