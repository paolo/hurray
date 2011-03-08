//
//  HWindow.h
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HView.h"
#import "HRect.h"


@interface HWindow : HView {

}

- (id) initialize:(HRect *)rect;
- (void) make_visible;

@end
