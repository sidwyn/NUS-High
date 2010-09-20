//
//  TableCellView.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellView : UITableViewCell {
	IBOutlet UILabel *cellText;
	IBOutlet UILabel *detailCellText;
	IBOutlet UILabel *timeFromText;
	IBOutlet UILabel *timeToText;
}
- (void)setLabelText:(NSString *)textie detailCellText:(NSString *)detail 
			timeFrom:(NSString *)timeFrom timeTo:(NSString *)timeTo;

@end
