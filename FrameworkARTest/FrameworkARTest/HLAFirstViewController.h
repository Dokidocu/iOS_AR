//
//  HLAFirstViewController.h
//  FrameworkARTest
//
//  Created by Henri on 2/20/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HLAFirstViewController : UIViewController <CLLocationManagerDelegate>{
    //UITextView *locationTextView;
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet UILabel *txtSF;
@property (nonatomic, retain) IBOutlet UILabel *txtLat;
@property (nonatomic, retain) IBOutlet UILabel *txtLong;
@property (nonatomic, retain) IBOutlet UILabel *txtAlti;
@property (nonatomic, retain) IBOutlet UILabel *txtHori;
@property (nonatomic, retain) IBOutlet UILabel *txtVerti;
@property (nonatomic, retain) IBOutlet UILabel *txtSpeed;
@property (nonatomic, retain) IBOutlet UILabel *txtCourse;

-(void)startLocationUpdate;//Accuracy > Power
-(void)startSignificantLocationUpdate;// Power > Accuracy
-(void)startRegionMonitoring;//Area -> Current Position ==> Enter? Exit?


@end
