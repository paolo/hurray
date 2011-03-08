//
//  HRect.m
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import "HRect.h"


@implementation HRect

@synthesize x, y, width, height;

- (id) initialize:(int)x :(int)y :(int)width :(int)height
{
	self = [self init];
	self.x = x;
	self.y = y;
	self.width = width;
	self.height = height;
	return self;
}

- (CGRect) toCGRect
{
	CGRect rect;
	rect.origin.x = x;
	rect.origin.y = y;
	rect.size.width = width;
	rect.size.height = height;
	return rect;
}

@end
