//
//  HApplication.h
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/5/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HApplicationController.h"

@interface HApplication : NSObject {
	HApplicationController *controller;
}

- (id)initialize:(HApplicationController *) c;

@end
