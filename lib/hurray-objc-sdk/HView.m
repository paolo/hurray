//
//  HView.m
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import "HView.h"


@implementation HView

@synthesize view;
@synthesize subviews;

- (id)initialize:(HRect *)rect
{
	self = [self init];
	frame = rect;
	view = [[UIView alloc] initWithFrame:[frame toCGRect]];
	subviews = [[NSMutableArray alloc] initWithCapacity:1];
	return self;
}

- (void)add_subview:(HView *)hview
{
	[subviews addObject:hview];
	[view addSubview:hview.view];
}

- (void)dealloc {
	[frame release];
	[view release];
	[subviews release];
    [super dealloc];
}


@end
