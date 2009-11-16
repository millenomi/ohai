//
//  OIApplication.h
//  Ohai
//
//  Created by ∞ on 09/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIResponder.h"

/**
 \file
 
 Functions and classes in this file initialize and run the application and its main loop.
 */


/**
 Initializes the Objective-C runtime and Ecore. This function must be called before making any Objective-C call in main(), and it does not need an autorelease pool to be in place.
 */
extern void OIInitializeProcess(int argc, const char* argv[]);

/**
 A shortcut for [OIApplication sharedApplication].
 */
#define OIApp ((OIApplication*)[OIApplication sharedApplication])

// -----

/**
 This notification is sent just before the application terminates. See OIApplicationDelegate::applicationWillTerminate: for more information.
 */
extern NSString* const OIApplicationWillTerminateNotification;

/**
 An application object represents your app. Application objects run the run loop and allow for graceful app shutdown when needed.

 Application objects, just like in AppKit or UIKit, aren't usually subclassed. Instead, they send messages to another object, the application delegate. OIApplication retains its delegate.
 
 The application object is a responder and is intended to be the "top" of all responder chains (that is, the object all events are ultimately forwarded to if unhandled). By default, it does not declare the use of any OIMap and has no intent delegate.
 
 Applications are singletons; there is only one application instance in each app. The singleton is created the first time the OIApplication::sharedApplication method is called, and is of the class it is first called on (OIApplication or the desired subclass, if any).
 */
@interface OIApplication : OIResponder {
	id delegate;
	BOOL shouldTerminate;
}

/**
 Returns or creates, if missing, the application singleton. You can use the OIApp macro as a shortcut to invoke this method.
 */
+ sharedApplication;

/**
 The application delegate. You should not change this value after the application starts running (that is, after OIApplication::run is called).
 */
@property(retain) id delegate;

/**
 Runs the application. This makes the run loop spin and starts sending appropriate messages to the application delegate.
 This method does not return. See OIApplicationDelegate::applicationWillTerminate for more information on how the app is termianted.
 */
- (void) run;

/**
 Convenience method that creates a new object of the given class, sets it as the delegate, then runs the application with -run.
 */
- (void) runWithDelegateClass:(Class) c;

/**
 Terminates the application at the earliest possible time, usually after the current event has finished processing. This method may terminate the application immediately if it's safe to do so, but may pospone this in order to correctly end the underlying Enlightenment run loop.
 
 That is: do not assume this method will or will not return after used. It's often wise to return from the caller immediately after calling it.
 */
- (void) terminateWhenPossible;

@end

// -----

/**
 These are the methods that the delegate of a OIApplication can receive.
 */
@interface NSObject (OIApplicationDelegate)

/**
 Sent before the first event is processed. This is usually where the UI and application controllers are first set up.
 */
- (void) applicationDidFinishLaunching:(OIApplication*) app;

/**
 Sent just before the application is terminated. The OIApplication terminates the app by sending this message (and the associated OIApplicationWillTerminateNotification) and then calling the exit() function from within the implementation of the OIApplication::run method; this means that the dealloc method will not be called on objects still "alive" after this method returns. This matches the behavior of AppKit and UIKit and makes shutdown much faster.
 */
- (void) applicationWillTerminate:(OIApplication*) app;

@end
