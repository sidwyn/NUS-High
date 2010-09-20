//
//  EventPickerController.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventPickerController.h"

@implementation EventPickerController

@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	indicator.text = @"";
	whoIsEditing = 0;
	startTime = @"12:00";
	endTime = @"12:00";
	
	moduleName.delegate=self;
	teacherName.delegate=self;
	
	timeFormat = [[NSDateFormatter alloc] init];
	[timeFormat setDateFormat:@"HH:mm"];
	
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
	navItem.leftBarButtonItem = button;
	[button release];
	
	
	UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addItem)];
	navItem.rightBarButtonItem = button2;
	[button2 release];
}


- (BOOL)textFieldShouldReturn: (UITextField *)textField {
	if(textField == moduleName){
		NSInteger nextTag = textField.tag + 1;
		// Try to find next responder
		UIResponder* nextResponder = [self.view viewWithTag:nextTag];
		if (nextResponder) {
			// Found next responder, so set it.
			[nextResponder becomeFirstResponder];
		} else {
			// Not found, so remove keyboard.
			[textField resignFirstResponder];
		}
	}
	else{
		[textField resignFirstResponder];
	}
	return YES;
}

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
	indicator.text = @"";
	for (UIView* view in self.view.subviews) {
		if ([view isKindOfClass:[UITextField class]])
			[view resignFirstResponder];
	}
}

-(void)goBack {
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)startButton:(id)sender{
	whoIsEditing = 1;
	indicator.text = @"starts:";
	for (UIView* view in self.view.subviews) {
		if ([view isKindOfClass:[UITextField class]])
			[view resignFirstResponder];
	}
}


-(IBAction)endButton:(id)sender{
	whoIsEditing = 2;
	indicator.text = @"ends:";
	for (UIView* view in self.view.subviews) {
		if ([view isKindOfClass:[UITextField class]])
			[view resignFirstResponder];
	}
}

-(IBAction)finishedScrolling:(id)sender{
	NSLog(@"I'm changing");
	theTime = [timeFormat stringFromDate:[datePicker date]];

	if(whoIsEditing == 1){
		startTime = theTime;
		startLabel.text = theTime;
	}
	if(whoIsEditing == 2){
		endTime = theTime;
		endLabel.text = theTime;
	}
}

- (void)addItem{
	int day = segmentedControl.selectedSegmentIndex;
	NSLog(@"Checking");
	NSLog(@"%@",moduleName.text);
	NSLog(@"%@",teacherName.text);
	NSLog(@"%@",startTime);
	NSLog(@"%@",endTime);
	NSLog(@"%i",day);
	NSLog(@"%@, %@, %i, %@, %@",moduleName.text,teacherName.text,day,startTime,endTime);
	if([self.delegate respondsToSelector:@selector(eventPickerControllerDidAddEvent:addName:addTeacher:addDay:addTimeFrom:addTimeTo:)]){
		[self.delegate eventPickerControllerDidAddEvent:self addName:moduleName.text addTeacher:teacherName.text addDay:day addTimeFrom:startTime addTimeTo:endTime];
	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[theTime release];
	[timeFormat release];
    [super dealloc];
}


@end
