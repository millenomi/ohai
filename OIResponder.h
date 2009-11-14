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

@interface NSObject (OIEvents)

- (void) keyDown:(OIKeyboardEvent*) event;
- (void) keyUp:(OIKeyboardEvent*) event;

@end

@interface OIResponder : NSObject {
	id nextResponder;
	NSMutableArray* maps;
}

@property(assign) id nextResponder;

// Maps.
@property(readonly) NSMutableArray* maps;
- (void) addMap:(OIMap*) map;

@end
