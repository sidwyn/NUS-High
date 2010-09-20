//
//  StaffDirectoryController.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NUSHighAppDelegate.h"
#import "StaffDirectoryController.h"
#import "StaffDirectoryDetailController.h"


@implementation StaffDirectoryController

@synthesize listOfNames, copyListOfItems;
@synthesize savedSearchTerm;
@synthesize mainTableView;


- (void)viewDidLoad {
	int myVariable = 5;
	NSLog(@"My variable is %i",myVariable);
	dataSource = [[NSDictionary alloc] init];
	
	NUSHighAppDelegate *AppDelegate = (NUSHighAppDelegate *)[[UIApplication sharedApplication] delegate];
	dataSource = [AppDelegate.data objectForKey:@"Staff"];
	self.navigationItem.title = @"Staff List";
	
	keys = [[dataSource allKeys] sortedArrayUsingSelector:
	@selector(compare:)];;
		 
	[dataSource retain];
	[keys retain];
	
	copyListOfItems = [[NSMutableArray alloc] init];
	listOfNames = [[NSMutableArray alloc] init];
	
	
	
	//Add the search bar
	
	searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search for teacher or department";
    self.tableView.tableHeaderView = searchBar;
	
    searchDC = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
	
    // The above assigns self.searchDisplayController, but without retaining.
    // Force the read-only property to be set and retained. 
    // [self performSelector:@selector(setSearchDisplayController:) withObject:searchDC];
	// [self.searchDisplayController = searchDC];
	
	
    searchDC.delegate = self;
    searchDC.searchResultsDataSource = self;
    searchDC.searchResultsDelegate = self;
	
	
	searching = NO;
	letUserSelectRow = YES;
    [super viewDidLoad];
	
	
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(searching)
		return @"Search Results";
	else{
		
		NSString *key = [keys objectAtIndex:section];
		return key;		
	}
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if(searching)
		return nil;
	else
		return keys;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (searching)
		return 1;
	else{
		return dataSource.count;	
	}
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (searching)
		return [copyListOfItems count];
	else {
		NSString *key = [keys objectAtIndex:section];
		NSArray *arr = [dataSource objectForKey:key];
		return arr.count;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	
	if(searching){
		cell.textLabel.text = [listOfNames objectAtIndex:indexPath.row];
		return cell;
	}
	else{
		// Set up the cell...
		NSString *key = [keys objectAtIndex:indexPath.section];
		NSArray *arr = [dataSource objectForKey:key];
		
		NSDictionary *dictionary = [arr objectAtIndex:indexPath.row];
		cell.textLabel.text = [dictionary objectForKey:@"Name"];	
		return cell;	
	}
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	if(searching){
		NSDictionary *info = [copyListOfItems objectAtIndex:indexPath.row];
		NSString *key = [keys objectAtIndex:[[info objectForKey:@"Letter"] intValue]];
		NSArray *arr = [dataSource objectForKey:key];
		NSDictionary *dictionary = [arr objectAtIndex:[[info objectForKey:@"Item"] intValue]];
		NSString *tempNum = [dictionary objectForKey:@"Number"];
		NSString *tempEmail = [dictionary objectForKey:@"Email"];
		NSString *tempName = [dictionary objectForKey:@"Name"];
		NSString *tempTitle = [dictionary objectForKey:@"Title"];
		NUSHighAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
		[appDelegate pushNewStaffNumber:tempNum email:tempEmail name:tempName title:tempTitle];
	}
	else 
	{
		NSString *key = [keys objectAtIndex:indexPath.section];
		NSArray *arr = [dataSource objectForKey:key];
		NSDictionary *dictionary = [arr objectAtIndex:indexPath.row];
		NSString *tempNum = [dictionary objectForKey:@"Number"];
		NSString *tempEmail = [dictionary objectForKey:@"Email"];
		NSString *tempName = [dictionary objectForKey:@"Name"];
		NSString *tempTitle = [dictionary objectForKey:@"Title"];
		NUSHighAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
		[appDelegate pushNewStaffNumber:tempNum email:tempEmail name:tempName title:tempTitle];
	
	}
}


- (void)dealloc{
	
    [searchBar release];
    [searchDC release];
	
	
	[copyListOfItems release];
	[listOfNames release];
	[dataSource release];
    [super dealloc];
}



- (void)handleSearchForTerm:(NSString *)searchTerm
{
	NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
	[self setSavedSearchTerm:searchTerm];
	
	if (listOfNames == nil)
	{
		NSMutableArray *array = [[NSMutableArray alloc] init];
		listOfNames = array;
		copyListOfItems = array;
		[array release], array = nil;
	}
	
	[copyListOfItems removeAllObjects];
	[listOfNames removeAllObjects];
	
	if ([[self savedSearchTerm] length] != 0)
	{
		
	
	 //MAIN CODE FOR SEARCHING
	 NSString *searchText = searchTerm;
	searching = YES;
	
//	keys = [[dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)];
	
	for (int i = 0; i<dataSource.count; i++){
		NSString *key = [keys objectAtIndex:i];
		NSArray *arr = [dataSource objectForKey:key];
		for (int j = 0; j<arr.count; j++){
			NSDictionary *item = [arr objectAtIndex:j];
				NSString *tempName = [item objectForKey:@"Name"];
				NSString *tempTitle = [item objectForKey:@"Title"];
			
			
			NSRange aRange = [tempName rangeOfString:searchText options:NSCaseInsensitiveSearch];
			NSRange bRange = [tempTitle rangeOfString:searchText options: NSCaseInsensitiveSearch];
				if (aRange.location != NSNotFound || bRange.location != NSNotFound) {
						NSNumber *letter = [NSNumber numberWithInt:i];
						NSNumber *item = [NSNumber numberWithInt:j];
						NSDictionary *newDictionary = [NSDictionary dictionaryWithObjectsAndKeys:letter,@"Letter",item,@"Item",nil];
						[copyListOfItems addObject:newDictionary];
						[listOfNames addObject:tempName];
				} 	
		 }
	 }
	}
	
	NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
	NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
	[self handleSearchForTerm:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
	NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
    return YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
	NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
	[self setSavedSearchTerm:nil];
	
	[[self mainTableView] reloadData];
	searching = NO;
	NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
}


@end




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


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


