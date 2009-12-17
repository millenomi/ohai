//
//  OIScreen.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OITargets.h"

#if OITargetFeatureEnlightenment

#import "OIScreen.h"
#import "OIApplication.h"

#import <Ecore.h>
#import <Ecore_X.h>

@implementation OIScreen

static void OIScreenTerminateWhenXQuits(void* nothing) {
	[OIApp terminateWhenPossible];
}

+ (void) initialize;
{
	static BOOL inited = NO; if (!inited) {
		inited = YES;
		ecore_x_init(NULL);
		ecore_x_io_error_handler_set(&OIScreenTerminateWhenXQuits, NULL);
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:OIApplicationWillTerminateNotification object:nil];
	}
}

+ (void) willTerminate:(NSNotification*) n;
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	ecore_x_shutdown();
}

// -- - --

+ (OIScreen*) mainScreen;
{
	static id me = nil; if (!me)
		me = [self new];
	
	return me;
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		native = (OIScreenNativeHandle) ecore_x_default_screen_get();
	}
	
	return self;
}

// -- - --

- (NSSize) size;
{
	return NSMakeSize(600, 800); // TODO
}

@end

#else
#error This file should only be included in an Enlightenment build.
#endif
