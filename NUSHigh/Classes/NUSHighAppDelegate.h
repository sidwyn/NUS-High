//
//  NUSHighAppDelegate.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NUSHighViewController;

@interface NUSHighAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
	NSDictionary *data;
	NSDictionary *data2;	
	NSDictionary *data3;
	NSMutableArray *altitudeArray;
}	

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSDictionary *data;
@property (nonatomic, retain) NSDictionary *data2;
@property (nonatomic, retain) NSDictionary *data3;
@property (nonatomic, retain) NSMutableArray *altitudeArray;


-(void)pushNewStaffNumber:(NSString *)number email:(NSString *)email name:(NSString *)name title:(NSString *)title;

@end

