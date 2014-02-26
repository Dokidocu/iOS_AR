//
//  HLAThirdViewController.m
//  FrameworkARTest
//
//  Created by Henri on 2/23/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "HLAThirdViewController.h"

@interface HLAThirdViewController ()

@end

@implementation HLAThirdViewController
@synthesize xLbl, yLbl, zLbl, xProgView, yProgView, zProgView;
@synthesize xRLbl, yRLbl, zRLbl, xRProgView, yRProgView, zRProgView;
@synthesize xGLbl, yGLbl, zGLbl;
@synthesize xALbl, yALbl, zALbl;

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
 
    motionManager = [[CMMotionManager alloc]init];
    [self accelerometerBlock];
    [self rotationBlock];
    [self gravityAndAttitudeBlock];
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)accelerometerBlock{
    [motionManager setAccelerometerUpdateInterval:0.5];
    if ([motionManager isAccelerometerAvailable]) {
        queue = [NSOperationQueue currentQueue];
        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error){
            
            CMAcceleration myAcce = [accelerometerData acceleration];
            [xLbl setText:[NSString stringWithFormat:@"%f", myAcce.x]];
            [xProgView setProgress:(ABS(myAcce.x))];
            
            [yLbl setText:[NSString stringWithFormat:@"%f", myAcce.y]];
            [yProgView setProgress:(ABS(myAcce.y))];
            
            [zLbl setText:[NSString stringWithFormat:@"%f", myAcce.z]];
            [zProgView setProgress:(ABS(myAcce.z))];
            
            //Device is shaking ?
            double const kThreshold = 2.0; // 2G is typical to measure shaking
            if (ABS(myAcce.x) > kThreshold
                || ABS(myAcce.y) > kThreshold
                || ABS(myAcce.z) > kThreshold) {
                NSLog(@"Shake Detected !");
            }
            
            
        }];
    }
}

-(void)rotationBlock{
    [motionManager setGyroUpdateInterval:0.5];
    if ([motionManager isGyroAvailable]) {
        queue = [NSOperationQueue currentQueue];
        [motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData, NSError *error){
            
            CMRotationRate cmRot = [gyroData rotationRate];
            [xRLbl setText:[NSString stringWithFormat:@"%f", cmRot.x]];
            [xRProgView setProgress:(ABS(cmRot.x))];
            
            [yRLbl setText:[NSString stringWithFormat:@"%f", cmRot.y]];
            [yRProgView setProgress:(ABS(cmRot.y))];
            
            [zRLbl setText:[NSString stringWithFormat:@"%f", cmRot.z]];
            [zRProgView setProgress:(ABS(cmRot.z))];
            
            
        }];
    }
}

-(void)gravityAndAttitudeBlock{
    [motionManager setDeviceMotionUpdateInterval:0.5];
    if ([motionManager isDeviceMotionAvailable]) {
        queue = [NSOperationQueue currentQueue];
        [motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *motion, NSError *error){
            
            CMAcceleration acc = [motion gravity];
            [xGLbl setText:[NSString stringWithFormat:@"%f", acc.x]];
            [yGLbl setText:[NSString stringWithFormat:@"%f", acc.y]];
            [zGLbl setText:[NSString stringWithFormat:@"%f", acc.z]];
            
            CMAttitude *att = [motion attitude];
            [xALbl setText:[NSString stringWithFormat:@"%f", att.pitch]];
            [yALbl setText:[NSString stringWithFormat:@"%f", att.roll]];
            [zALbl setText:[NSString stringWithFormat:@"%f", att.yaw]];
            
        }];
    }
}



@end
