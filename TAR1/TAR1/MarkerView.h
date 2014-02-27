//
//  MarkerView.h
//  TAR1
//
//  Created by Henri on 2/26/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARGeoCoordinate;
@protocol MarkerViewDelegate;


@interface MarkerView : UIView

@property (nonatomic, strong) ARGeoCoordinate *coordinate;
@property (nonatomic, weak) id <MarkerViewDelegate> delegate;

- (id)initWithCoordinate:(ARGeoCoordinate *)coordinate delegate:(id<MarkerViewDelegate>)delegate;

@end

@protocol MarkerViewDelegate <NSObject>

- (void)didTouchMarkerView:(MarkerView *)markerView;

@end