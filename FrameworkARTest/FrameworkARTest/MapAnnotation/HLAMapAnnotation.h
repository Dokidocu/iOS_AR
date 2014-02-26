//
//  HLAMapAnnotation.h
//  FrameworkARTest
//
//  Created by Henri on 2/20/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HLAMapAnnotation : NSObject<MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (readwrite, retain) NSString *titletext;
@property (readwrite, retain) NSString *subtitletext;

-(id)initWithCoordinate:(CLLocationCoordinate2D) localCoord;
- (NSString *)subtitle;
- (NSString *)title;
-(void)setTitle:(NSString*)strTitle;
-(void)setSubTitle:(NSString*)strSubTitle;


@end
