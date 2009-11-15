//
//  OIShape.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIShape.h"
#import "OIKeyboardEvent.h"
#import <Evas.h>
#import <Ecore_Evas.h>

static void OIShapeKeyDownEvent(void* me, Evas* evas, Evas_Object* background, void* eventInfo) {
	Evas_Event_Key_Down* info = (Evas_Event_Key_Down*) eventInfo;
	OIWindow* self = (id) me;
	
	OIKeyboardEvent* event = [[OIKeyboardEvent alloc]
							  initWithSender:self
							  key:(info->key? [NSString stringWithCString:info->key encoding:NSUTF8StringEncoding] : nil)
							  intendedKey:(info->keyname? [NSString stringWithCString:info->keyname encoding:NSUTF8StringEncoding] : nil)
							  inputString:(info->string? [NSString stringWithCString:info->string encoding:NSUTF8StringEncoding] : nil)
							  provisionalInputString:(info->compose? [NSString stringWithCString:info->compose encoding:NSUTF8StringEncoding] : nil)];
	[self keyDown:event];
	[event release];
}

static void OIShapeKeyUpEvent(void* me, Evas* evas, Evas_Object* background, void* eventInfo) {
	Evas_Event_Key_Up* info = (Evas_Event_Key_Up*) eventInfo;
	OIWindow* self = (id) me;
	
	OIKeyboardEvent* event = [[OIKeyboardEvent alloc]
							  initWithSender:self
							  key:(info->key? [NSString stringWithCString:info->key encoding:NSUTF8StringEncoding] : nil)
							  intendedKey:(info->keyname? [NSString stringWithCString:info->keyname encoding:NSUTF8StringEncoding] : nil)
							  inputString:(info->string? [NSString stringWithCString:info->string encoding:NSUTF8StringEncoding] : nil)
							  provisionalInputString:(info->compose? [NSString stringWithCString:info->compose encoding:NSUTF8StringEncoding] : nil)];
	[self keyUp:event];
	[event release];
}

@implementation OIShape

@synthesize layer, frame, hidden, color, window, evasObject;

- (void) dealloc;
{
	[self removeFromWindow];
	[super dealloc];
}

- (void) addToWindow:(OIWindow*) w;
{
	NSAssert(!evasObject, @"This shape was already added to another window!");
	evasObject = [self addToEcoreEvasReference:w.ecoreEvas];
	
	NSRect r = self.frame;
	evas_object_move(evasObject, r.origin.x, r.origin.y);
	evas_object_resize(evasObject, r.size.width, r.size.height);
	
	evas_object_layer_set(evasObject, self.layer);
	
	OIColor c = self.color;
	evas_object_color_set(evasObject, c.red, c.green, c.blue, c.alpha);
	
	if (self.hidden)
		evas_object_hide(evasObject);
	else
		evas_object_show(evasObject);
	
	evas_object_event_callback_add(evasObject, EVAS_CALLBACK_KEY_DOWN, &OIShapeKeyDownEvent, self);
	evas_object_event_callback_add(evasObject, EVAS_CALLBACK_KEY_UP, &OIShapeKeyUpEvent, self);
	
	self.window = w;
}

- (void) removeFromWindow;
{
	if (!evasObject)
		return;
	
	evas_object_event_callback_del_full(evasObject, EVAS_CALLBACK_KEY_DOWN, &OIShapeKeyDownEvent, self);
	evas_object_event_callback_del_full(evasObject, EVAS_CALLBACK_KEY_UP, &OIShapeKeyUpEvent, self);

	evas_object_del(evasObject);
	evasObject = NULL;
	
	self.window = nil;
}

- (id) nextResponder;
{
	id next = [super nextResponder];
	if (!next)
		next = self.window;
	return next;
}

// Subclasses implement this.
- (OIShapeEvasObjectRef) addToEcoreEvasReference:(OIWindowEcoreEvasRef) ref;
{
	[NSException raise:@"OIShapeAbstractExceptioN" format:@"%s was not implemented in class %@!", __func__, [self class]];
	return NULL;
}


- (void) setLayer:(short) l;
{
	layer = l;
	if (evasObject)
		evas_object_layer_set(evasObject, l);
}

- (void) setFrame:(NSRect) r;
{
	frame = r;
	if (evasObject) {
		evas_object_move(evasObject, r.origin.x, r.origin.y);
		evas_object_resize(evasObject, r.size.width, r.size.height);
	}
}

- (void) setColor:(OIColor) c;
{
	color = c;
	if (evasObject)
		evas_object_color_set(evasObject, c.red, c.green, c.blue, c.alpha);
}

- (void) becomeFirstResponder;
{
	NSAssert(evasObject, @"Only shapes added to a window can become first responders (focused).");
	evas_object_focus_set(evasObject, 1);
}

@end


@implementation OIRectangle

- (id) initWithFrame:(NSRect) f;
{
	if (self = [super init])
		self.frame = f;
	
	return self;
}

+ rectangleWithFrame:(NSRect) f;
{
	return [[[self alloc] initWithFrame:f] autorelease];
}

- (OIShapeEvasObjectRef) addToEcoreEvasReference:(OIWindowEcoreEvasRef) ref;
{
	return evas_object_rectangle_add(ecore_evas_get(ref));
}

@end
