//
//  HLAFourthViewController.h
//  FrameworkARTest
//
//  Created by Henri on 2/24/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HLAFourthViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (nonatomic, retain)IBOutlet UIImageView *compassImg;

@property (nonatomic, retain)IBOutlet UILabel *trueLbl;
@property (nonatomic, retain)IBOutlet UILabel *magneticLbl;
@property (nonatomic, retain)IBOutlet UILabel *orienLbl;


- (float)heading:(float)heading fromOrientation:(UIDeviceOrientation) orientation;
- (NSString *)stringFromOrientation:(UIDeviceOrientation) orientation;


@end
