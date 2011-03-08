//
//  HApplication.m
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/5/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import "HApplication.h"


@implementation HApplication

-(id)initialize:(HApplicationController *)c
{
	self = [self init];
	NSString *controller_name = NSStringFromClass([c class]);
	controller = c;
	UIApplicationMain(0, nil, @"", controller_name);
	return self;
}

@end
