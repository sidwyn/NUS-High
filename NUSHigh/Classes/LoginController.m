//
//  LoginController.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"

@implementation LoginController

@synthesize username, password;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibNaminfoe:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *pword = [prefs objectForKey:@"password"];
    password.text = pword;
    NSString *uname = [prefs objectForKey:@"username"];
    username.text = uname;
	NSString *tempIndex = [prefs objectForKey:@"choice"];
	segmentedControl.selectedSegmentIndex = [tempIndex intValue];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	staff = @"nusstf";
	student = @"nusstu";
	guest = @"nusext";
	username.delegate = self;
	password.delegate = self;
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	self.navigationItem.title = @"NUSOPEN Login";
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (BOOL)textFieldShouldReturn: (UITextField *)textField {
	if(textField == username){
		NSInteger nextTag = textField.tag + 1;
		// Try to find next responder
		UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
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
		for (UIView* view in self.view.subviews) {
			if ([view isKindOfClass:[UITextField class]])
				   [view resignFirstResponder];
		}
	}
	   
- (IBAction)save:(id)sender{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:password.text forKey:@"password"];
	[prefs setObject:username.text forKey:@"username"];
	NSString *tempIndex = [NSString stringWithFormat:@"%i",segmentedControl.selectedSegmentIndex];
	[prefs setObject:tempIndex forKey:@"choice"];
}

- (void)login:(id)sender{
	
	tempUser = username.text;
	tempPass = password.text;
	if(segmentedControl.selectedSegmentIndex == 0){
		choice = student;
	}
	
	if(segmentedControl.selectedSegmentIndex == 1){
		choice = staff;
	}
	
	if(segmentedControl.selectedSegmentIndex == 2){
		choice = guest;
	}
	NSString *formUrl = [NSString stringWithFormat:@"https://ezxcess.antlabs.com/www/pub/nus/login-%@.php",choice];
	
	NSError* error2;
	
	NSString* choice2;
	
	if(choice == student){
		choice2 = @"Student";
	}
	else if(choice == staff){
		choice2 = @"Staff";
	}
	else if(choice == staff){
		choice2 = @"Visitor_SG";
	}
	
	NSString* text = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ezxcess.antlabs.com/%@SGLogin.init", choice2]] encoding:NSASCIIStringEncoding error:&error2];
	if( text )
	{
		NSLog(@"Text=%@", text);
	}
	else 
	{
		NSLog(@"Parsing failed. Error = %@", error2);
	}
	
	NSRange rangeSid = [text rangeOfString:@"sid"];
	NSLog(@"%i",rangeSid.location);
	NSInteger integerSid = rangeSid.location;
	NSInteger front = integerSid +12;
	NSRange finalRange = NSMakeRange(front,32);
	NSString *sessionID = [text substringWithRange:finalRange];
	
	NSString *query = [NSString stringWithFormat:@"sid=%@&userid=%@&password=%@&Submit=Submitsid=%@&userid=%@&password=%@&Submit=Submit",sessionID,tempUser,tempPass,sessionID,tempUser,tempPass];
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:formUrl]];
	[urlRequest setHTTPMethod: @"POST"];
	[urlRequest setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];	
	NSError *error = nil;
	NSURLResponse *response;
	NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
	
	 if (result) {  
		NSString *html = [[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] autorelease];
		if ([html rangeOfString:@"Login Unsuccessful"].location != NSNotFound) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You have failed to connect :("
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			[alert release];
			
		} else {
			username.text = @"";
			password.text = @"";
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have connected!"
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			[alert release];
			NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			NSString *really = @"yes";
			[prefs setObject:really forKey:@"verified"];
		}
		
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"You have failed to connect :("
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
		[alert release];
		
	}
	 
	 
}


- (IBAction)reset:(id)sender{
	username.text = @"";
	password.text = @"";
	segmentedControl.selectedSegmentIndex = 0;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:@"password"] != nil){
		[prefs setObject:[NSString stringWithFormat:@""] forKey:@"password"];
	}
	if ([prefs objectForKey:@"username"] != nil){
		[prefs setObject:[NSString stringWithFormat:@""] forKey:@"username"];
	}
	if ([prefs objectForKey:@"choice"] != nil){
		NSString *tempIndex = [NSString stringWithFormat:@"%i",segmentedControl.selectedSegmentIndex];
		[prefs setObject:tempIndex forKey:@"choice"];	
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
    [super dealloc];
}


@end
