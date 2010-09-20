//
//  StaffDirectoryDetailController.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StaffDirectoryDetailController.h"


@implementation StaffDirectoryDetailController
@synthesize tempNum, tempEmail, number, email, tempTitle,reallyTemp;

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
	 tempTitle.text = reallyTemp;
	 tempTitle.font = [UIFont systemFontOfSize:18];
	 email.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	 self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	 [number setTitle:tempNum forState:UIControlStateNormal];
	 [email setTitle:tempEmail forState:UIControlStateNormal];
	 [super viewDidLoad];
 }
 


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


-(void)call:(id)sender{
	/**
	UIApplication *app = [UIApplication sharedApplication];
	NSString *urlString = [NSString stringWithFormat:@"tel:%i",[tempNum intValue]];
	NSURL *url = [NSURL URLWithString:urlString];
	[app openURL:url];
	 */
	NSString *urlString = [NSString stringWithFormat:@"tel://%i",[tempNum intValue]];
	

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(void)email:(id)sender{
	[self showEmailModalView];
}

-(void) showEmailModalView {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
	[picker setToRecipients:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@",tempEmail]]];

	NSString *emailBody = @"";

	[picker setMessageBody:emailBody isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)

	picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.

	[self presentModalViewController:picker animated:YES];
	[picker release];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{ 
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
			
		default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
			
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
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
    [super dealloc];
}


@end
