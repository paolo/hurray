//
//  HRect.h
//  hurray-objc-sdk
//
//  Created by Paolo Castro on 3/7/11.
//  Copyright 2011 Jalasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HRect : NSObject {
	int x;
	int y;
	int width;
	int height;
}

@property int x, y, width, height;

- (id) initialize:(int)x :(int)y :(int)width :(int)height;

-(CGRect) toCGRect;

@end
