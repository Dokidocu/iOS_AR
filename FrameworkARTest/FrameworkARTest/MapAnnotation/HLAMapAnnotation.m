//
//  HLAMapAnnotation.m
//  FrameworkARTest
//
//  Created by Henri on 2/20/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "HLAMapAnnotation.h"


@implementation HLAMapAnnotation
@synthesize coordinate, subtitletext, titletext;

-(id)initWithCoordinate:(CLLocationCoordinate2D) localCoord{
    coordinate = localCoord;
    return self;
}
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPin"];
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    [annView setSelected:YES];
    annView.pinColor = MKPinAnnotationColorPurple;
    annView.calloutOffset = CGPointMake(-50, 5);
    return annView;
}

-(NSString *)subtitle{
    return subtitletext;
}

-(NSString *)title{
    return titletext;
}

-(void)setTitle:(NSString *)strTitle{
    self.titletext = strTitle;
}

-(void)setSubTitle:(NSString *)strSubTitle{
    self.subtitletext = strSubTitle;
}

@end
