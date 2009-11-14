//
//  OIWindow.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIResponder.h"

@class OIShape, OIRectangle;

typedef void* OIWindowEcoreEvasRef;

@interface OIWindow : OIResponder {
	OIWindowEcoreEvasRef evas;
	NSRect frame;
	
	BOOL hidden;
	
	OIRectangle* background;
	NSMutableArray* shapes;
}

- (id) init;
- (id) initWithFrame:(NSRect) f; // designated

+ window;
+ windowWithFrame:(NSRect) f;

@property(assign) BOOL hidden;
- (void) show;
- (void) orderFront;

@property(assign) NSRect frame;
@property(assign) BOOL zoomed;

@property(readonly) OIWindowEcoreEvasRef ecoreEvas;

- (void) addShape:(OIShape*) shape;
- (void) removeShape:(OIShape*) shape;

@property(readonly, retain) OIRectangle* background;
@property(readonly) NSArray* shapes;


@end

