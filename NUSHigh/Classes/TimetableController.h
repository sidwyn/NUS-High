//
//  TimetableController.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCellView.h"
#import "EventPickerController.h"


@interface TimetableController : UITableViewController <EventPickerControllerDelegate, UITableViewDelegate>{
	NSMutableArray *mondayArray;
	NSMutableArray *tuesdayArray;
	NSMutableArray *wednesdayArray;
	NSMutableArray *thursdayArray;
	NSMutableArray *fridayArray;
	NSDictionary *dataSource;
	IBOutlet TableCellView *tblCell;
	UIToolbar *toolbar;
}

- (NSString *)dataFilePath;


@end
