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

typedef struct {
	int red, green, blue, alpha;
} OIColor;

static inline OIColor OIColorMake(int r, int g, int b, int a) {
	OIColor c;
	c.red = r; c.green = g;
	c.blue = b;	c.alpha = a;
	return c;
}

typedef void* OIShapeEvasObjectRef;

@interface OIShape : OIResponder {
	OIShapeEvasObjectRef evasObject;
	
	short layer;
	NSRect frame;
	BOOL hidden;
	OIColor color;
}

- (void) addToWindow:(OIWindow*) window;
- (void) removeFromWindow; // don't call this. use [window removeShape:x] instead.

@property(readonly) OIShapeEvasObjectRef evasObject;

// Subclasses implement this.
- (OIShapeEvasObjectRef) addToEcoreEvasReference:(OIWindowEcoreEvasRef) ref;

// -- - --

@property(assign) short layer;
@property(assign) NSRect frame;
@property(assign) BOOL hidden;
@property(assign) OIColor color;

- (void) becomeFirstResponder;

@end

@interface OIRectangle : OIShape {}

- (id) initWithFrame:(NSRect) frame;
+ rectangleWithFrame:(NSRect) frame;

@end
