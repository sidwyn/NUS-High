//
//  StaffDirectoryDetailController.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface StaffDirectoryDetailController : UIViewController <MFMailComposeViewControllerDelegate> {
	UIButton *number;
	UIButton *email;	
	NSString *tempNum;
	NSString *tempEmail;
	UILabel *tempTitle;
	NSString *reallyTemp;
}


@property (nonatomic, retain) IBOutlet UIButton *number;
@property (nonatomic, retain) IBOutlet UIButton *email;
@property (nonatomic, retain) IBOutlet UILabel *tempTitle;
@property (nonatomic, retain) NSString *tempNum;
@property (nonatomic, retain) NSString *tempEmail;

@property (nonatomic, retain) NSString *reallyTemp;

-(void)call:(id)sender;
-(void)email:(id)sender;
-(void)showEmailModalView;

@end
