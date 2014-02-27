//
//  Place.m
//  TAR1
//
//  Created by Henri on 2/25/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "Place.h"

@implementation Place

- (instancetype)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address{
    
    self = [super init];
    
    if(self) {
		_location = location;
		_reference = reference;
		_placeName = name;
		_address = address;
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ Name:%@, location:%@", [super description], _placeName, _location];
}

- (NSString *)infoText {
	return [NSString stringWithFormat:@"Name:%@\nAddress:%@\nPhone:%@\nWeb:%@", _placeName, _address, _phoneNumber, _website];
}

@end
