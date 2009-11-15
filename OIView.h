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

typedef void* OIViewEvasObjectRef;

@interface OIView : OIResponder {
	OIViewEvasObjectRef evasObject;
	
	short layer;
	NSRect frame;
	BOOL hidden;
	OIColor color;
	OIWindow* window;
}

- (void) addToWindow:(OIWindow*) window;
- (void) removeFromWindow; // don't call this. use [window removeShape:x] instead.

@property(readonly) OIViewEvasObjectRef evasObject;

// Subclasses must implement this.
- (OIViewEvasObjectRef) addToEcoreEvasReference:(OIWindowEcoreEvasRef) ref;

// -- - --

@property(assign) short layer;
@property(assign) NSRect frame;
@property(assign) BOOL hidden;
@property(assign) OIColor color;

@property(assign) OIWindow* window;

- (void) becomeFirstResponder;

@end

@interface OIRectangle : OIView {}

- (id) initWithFrame:(NSRect) frame;
+ rectangleWithFrame:(NSRect) frame;

@end

@interface OIImageView : OIView {
	NSString* path;
	// NSData* data; // TODO
}

- (id) initWithImageAtPath:(NSString*) path;
+ imageViewWithImageAtPath:(NSString*) path;

@property(copy) NSString* path;

@end
