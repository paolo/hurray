//
//  HLabel.m
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import "HLabel.h"


@implementation HLabel

@synthesize text;

- (id) initialize:(HRect *)rect
{
	self = [self init];
	frame = rect;
	view = [[UILabel alloc] initWithFrame:[frame toCGRect]];
	[(UILabel *)view setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
	[(UILabel *)view setLineBreakMode:UILineBreakModeTailTruncation];
	
	subviews = [[NSMutableArray alloc] initWithCapacity:1];
	return self;
}

- (void) setText:(NSString *)t
{
	text = t;
	[(UILabel *)view setText:text];
}

- (void) dealloc
{
	[text release];
	[super dealloc];
}

@end
