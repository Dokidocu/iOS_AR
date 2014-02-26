//
//  PlaceAnnotation.m
//  TAR1
//
//  Created by Henri on 2/25/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "Place.h"

@interface PlaceAnnotation()

@property (nonatomic, strong) Place *place;

@end


@implementation PlaceAnnotation

- (id)initWithPlace:(Place *)place{
    if((self = [super init])) {
		_place = place;
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate{
    return [_place location].coordinate;
}

- (NSString *)title{
    return [_place placeName];
}


@end
