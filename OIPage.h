//
//  OIPage.h
//  Ohai
//
//  Created by ∞ on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIView.h"
#import "OIWindow.h"

@interface OIPage : NSObject {
	OIView* view;
}

// - (id) init; // designated.
+ (id) page;
+ (id) pageWithView:(OIView*) v;

@property(retain) OIView* view;

- (void) addWithFrame:(NSRect) f inWindow:(OIWindow*) w nextResponder:(id) r;
- (void) removeFromWindow;

@end
