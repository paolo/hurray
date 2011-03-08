//
//  HWindow.m
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import "HWindow.h"


@implementation HWindow

- (id) initialize:(HRect *)rect
{
	self = [self init];
	frame = rect;
	
	view = [[UIWindow alloc] initWithFrame:[frame toCGRect]];
	[view setBackgroundColor:[UIColor whiteColor]];
	subviews = [[NSMutableArray alloc] initWithCapacity:1];
	return self;
}

- (void) make_visible
{
	[(UIWindow *)view makeKeyAndVisible];
}

- (void) dealloc
{
	[super dealloc];
}

@end
