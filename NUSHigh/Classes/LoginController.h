//
//  LoginController.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginController : UIViewController <UITextFieldDelegate> {
	IBOutlet UISegmentedControl *segmentedControl;
	NSString *staff;
	NSString *student;
	NSString *guest;
	NSString *choice;
	NSString *tempUser;
	NSString *tempPass;
}

@property (nonatomic,retain) IBOutlet UITextField *username;
@property (nonatomic,retain) IBOutlet UITextField *password;


- (IBAction)save:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)reset:(id)sender;


@end
