//
//  OIResponder.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIResponder.h"
#import <Evas.h>

@interface OIResponder ()

- (BOOL) performIntentForEvent:(OIKeyboardEvent*) event selector:(SEL) mapSelector;

@end


@implementation OIResponder

- (id) init
{
	self = [super init];
	if (self != nil) {
		maps = [NSMutableArray new];
	}
	return self;
}

@synthesize nextResponder, maps;

- (void) dealloc
{
	[maps release];
	[super dealloc];
}

- (void) addMap:(OIMap*) map;
{
	[self.maps addObject:map];
}

- (void) keyDown:(OIKeyboardEvent*) event;
{
	if (![self performIntentForEvent:event selector:@selector(performIntentForKeyDownEvent:on:)] && [self.nextResponder respondsToSelector:@selector(keyDown:)])
		[self.nextResponder keyDown:event];
}

- (void) keyUp:(OIKeyboardEvent*) event;
{
	if (![self performIntentForEvent:event selector:@selector(performIntentForKeyUpEvent:on:)] && [self.nextResponder respondsToSelector:@selector(keyUp:)])
		[self.nextResponder keyUp:event];
}

- (BOOL) performIntentForEvent:(OIKeyboardEvent*) event selector:(SEL) mapSelector;
{
	for (OIMap* m in self.maps) {
		if ([m performSelector:mapSelector withObject:event withObject:self])
			return YES;
	}
	
	return NO;
}

@end
