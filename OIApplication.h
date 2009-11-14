//
//  OIApplication.h
//  Ohai
//
//  Created by ∞ on 09/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIResponder.h"

extern void OIInitializeProcess(int argc, const char* argv[]);

#define OIApp ((OIApplication*)[OIApplication sharedApplication])

// -----

@protocol OIApplicationDelegate;

extern NSString* const OIApplicationWillTerminateNotification;

@interface OIApplication : OIResponder {
	id delegate;
	BOOL shouldTerminate;
	
	NSTimer* loopTasker;
}

+ sharedApplication;

@property(retain) id delegate;
- (void) runWithDelegateClass:(Class) c;

- (void) run;
- (void) terminateWhenPossible;

@end

// -----

@interface NSObject (OIApplicationDelegate)

- (void) applicationDidFinishLaunching:(OIApplication*) app;
- (void) applicationWillTerminate:(OIApplication*) app;

@end