//
//  OIWindow.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIResponder.h"

@class OIView, OIRectangle;

typedef void* OIWindowNativeImplementationRef;

#define OIWindowViewLog (@"OIWindowViewLog")

@interface OIWindow : OIResponder {
	OIWindowNativeImplementationRef native;
	NSRect frame;
	
	BOOL hidden;
	
	OIRectangle* background;
	NSMutableArray* views;
}

- (id) init;
- (id) initWithFrame:(NSRect) f; // designated

+ window;
+ windowWithFrame:(NSRect) f;

@property(assign) BOOL hidden;
- (void) show;
- (void) orderFront;

@property(assign) NSRect frame;
@property(readonly) NSRect bounds; // unlike other AppKitalikes, -bounds here is just -frame in this OIWindow's coordinates. Always derived from -frame.
@property(assign) BOOL zoomed;

@property(readonly) OIWindowNativeImplementationRef nativeWindow;

- (void) addView:(OIView*) shape;
- (void) removeView:(OIView*) shape;

@property(readonly, retain) OIRectangle* background;
@property(readonly) NSArray* views;


@end

