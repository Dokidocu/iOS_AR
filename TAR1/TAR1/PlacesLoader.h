//
//  PlacesLoader.h
//  TAR1
//
//  Created by Henri on 2/25/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@class Place;

typedef void (^SuccessHandler)(NSDictionary *responseDict);
typedef void (^ErrorHandler)(NSError *error);

@interface PlacesLoader : NSObject<NSURLConnectionDataDelegate>

+ (PlacesLoader *)sharedInstance;

- (void)loadPOIsForLocation:(CLLocation *)location radius:(int)radius successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;
- (void)loadDetailInformation:(Place *)location successHanlder:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;


@end
