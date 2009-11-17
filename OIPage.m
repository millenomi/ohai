//
//  OIPage.m
//  Ohai
//
//  Created by ∞ on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIPage.h"


@implementation OIPage

+ (id) page;
{
	return [[self new] autorelease];
}

+ (id) pageWithView:(OIView*) v;
{
	OIPage* me = [self page];
	me.view = v;
	return me;
}

@synthesize view;

- (void) dealloc
{
	[self removeFromWindow];
	self.view = nil;
	[super dealloc];
}

- (void) addWithFrame:(NSRect) f inWindow:(OIWindow*) w nextResponder:(id) r;
{
	self.view.frame = f;
	self.view.nextResponder = r;
	[w addView:self.view];
}

- (void) removeFromWindow;
{
	[self.view.window removeView:self.view];
}

@end
