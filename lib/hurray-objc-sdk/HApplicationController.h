//
//  HApplicationController.h
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/4/11.
//  Copyright 2011 Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HView.h"


@interface HApplicationController : NSObject <UIApplicationDelegate> {
	HView *view;
}

- (id) initialize;
- (BOOL) start;

@end
