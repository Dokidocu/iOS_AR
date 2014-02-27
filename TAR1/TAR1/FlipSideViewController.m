//
//  FlipSideViewController.m
//  TAR1
//
//  Created by Henri on 2/26/14.
//  Copyright (c) 2014 Henri. All rights reserved.
//

#import "FlipSideViewController.h"
#import "MarkerView.h"
#import "PlacesLoader.h"

NSString * const kPhoneKey = @"formatted_phone_number";
NSString * const kWebsiteKey = @"website";
const int kInfoViewTag = 1001;

@interface FlipSideViewController ()<MarkerViewDelegate>

@property (nonatomic, strong) AugmentedRealityController *arController;
@property (nonatomic, strong) NSMutableArray *geoLocations;

@end

@implementation FlipSideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if (!_arController) {
        _arController = [[AugmentedRealityController alloc]initWithView:[self view] parentViewController:self withDelgate:self];
    }
    [_arController setMinimumScaleFactor:0.5];
    [_arController setScaleViewsBasedOnDistance:YES];
    [_arController setRotateViewsBasedOnPerspective:YES];
    [_arController setDebugMode:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self geoLocations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AR delegate

-(void)locationClicked:(ARGeoCoordinate *)coordinate{
    
}

-(void)didUpdateOrientation:(UIDeviceOrientation)orientation{
    
}

-(void)didUpdateHeading:(CLHeading *)newHeading{
    
}

-(void)didTapMarker:(ARGeoCoordinate *)coordinate{
    
}

-(void)didUpdateLocation:(CLLocation *)newLocation{
    
}

-(NSMutableArray *)geoLocations{
    if(!_geoLocations) {
		[self generateGeoLocations];
	}
	return _geoLocations;
}

#pragma mark - Methods
- (IBAction)done:(id)sender {
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)generateGeoLocations{
    
    [self setGeoLocations:[NSMutableArray arrayWithCapacity:[_locations count]]];
    
    for (Place *place in _locations) {
        ARGeoCoordinate *coordinate = [ARGeoCoordinate coordinateWithLocation:[place location] locationTitle:[place placeName]];
        
        [coordinate calibrateUsingOrigin:[_userLocation location]];
        
        //...
        
        MarkerView *markerView = [[MarkerView alloc] initWithCoordinate:coordinate delegate:self];
        [coordinate setDisplayView:markerView];
        
        [_arController addCoordinate:coordinate];
        [_geoLocations addObject:coordinate];
    }
}

- (void)didTouchMarkerView:(MarkerView *)markerView {
	//1
	ARGeoCoordinate *tappedCoordinate = [markerView coordinate];
	CLLocation *location = [tappedCoordinate geoLocation];
    
	//2
	NSUInteger index = [_locations indexOfObjectPassingTest:^(id obj, NSUInteger index, BOOL *stop) {
        return [[(Place *)obj location]isEqual:location ];
        //return [[obj location] isEqual:location];
	}];

    
	//3
	if(index != NSNotFound) {
		//4
		Place *tappedPlace = [_locations objectAtIndex:index];
		[[PlacesLoader sharedInstance] loadDetailInformation:tappedPlace successHanlder:^(NSDictionary *response) {
			//5
			NSLog(@"Response: %@", response);
			NSDictionary *resultDict = [response objectForKey:@"result"];
			[tappedPlace setPhoneNumber:[resultDict objectForKey:kPhoneKey]];
			[tappedPlace setWebsite:[resultDict objectForKey:kWebsiteKey]];
			[self showInfoViewForPlace:tappedPlace];
		} errorHandler:^(NSError *error) {
			NSLog(@"Error: %@", error);
		}];
	}
}

- (void)showInfoViewForPlace:(Place *)place {
	CGRect frame = [[self view] frame];
	UITextView *infoView = [[UITextView alloc] initWithFrame:CGRectMake(50.0f, 50.0f, frame.size.width - 100.0f, frame.size.height - 100.0f)];
	[infoView setCenter:[[self view] center]];
	[infoView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
	//1
	[infoView setText:[place infoText]];
	[infoView setTag:kInfoViewTag];
	[infoView setEditable:NO];
    
	[[self view] addSubview:infoView];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UIView *infoView = [[self view] viewWithTag:kInfoViewTag];
    
	[infoView removeFromSuperview];
}
@end
