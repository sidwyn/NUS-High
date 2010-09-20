//
//  MapController.h
//  NUSHigh
//
//  Created by Sidwyn Koh on 7/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MapController : UIViewController <UIScrollViewDelegate>{
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *imageView;
}

@end
