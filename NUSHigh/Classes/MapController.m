//
//  MapController.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"


@implementation MapController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)viewDidLoad{
	[self.view addSubview:scrollView];
	[scrollView addSubview:imageView];
	
	UIImage *image = [UIImage imageNamed:@"clementi2.gif"];
	scrollView.contentSize = [image size];
	scrollView.maximumZoomScale = 5.0;
	
	self.navigationItem.title = @"Map of NUS High";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return imageView;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
