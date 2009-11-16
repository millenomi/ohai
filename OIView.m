//
//  OIView2.m
//  Ohai
//
//  Created by ∞ on 16/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIView.h"
#import <Ecore_Evas.h>
#import <Evas.h>

#import "OILog.h"

@implementation OIView

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.color = OIColorBlack;
		self.hidden = NO;
	}
	return self;
}


@synthesize handle, window;

- (void) dealloc;
{
	[boundKeys release];
	[super dealloc];
}

- (NSArray*) boundKeys;
{
	if (!boundKeys) {
		boundKeys = [[NSArray alloc] initWithObjects:
					 @"frame",
					 @"hidden",
					 @"color",
					 nil];
	}
	
	return boundKeys;
}

- (void) addToWindow:(OIWindow*) w;
{
	NSAssert(!handle, @"This shape was already added to another window!");
	
	handle = [self createEvasObjectByAddingToCanvas:ecore_evas_get(w.ecoreEvas)];
	self.window = w;
	
	for (NSString* key in self.boundKeys) {
		NSString* method = [NSString stringWithFormat:@"%@ApplyToHandle", key];
		_OILog(OIWindowViewLog, @"About to apply %@ (via %@) to %@", key, method, self);
		[self performSelector:NSSelectorFromString(method)];
		
		NSString* displayMethod = [NSString stringWithFormat:@"%@Description", key];
		SEL s = NSSelectorFromString(displayMethod);
		if ([self respondsToSelector:s]) {
			_OILog(OIWindowViewLog, @"%@ is now %@", key, [self performSelector:s]);
		}
	}
}

- (void) removeFromWindow;
{
	evas_object_del(self.handle);
	handle = NULL;
	self.window = nil;
}

- (OIViewEvasObjectRef) createEvasObjectByAddingToCanvas:(OIWindowEvasRef)canvas;
{
	NSAssert(NO, @"This method must be overridden by subclasses!");
	return NULL;
}

#pragma mark Properties

// -- Frame --

- (void) frameApplyToHandle;
{
	NSRect r = frame; Evas_Object* me = self.handle;
	evas_object_move(me, r.origin.x, r.origin.y);
	evas_object_resize(me, r.size.width, r.size.height);	
}

- (NSString*) frameDescription;
{
	return NSStringFromRect(self.frame);
}

- (NSRect) frameByQueryingHandle;
{
	Evas_Coord x, y, w, h;
	evas_object_geometry_get(self.handle, &x, &y, &w, &h);
	return NSMakeRect(x, y, w, h);
}

OIViewSynthesizeAssignAccessors(frame, setFrame:, NSRect, frame)

// -- Hidden --

- (void) hiddenApplyToHandle;
{
	if (!hidden)
		evas_object_show(self.handle);
	else
		evas_object_hide(self.handle);
}

- (NSString*) hiddenDescription;
{
	return self.hidden? @"YES" : @"NO";
}

- (BOOL) hiddenByQueryingHandle;
{
	return evas_object_visible_get(self.handle) == EINA_FALSE;
}

OIViewSynthesizeAssignAccessors(hidden, setHidden:, BOOL, hidden)

// -- Color --

- (void) colorApplyToHandle;
{
	OIColor c = color;
	evas_object_color_set(self.handle, c.red, c.green, c.blue, c.alpha);
}

- (NSString*) colorDescription;
{
	return NSStringFromOIColor(self.color);
}

- (OIColor) colorByQueryingHandle;
{
	OIColor c;
	evas_object_color_get(self.handle, &c.red, &c.green, &c.blue, &c.alpha);
	return c;
}

OIViewSynthesizeAssignAccessors(color, setColor:, OIColor, color)

// -- Focus (first responder) --

- (BOOL) firstResponder;
{
	return self.handle? evas_object_focus_get(self.handle) == EINA_TRUE : NO;
}

- (void) setFirstResponder:(BOOL) fr;
{
	if (!self.handle)
		return;
	
	firstResponder = fr;
	evas_object_focus_set(self.handle, fr? EINA_TRUE : EINA_FALSE);
}

- (void) becomeFirstResponder;
{
	self.firstResponder = YES;
}


- (void) bringToFront;
{
	if (self.handle)
		evas_object_raise(self.handle);
}

- (void) sendToBack;
{
	if (self.handle)
		evas_object_lower(self.handle);
}

@end
