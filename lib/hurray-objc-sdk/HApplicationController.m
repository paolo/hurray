//
//  HApplicationController.m
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/4/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import "HApplicationController.h"


@implementation HApplicationController

- (id) initialize
{
	self = [self init];
	return self;
}

-(BOOL) start
{
	return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    return [self start];
}

- (void)dealloc
{
	[view release];
	[super dealloc];
}

@end
