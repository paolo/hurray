//
//  HView.h
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRect.h"


@interface HView : NSObject {
	HRect *frame;
	UIView *view;
	NSMutableArray *subviews;
}

@property (readonly) UIView *view;
@property (readonly) NSMutableArray *subviews;

- (id) initialize:(HRect *)rect;
- (void) add_subview:(HView *)view;

@end
