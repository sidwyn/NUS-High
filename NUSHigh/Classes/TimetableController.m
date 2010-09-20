//
//  TimetableController.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimetableController.h"
#import "NUSHighAppDelegate.h"
#import "TableCellView.h"


@implementation TimetableController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	//TOOLBAR
	toolbar = [UIToolbar new];
	toolbar.barStyle = UIBarStyleDefault;
	[toolbar sizeToFit];
	toolbar.frame = CGRectMake(0, 375, 320, 50);
	[self.view.superview addSubview:toolbar];
	
	
	//Add buttons
	//UIBarButtonItem *systemItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
	//																			 target:self
	//																			 action:@selector(pressButton1:)];
	
	dataSource = [[NSDictionary alloc] init];
	NSString *filePath = [self dataFilePath];

	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		dataSource = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	}
	else{
		NUSHighAppDelegate *AppDelegate = (NUSHighAppDelegate *)[[UIApplication sharedApplication] delegate];
		dataSource = AppDelegate.data3;
	}
	
	self.navigationItem.title = @"Timetable";
	
	mondayArray = [[NSMutableArray alloc] init];
	mondayArray = [[dataSource objectForKey:@"Monday"] mutableCopy];
	tuesdayArray = [[NSMutableArray alloc] init];
	tuesdayArray = [[dataSource objectForKey:@"Tuesday"] mutableCopy];
	wednesdayArray = [[NSMutableArray alloc] init];
	wednesdayArray = [[dataSource objectForKey:@"Wednesday"] mutableCopy];
	thursdayArray = [[NSMutableArray alloc] init];
	thursdayArray = [[dataSource objectForKey:@"Thursday"] mutableCopy];
	fridayArray = [[NSMutableArray alloc] init];
	fridayArray = [[dataSource objectForKey:@"Friday"] mutableCopy];
	
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
	
    self.navigationItem.rightBarButtonItem = button;
}

- (void)addNewItem{
	EventPickerController *eventPickerController = [[EventPickerController alloc] init];
	eventPickerController.delegate = self;
	[self presentModalViewController:eventPickerController animated:YES];
	[eventPickerController release];
}

- (void)eventPickerControllerDidAddEvent:(EventPickerController *)eventPickerController addName:(NSString *)name addTeacher:(NSString *)teacher addDay:(int)day addTimeFrom:(NSString *)timeFrom addTimeTo:(NSString *)timeTo {
	[self dismissModalViewControllerAnimated:YES];
	NSLog(@"%@, %@, %i, %@, %@",name,teacher,day,timeTo,timeFrom);
	
	NSDictionary *tempDictionary;
	tempDictionary = [NSDictionary dictionaryWithObjectsAndKeys:name,@"Title",teacher,@"Teacher",timeFrom,@"Timefrom",timeTo,@"Timeto",nil];
	
	if(day == 0){
		[mondayArray addObject:tempDictionary];
	}
	if(day == 1){
		[tuesdayArray addObject:tempDictionary];
	}
	if(day == 2){
		[wednesdayArray addObject:tempDictionary];
	}
	if(day == 3){
		[thursdayArray addObject:tempDictionary];
	}
	if(day == 4){
		[fridayArray addObject:tempDictionary];
	}
	
	
	
	
	NSDictionary *tempDictionary2;
	tempDictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:mondayArray,@"Monday",tuesdayArray,@"Tuesday",wednesdayArray,@"Wednesday",thursdayArray,@"Thursday",fridayArray,@"Friday",nil];
	
	[tempDictionary2 writeToFile:[self dataFilePath] atomically:YES];
	
	[self.tableView reloadData];
	
	//Sort array
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"Timefrom"
												  ascending:YES] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	NSArray *sortedArray;
	if(day ==0){
		sortedArray = [mondayArray sortedArrayUsingDescriptors:sortDescriptors];
		mondayArray = [sortedArray mutableCopy];
	}
	if(day ==1){
		sortedArray = [tuesdayArray sortedArrayUsingDescriptors:sortDescriptors];
		tuesdayArray = [sortedArray mutableCopy];
	}
	if(day ==2){
		sortedArray = [wednesdayArray sortedArrayUsingDescriptors:sortDescriptors];
		wednesdayArray = [sortedArray mutableCopy];
	}
	if(day ==3){
		sortedArray = [thursdayArray sortedArrayUsingDescriptors:sortDescriptors];
		thursdayArray = [sortedArray mutableCopy];
	}
	if(day ==4){
		sortedArray = [fridayArray sortedArrayUsingDescriptors:sortDescriptors];
		fridayArray = [sortedArray mutableCopy];
	}
	
}


- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Calendar.plist"];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0){
		return @"Monday";
	}
    if(section == 1){
		return @"Tuesday";
	}
    if(section == 2){
		return @"Wednesday";
	}
    if(section == 3){
		return @"Thursday";
	}
    if(section == 4){
		return @"Friday";
	}
	else{
		return nil;
	}
}

//5 arrays (mon-fri)
//each day contains an array of events
//each event contains an array of details
//each detail is a dictionary

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
		return mondayArray.count;
	}
	if(section == 1){
		return tuesdayArray.count;
	}
	if(section == 2){
		return wednesdayArray.count;
	}
	if(section == 3){
		return thursdayArray.count;
	}
	if(section == 4){
		return fridayArray.count;
	}
	else{
		return 0;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	MyIdentifier = @"tblCellView";
	
	TableCellView *cell = (TableCellView *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"TableCellView" owner:self options:nil];
		cell = tblCell;
	}
			NSDictionary *dictionary;
		if (indexPath.section == 0){
			dictionary = [mondayArray objectAtIndex:indexPath.row];
		}
		if (indexPath.section == 1){
			dictionary = [tuesdayArray objectAtIndex:indexPath.row];
		}
		if (indexPath.section == 2){
			dictionary = [wednesdayArray objectAtIndex:indexPath.row];
		}
		if (indexPath.section == 3){
			dictionary = [thursdayArray objectAtIndex:indexPath.row];
		}
		if (indexPath.section == 4){
			dictionary = [fridayArray objectAtIndex:indexPath.row];
		}
		
		NSString *text = [dictionary objectForKey:@"Title"];
		NSString *detailText = [dictionary objectForKey:@"Teacher"];
		NSString *timeFrom = [dictionary objectForKey:@"Timefrom"];		
		NSString *timeTo = [dictionary objectForKey:@"Timeto"];

		[cell setLabelText:text detailCellText:detailText timeFrom:timeFrom timeTo:timeTo];
/**		[text release];
		[detailText release];
		[timeFrom release];
		[timeTo release];*/
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}





// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		if (indexPath.section == 0){
			[mondayArray removeObjectAtIndex:indexPath.row];
		}
		if (indexPath.section == 1){
			[tuesdayArray removeObjectAtIndex:indexPath.row];
		}
		if (indexPath.section == 2){
			[wednesdayArray removeObjectAtIndex:indexPath.row];
		}
		if (indexPath.section == 3){
			[thursdayArray removeObjectAtIndex:indexPath.row];
		}
		if (indexPath.section == 4){
			[fridayArray removeObjectAtIndex:indexPath.row];
		}
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
}




/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

