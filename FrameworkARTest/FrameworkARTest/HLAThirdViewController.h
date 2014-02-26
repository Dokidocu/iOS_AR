//
//  HLAThirdViewController.h
//  FrameworkARTest
//
//  Created by Henri on 2/23/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface HLAThirdViewController : UIViewController{
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}


@property (nonatomic, retain) IBOutlet UILabel *xLbl;
@property (nonatomic, retain) IBOutlet UILabel *yLbl;
@property (nonatomic, retain) IBOutlet UILabel *zLbl;

@property (nonatomic, retain) IBOutlet UIProgressView *xProgView;
@property (nonatomic, retain) IBOutlet UIProgressView *yProgView;
@property (nonatomic, retain) IBOutlet UIProgressView *zProgView;


@property (nonatomic, retain) IBOutlet UILabel *xRLbl;
@property (nonatomic, retain) IBOutlet UILabel *yRLbl;
@property (nonatomic, retain) IBOutlet UILabel *zRLbl;

@property (nonatomic, retain) IBOutlet UIProgressView *xRProgView;
@property (nonatomic, retain) IBOutlet UIProgressView *yRProgView;
@property (nonatomic, retain) IBOutlet UIProgressView *zRProgView;

@property (nonatomic, retain) IBOutlet UILabel *xGLbl;
@property (nonatomic, retain) IBOutlet UILabel *yGLbl;
@property (nonatomic, retain) IBOutlet UILabel *zGLbl;

@property (nonatomic, retain) IBOutlet UILabel *xALbl;
@property (nonatomic, retain) IBOutlet UILabel *yALbl;
@property (nonatomic, retain) IBOutlet UILabel *zALbl;

@end
