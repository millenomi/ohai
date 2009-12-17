//
//  OIResponder.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIResponder.h"
#import "OILog.h"

NSString* const OIObjectDidBecomeFirstResponderNotification = @"OIObjectDidBecomeFirstResponder";

#define OIRLog(x, ...) _OILog(OIResponderEventLog, @"%@ (%s): \n - " x, self, __func__, ## __VA_ARGS__)

@interface OIResponder ()

- (BOOL) performIntentForKeyboardEvent:(OIKeyboardEvent*) event selector:(SEL) mapSelector;

@end


@implementation OIResponder

- (id) init
{
	self = [super init];
	if (self != nil) {
		maps = [NSMutableArray new];
		intentDelegate = self;
	}
	return self;
}

@synthesize nextResponder, intentDelegate, maps;

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
	OIRLog(@"Received key down event: %@", event);
	
	if (![self performIntentForKeyboardEvent:event selector:@selector(performIntentForKeyDownEvent:on:)] && [self.nextResponder respondsToSelector:@selector(keyDown:)])
		[self.nextResponder keyDown:event];
}

- (void) keyUp:(OIKeyboardEvent*) event;
{
	OIRLog(@"Received key down event: %@", event);

	if (![self performIntentForKeyboardEvent:event selector:@selector(performIntentForKeyUpEvent:on:)] && [self.nextResponder respondsToSelector:@selector(keyUp:)])
		[self.nextResponder keyUp:event];
}

- (BOOL) performIntentForKeyboardEvent:(OIKeyboardEvent*) event selector:(SEL) mapSelector;
{
	OIRLog(@"Checking for intents with selector %@", NSStringFromSelector(mapSelector));
	for (OIMap* m in self.maps) {
		OIRLog(@"Checking whether map %@ can handle the event...", m);
		if ([m performSelector:mapSelector withObject:event withObject:self])
			return YES;
	}
	
	return NO;
}

@end
