//
//  NUSHighAppDelegate.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "NUSHighAppDelegate.h"
#import "NUSHighViewController.h"
#import "StaffDirectoryController.h"
#import "StaffDirectoryDetailController.h"

@implementation NUSHighAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize data, data2,data3, altitudeArray;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

	//Initialise data
	NSString *Path = [[NSBundle mainBundle] bundlePath];
	NSString *DataPath = [Path stringByAppendingPathComponent:@"Data.plist"];
	NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:DataPath];
	self.data = tempDict;
	[tempDict release];
	
	
	NSString *Path2 = [[NSBundle mainBundle] bundlePath];
	NSString *DataPath2 = [Path2 stringByAppendingPathComponent:@"Links.plist"];
	
	NSDictionary *tempDict2 = [[NSDictionary alloc] initWithContentsOfFile:DataPath2];
	self.data2 = tempDict2;
	[tempDict2 release];
	
	
	NSString *Path3 = [[NSBundle mainBundle] bundlePath];
	NSString *DataPath3 = [Path3 stringByAppendingPathComponent:@"Calendar.plist"];
	
	NSDictionary *tempDict3 = [[NSDictionary alloc] initWithContentsOfFile:DataPath3];
	self.data3 = tempDict3;
	[tempDict3 release];
	
	altitudeArray = [[NSMutableArray alloc] init];
	
	
	//Controller stuff
	navigationController = [[UINavigationController alloc]init];
	
	NUSHighViewController *viewController = [[NUSHighViewController alloc]init];
	[navigationController pushViewController:viewController animated:YES];
	[viewController release];
	
    // Override point for customization after app launch    
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}


-(void)pushNewStaffNumber:(NSString *)number email:(NSString *)email name:(NSString *)name title:(NSString *)title{
	StaffDirectoryDetailController *staffDirectoryDetailController = [[StaffDirectoryDetailController alloc] init];
	staffDirectoryDetailController.tempNum = number;
	staffDirectoryDetailController.tempEmail = email;
	staffDirectoryDetailController.title = name;
	staffDirectoryDetailController.reallyTemp = title;
	[self.navigationController pushViewController:staffDirectoryDetailController animated:YES];
	[staffDirectoryDetailController release];
}

- (void)dealloc {
	[data release];
	[data2 release];
    [navigationController release];
    [window release];
    [super dealloc];
}


@end
