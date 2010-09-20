//
//  TableCellView.m
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TableCellView.h"


@implementation TableCellView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setLabelText:(NSString *)textie detailCellText:(NSString *)detail 
			timeFrom:(NSString *)timeFrom timeTo:(NSString *)timeTo
{
	cellText.text = textie;
	cellText.font = [UIFont systemFontOfSize:16];
	detailCellText.text = detail;
	detailCellText.font = [UIFont systemFontOfSize:12];
	timeFromText.text = timeFrom;
	timeToText.text = timeTo;
	
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
