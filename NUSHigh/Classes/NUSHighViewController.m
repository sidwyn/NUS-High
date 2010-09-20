//
//  NUSHighViewController.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "NUSHighViewController.h"
#import "StaffDirectoryController.h"
#import "Links.h"
#import "TimetableController.h"
#import "LoginController.h"
#import <MessageUI/MessageUI.h>
#import "ARGeoCoordinate.h"
#import <MapKit/MapKit.h>
@implementation NUSHighViewController

@synthesize staff,timetable,links,login,mailme,info;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	UIImage* myButtonImage = [UIImage imageNamed:@"Button1New.png"];
	[staff setImage:myButtonImage forState:UIControlStateNormal];
	
	UIImage* myButtonImage2 = [UIImage imageNamed:@"Button4.png"];
	[timetable setImage:myButtonImage2 forState:UIControlStateNormal];
	
	UIImage* myButtonImage3 = [UIImage imageNamed:@"Button2New.png"];
	[login setImage:myButtonImage3 forState:UIControlStateNormal];
	
	UIImage* myButtonImage4 = [UIImage imageNamed:@"Button3.png"];
	[links setImage:myButtonImage4 forState:UIControlStateNormal];
	
	UIImage* myButtonImage5 = [UIImage imageNamed:@"Button5Newest.png"];
	[mailme setImage:myButtonImage5 forState:UIControlStateNormal];
	
	UIImage* myButtonImage6 = [UIImage imageNamed:@"Button6.png"];
	[info setImage:myButtonImage6 forState:UIControlStateNormal];
	
	
    [super viewDidLoad];
}


-(IBAction)email:(id)sender{
	[self showEmailModalView];
}

-(IBAction)cheat:(id)sender{
	NSLog(@"You are cheating!");
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *really = @"yes";
	[prefs setObject:really forKey:@"verified"];
	
}

- (IBAction)feedbackChannel:(id)sender{
	
	NSString *urlString = [NSString stringWithFormat:@"http://nushigh.uservoice.com"];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction)pushStaff:(id)sender{
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *myString = [prefs stringForKey:@"verified"];
	
	if (myString == @"yes"){
		
		StaffDirectoryController *staffDirectoryController = [[StaffDirectoryController alloc] init];
		[self.navigationController pushViewController:staffDirectoryController animated:YES];
		[staffDirectoryController release];
	}
	else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please sign in to NUSOPEN first."
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	
	
	
}


- (IBAction)pushLinks:(id)sender{
	
	Links *linksController = [[Links alloc] init];
	[self.navigationController pushViewController:linksController animated:YES];
	[linksController release];
}

- (IBAction)pushTimetable:(id)sender{
	
	TimetableController *timetableController = [[TimetableController alloc] init];
	[self.navigationController pushViewController:timetableController animated:YES];
	[timetableController release];
}

- (IBAction)pushLogin:(id)sender{
	
	
	LoginController *loginController = [[LoginController alloc] init];
	[self.navigationController pushViewController:loginController animated:YES];
	[loginController release];
}

-(void) showEmailModalView {
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
	
	[picker setToRecipients:[NSArray arrayWithObject:[NSString stringWithFormat:@"nushighapp@gmail.com"]]];
	[picker setSubject:@"Feedback"];
	
	[picker setMessageBody:@"" isHTML:YES]; // depends. Mostly YES, unless you want to send it as plain text (boring)
	
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


//AR Method

-(void)pushAR:(id)sender{
	ARGeoViewController *viewController = [[ARGeoViewController alloc] init];
	viewController.debugMode = NO;
	
	viewController.delegate = self;
	
	viewController.scaleViewsBasedOnDistance = YES;
	viewController.minimumScaleFactor = .5;
	
	viewController.rotateViewsBasedOnPerspective = YES;
	
	NSMutableArray *tempLocationArray = [[NSMutableArray alloc] initWithCapacity:10];
	
	CLLocation *tempLocation;
	ARGeoCoordinate *tempCoordinate;
	
	CLLocationCoordinate2D location;
	location.latitude = 39.550051;
	location.longitude = -105.782067;
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306912 longitude:103.770698];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Hostel";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306095 longitude:103.769562];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Student Lounge";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.305977 longitude:103.770194];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Canteen";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306162 longitude:103.770152];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/30;
	tempCoordinate.title = @"Library";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.305866 longitude:103.769168];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/30;
	tempCoordinate.title = @"Basketball Court";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.3059 longitude:103.769531];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Theatrette";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306036 longitude:103.7695];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/32;
	tempCoordinate.title = @"Music Room";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.305775 longitude:103.769401];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/30;
	tempCoordinate.title = @"Fitness Corner";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306111 longitude:103.769431];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/30;
	tempCoordinate.title = @"Dry Labs";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306103 longitude:103.769378];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/30;
	tempCoordinate.title = @"Hall";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306222 longitude:103.769386];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/40;
	tempCoordinate.title = @"Staff Room";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306712 longitude:103.770072];	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Track and Field";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.307108 longitude:103.76928];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Carpark";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306202 longitude:103.768988];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/30;
	tempCoordinate.title = @"Computer Labs";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306296 longitude:103.769121];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.inclination = M_PI/30;
	tempCoordinate.title = @"Physics Labs";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306758 longitude:103.769444];	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Concourse";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306699 longitude:103.769374];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Historic Timeline";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.307204 longitude:103.76944];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"General Office";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306673 longitude:103.76927];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Biology Labs";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306924 longitude:103.769219];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Chemistry Labs";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.307242 longitude:103.769372];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Auditorium";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306434 longitude:103.769412];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Art Room";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306016 longitude:103.769501];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Netball Court";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306922 longitude:103.769153];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Seminar Rooms";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];

	tempLocation = [[CLLocation alloc] initWithLatitude:1.306316 longitude:103.769181];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Research Labs";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
	
	tempLocation = [[CLLocation alloc] initWithLatitude:1.306918 longitude:103.769456];
	
	tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation];
	tempCoordinate.title = @"Tennis Courts";
	
	[tempLocationArray addObject:tempCoordinate];
	[tempLocation release];
		
	
	[viewController addCoordinates:tempLocationArray];
	[tempLocationArray release];
	
	CLLocation *newCenter = [[CLLocation alloc] initWithLatitude:37.41711 longitude:-122.02528];
	
	viewController.centerLocation = newCenter;
	[newCenter release];
	
	[viewController startListening];
	
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

- (void)isARDone{
	NSLog(@"isARDone is called");
	StaffDirectoryController *newVC = [[StaffDirectoryController alloc] initWithNibName:@"NUSHighViewController.nib" bundle:nil];
	
	[self.navigationController pushViewController:newVC animated:NO];
	[newVC release];
}

#define BOX_WIDTH 150
#define BOX_HEIGHT 100

- (UIView *)viewForCoordinate:(ARCoordinate *)coordinate {
	
	CGRect theFrame = CGRectMake(0, 0, BOX_WIDTH, BOX_HEIGHT);
	UIView *tempView = [[UIView alloc] initWithFrame:theFrame];
	
	//tempView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.3];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BOX_WIDTH, 20.0)];
	titleLabel.backgroundColor = [UIColor colorWithWhite:.3 alpha:.8];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.text = coordinate.title;
	[titleLabel sizeToFit];
	
	titleLabel.frame = CGRectMake(BOX_WIDTH / 2.0 - titleLabel.frame.size.width / 2.0 - 4.0, 0, titleLabel.frame.size.width + 8.0, titleLabel.frame.size.height + 8.0);
	
	UIImageView *pointView = [[UIImageView alloc] initWithFrame:CGRectZero];
	pointView.image = [UIImage imageNamed:@"location.png"];
	pointView.frame = CGRectMake((int)(BOX_WIDTH / 2.0 - pointView.image.size.width / 2.0), (int)(BOX_HEIGHT / 2.0 - pointView.image.size.height / 2.0), pointView.image.size.width, pointView.image.size.height);
	
	[tempView addSubview:titleLabel];
	[tempView addSubview:pointView];
	
	[titleLabel release];
	[pointView release];
	
	return [tempView autorelease];
}

//END AR Method


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)dealloc {
    [super dealloc];
}

@end
