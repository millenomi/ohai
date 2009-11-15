//
//  OIShape.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OIResponder.h"
#import "OIWindow.h"
#import "OIColor.h"

typedef void* OIShapeEvasObjectRef;

@interface OIShape : OIResponder {
	OIShapeEvasObjectRef evasObject;
	
	short layer;
	NSRect frame;
	BOOL hidden;
	OIColor color;
	OIWindow* window;
}

- (void) addToWindow:(OIWindow*) window;
- (void) removeFromWindow; // don't call this. use [window removeShape:x] instead.

@property(readonly) OIShapeEvasObjectRef evasObject;

// Subclasses must implement this.
- (OIShapeEvasObjectRef) addToEcoreEvasReference:(OIWindowEcoreEvasRef) ref;

// -- - --

@property(assign) short layer;
@property(assign) NSRect frame;
@property(assign) BOOL hidden;
@property(assign) OIColor color;

@property(assign) OIWindow* window;

- (void) becomeFirstResponder;

@end

@interface OIRectangle : OIShape {}

- (id) initWithFrame:(NSRect) frame;
+ rectangleWithFrame:(NSRect) frame;

@end
