//
//  StaffDirectoryController.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffDirectoryController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>{
	NSDictionary *dataSource;
	NSArray *keys;
	
	NSMutableArray *copyListOfItems;
	NSMutableArray *listOfNames;
	BOOL searching;
	BOOL letUserSelectRow;
	
	UITableView *mainTableView;
	IBOutlet UISearchBar *searchBar;
	IBOutlet UISearchDisplayController *searchDC;
}

@property (nonatomic, retain) IBOutlet UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *copyListOfItems;
@property (nonatomic, retain) NSMutableArray *listOfNames;

@property (nonatomic, copy) NSString *savedSearchTerm;

- (void)handleSearchForTerm:(NSString *)searchTerm;

@end
