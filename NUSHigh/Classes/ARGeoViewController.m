//
//  ARGeoViewController.m
//  ARKitDemo
//
//  Created by Zac White on 8/2/09.
//  Copyright 2009 Zac White. All rights reserved.
//

#import "ARGeoViewController.h"

#import "ARGeoCoordinate.h"

@implementation ARGeoViewController

@synthesize centerLocation;

- (void)setCenterLocation:(CLLocation *)newLocation {
	[centerLocation release];
	centerLocation = [newLocation retain];
	
	UILabel *button = [[UILabel alloc] init];
	button.text = @"Tap to return";
	button.frame = CGRectMake(0,460,320,20);
//	[button setTitle:@"Tap to return" forState:UIControlStateNormal];
	[self.view addSubview:button];
	
	
	for (ARGeoCoordinate *geoLocation in self.coordinates) {
		if ([geoLocation isKindOfClass:[ARGeoCoordinate class]]) {
			[geoLocation calibrateUsingOrigin:centerLocation];
			
			if (geoLocation.radialDistance > self.maximumScaleDistance) {
				self.maximumScaleDistance = geoLocation.radialDistance;
			}
		}
	}
}


@end
