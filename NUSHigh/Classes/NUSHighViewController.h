//
//  NUSHighViewController.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ARGeoViewController.h"
#import <MessageUI/MessageUI.h>

@interface NUSHighViewController : UIViewController <MFMailComposeViewControllerDelegate, ARViewDelegate>{

}

@property (nonatomic,retain) IBOutlet UIButton *staff;
@property (nonatomic,retain) IBOutlet UIButton *links;
@property (nonatomic,retain) IBOutlet UIButton *timetable;
@property (nonatomic,retain) IBOutlet UIButton *login;
@property (nonatomic,retain) IBOutlet UIButton *mailme;
@property (nonatomic,retain) IBOutlet UIButton *info;


-(IBAction)pushLinks:(id)sender;
-(IBAction)pushStaff:(id)sender;
-(IBAction)pushTimetable:(id)sender;
-(IBAction)pushLogin:(id)sender;
-(IBAction)email:(id)sender;
-(IBAction)cheat:(id)sender;
- (IBAction)feedbackChannel:(id)sender;
-(void)showEmailModalView;
-(IBAction)pushAR:(id)sender;
- (UIView *)viewForCoordinate:(ARCoordinate *)coordinate;


@end

