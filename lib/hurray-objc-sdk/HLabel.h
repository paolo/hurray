//
//  HLabel.h
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HView.h"
#import "HRect.h"


@interface HLabel : HView {
	NSString *text;
}

@property (retain) NSString *text;

- (id) initialize:(HRect *)rect;

@end
