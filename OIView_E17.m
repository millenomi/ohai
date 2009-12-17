//
//  OIView2.m
//  Ohai
//
//  Created by ∞ on 16/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OITargets.h"

#if OITargetFeatureEnlightenment

#import "OIView.h"
#import <Ecore_Evas.h>
#import <Evas.h>

#import "OILog.h"

static void OIViewKeyDownEvent(void* me, Evas* evas, Evas_Object* background, void* eventInfo) {
	Evas_Event_Key_Down* info = (Evas_Event_Key_Down*) eventInfo;
	if (info->event_flags & EVAS_EVENT_FLAG_ON_HOLD) return;
	BOOL held = evas_key_modifier_is_set(info->modifiers, "Alt");
	
	OIView* self = (id) me;
	
	OIKeyboardEvent* event = [[OIKeyboardEvent alloc]
							  initWithSender:self
							  key:(info->key? [NSString stringWithCString:info->key encoding:NSUTF8StringEncoding] : nil)
							  intendedKey:(info->keyname? [NSString stringWithCString:info->keyname encoding:NSUTF8StringEncoding] : nil)
							  inputString:(info->string? [NSString stringWithCString:info->string encoding:NSUTF8StringEncoding] : nil)
							  provisionalInputString:(info->compose? [NSString stringWithCString:info->compose encoding:NSUTF8StringEncoding] : nil)
							  held:held
							  ];
	[self keyDown:event];
	[event release];
}

static void OIViewKeyUpEvent(void* me, Evas* evas, Evas_Object* background, void* eventInfo) {
	Evas_Event_Key_Up* info = (Evas_Event_Key_Up*) eventInfo;
	if (info->event_flags & EVAS_EVENT_FLAG_ON_HOLD) return;
	
	OIView* self = (id) me;
	BOOL held = evas_key_modifier_is_set(info->modifiers, "Alt");
	
	OIKeyboardEvent* event = [[OIKeyboardEvent alloc]
							  initWithSender:self
							  key:(info->key? [NSString stringWithCString:info->key encoding:NSUTF8StringEncoding] : nil)
							  intendedKey:(info->keyname? [NSString stringWithCString:info->keyname encoding:NSUTF8StringEncoding] : nil)
							  inputString:(info->string? [NSString stringWithCString:info->string encoding:NSUTF8StringEncoding] : nil)
							  provisionalInputString:(info->compose? [NSString stringWithCString:info->compose encoding:NSUTF8StringEncoding] : nil)
							  held:held
							  ];
	[self keyUp:event];
	[event release];
}

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


@synthesize nativeHandle, window;

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
	NSAssert(!nativeHandle, @"This shape was already added to another window!");
	
	nativeHandle = [self createNativeObjectByAddingToNativeCanvas:ecore_evas_get(w.nativeWindow)];
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
	
	evas_object_event_callback_add(nativeHandle, EVAS_CALLBACK_KEY_DOWN, &OIViewKeyDownEvent, self);
	evas_object_event_callback_add(nativeHandle, EVAS_CALLBACK_KEY_UP, &OIViewKeyUpEvent, self);
	if (!self.nextResponder)
		self.nextResponder = w;
}

- (void) removeFromWindow;
{
	evas_object_event_callback_del_full(nativeHandle, EVAS_CALLBACK_KEY_DOWN, &OIViewKeyDownEvent, self);
	evas_object_event_callback_del_full(nativeHandle, EVAS_CALLBACK_KEY_UP, &OIViewKeyUpEvent, self);
	
	evas_object_del(self.nativeHandle);
	nativeHandle = NULL;
	
	if (self.nextResponder == self.window)
		self.nextResponder = nil;
	
	self.window = nil;
}

- (OIViewNativeHandle) createNativeObjectByAddingToNativeCanvas:(OICanvasNativeHandle)canvas;
{
	NSAssert(NO, @"This method must be overridden by subclasses!");
	return NULL;
}

#pragma mark Properties

// -- Frame --

- (void) frameApplyToHandle;
{
	NSRect r = frame; Evas_Object* me = self.nativeHandle;
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
	evas_object_geometry_get(self.nativeHandle, &x, &y, &w, &h);
	return NSMakeRect(x, y, w, h);
}

OIViewSynthesizeAssignAccessors(frame, setFrame:, NSRect, frame)

// -- Hidden --

- (void) hiddenApplyToHandle;
{
	if (!hidden)
		evas_object_show(self.nativeHandle);
	else
		evas_object_hide(self.nativeHandle);
}

- (NSString*) hiddenDescription;
{
	return self.hidden? @"YES" : @"NO";
}

- (BOOL) hiddenByQueryingHandle;
{
	return evas_object_visible_get(self.nativeHandle) == EINA_FALSE;
}

OIViewSynthesizeAssignAccessors(hidden, setHidden:, BOOL, hidden)

// -- Color --

- (void) colorApplyToHandle;
{
	OIColor c = color;
	evas_object_color_set(self.nativeHandle, c.red, c.green, c.blue, c.alpha);
}

- (NSString*) colorDescription;
{
	return NSStringFromOIColor(self.color);
}

- (OIColor) colorByQueryingHandle;
{
	int r, g, b, a;
	evas_object_color_get(self.nativeHandle, &r, &g, &b, &a);
	return OIColorMakeInt(r, g, b, a);
}

OIViewSynthesizeAssignAccessors(color, setColor:, OIColor, color)

// -- Focus (first responder) --

- (BOOL) firstResponder;
{
	return self.nativeHandle? evas_object_focus_get(self.nativeHandle) == EINA_TRUE : NO;
}

- (void) setFirstResponder:(BOOL) fr;
{
	if (!self.nativeHandle)
		return;
	
	firstResponder = fr;
	evas_object_focus_set(self.nativeHandle, fr? EINA_TRUE : EINA_FALSE);
	if (fr) {
		[[NSNotificationCenter defaultCenter] postNotificationName:OIObjectDidBecomeFirstResponderNotification object:self];
		_OILog(OIResponderEventLog, @"Did become first responder: %@", self);
	}
}

- (void) becomeFirstResponder;
{
	self.firstResponder = YES;
}


- (void) bringToFront;
{
	if (self.nativeHandle)
		evas_object_raise(self.nativeHandle);
}

- (void) sendToBack;
{
	if (self.nativeHandle)
		evas_object_lower(self.nativeHandle);
}

@end

#else
#error This file should only be included in an Enlightenment build.
#endif
