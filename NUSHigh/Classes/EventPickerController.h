//
//  EventPickerController.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventPickerControllerDelegate;
@class TimetableController;

@interface EventPickerController : UIViewController <UITextFieldDelegate>{
	IBOutlet UINavigationBar *navBar;
	IBOutlet UINavigationItem *navItem;
	IBOutlet UIDatePicker *datePicker;
	IBOutlet UISegmentedControl *segmentedControl;
	TimetableController *delegate;
	NSString *startTime;
	NSString *endTime;
	IBOutlet UILabel *startLabel;
	IBOutlet UILabel *endLabel;
	IBOutlet UIButton *startButton;
	IBOutlet UIButton *endButton;
	NSInteger whoIsEditing;
	NSString *theTime;
	NSDateFormatter *timeFormat;
	
	IBOutlet UITextField *moduleName;
	IBOutlet UITextField *teacherName;
	IBOutlet UILabel *indicator;
}
@property (nonatomic,assign) TimetableController *delegate;

-(IBAction)startButton:(id)sender;
-(IBAction)finishedScrolling:(id)sender;
-(IBAction)endButton:(id)sender;

@end



@protocol EventPickerControllerDelegate <NSObject>
@optional
- (void)eventPickerControllerDidAddEvent:(EventPickerController *)eventPickerController addName:(NSString *)name addTeacher:(NSString *)teacher addDay:(int)day addTimeFrom:(NSString *)timeFrom addTimeTo:(NSString *)timeTo;
@end