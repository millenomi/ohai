//
//  OIResponder.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OIKeyboardEvent.h"
#import "OIMap.h"

// in the env, OIResponderEventLog=YES will cause events and intent sending to be logged.
#define OIResponderEventLog (@"OIResponderEventLog")

extern NSString* const OIObjectDidBecomeFirstResponderNotification;

@interface NSObject (OIEvents)

- (void) keyDown:(OIKeyboardEvent*) event;
- (void) keyUp:(OIKeyboardEvent*) event;

@end

@interface OIResponder : NSObject {
	id nextResponder;
	id intentDelegate;
	NSMutableArray* maps;
}

@property(assign) id nextResponder;
@property(assign) id intentDelegate;

// Maps.
@property(readonly) NSMutableArray* maps;
- (void) addMap:(OIMap*) map;

@end
