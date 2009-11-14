//
//  OIWindow.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIWindow.h"
#import "OIApplication.h"
#import "OIScreen.h"
#import "OIShape.h"

#import <Ecore.h>
#import <Ecore_X.h>
#import <Ecore_Evas.h>
#import <Evas.h>

@interface OIWindow ()

@property(retain) OIRectangle* background;

@end


@implementation OIWindow

+ (void) initialize;
{
	static BOOL inited = NO; if (!inited) {
		inited = YES;
		ecore_evas_init();
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:OIApplicationWillTerminateNotification object:nil];
	}
}

+ (void) willTerminate:(NSNotification*) n;
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	ecore_evas_shutdown();
}


// -- - --

- (id) init
{
	NSRect r;
	r.size = [OIScreen mainScreen].size;
	r.origin = NSZeroPoint;
	return [self initWithFrame:r];
}

- (id) initWithFrame:(NSRect) f;
{
	self = [super init];
	if (self != nil) {
		self.nextResponder = OIApp;
		frame = f;
		hidden = YES;
		evas = ecore_evas_software_x11_new(NULL, 0, f.origin.x, f.origin.y, f.size.width, f.size.height);
		shapes = [NSMutableArray new];
		
		self.background = [OIRectangle rectangleWithFrame:f];
		self.background.color = kOIColorWhite;
		self.background.nextResponder = self;
		[self addShape:self.background];
		[self.background becomeFirstResponder];
	}
	
	return self;
}

+ window { return [[self new] autorelease]; }
+ windowWithFrame:(NSRect) f { return [[[self alloc] initWithFrame:f] autorelease]; }

@synthesize hidden, background, shapes;

- (void) dealloc
{
	[shapes release];
	
	if (evas) {
		ecore_evas_hide(evas);
		ecore_evas_free(evas);
		
		evas = NULL;
	}
	
	[super dealloc];
}

- (void) setHidden:(BOOL) h;
{
	if (evas) {
		if (!h)
			ecore_evas_show(evas);
		else
			ecore_evas_hide(evas);
	}
	
	hidden = h;
}

- (NSRect) frame;
{
	int x, y, w, h;
	ecore_evas_geometry_get(evas, &x, &y, &w, &h);
	return NSMakeRect(x, y, w, h);
}

- (void) setFrame:(NSRect) f;
{
	ecore_evas_move_resize(evas, f.origin.x, f.origin.y, f.size.width, f.size.height);
}

- (BOOL) zoomed;
{
	return ecore_evas_maximized_get(evas) != 0;
}

- (void) setZoomed:(BOOL) z;
{
	ecore_evas_maximized_set(evas, z? 1 : 0);
}

- (void) orderFront;
{
	ecore_evas_raise(evas);
}

- (void) show;
{
	self.hidden = NO;
	[self orderFront];
}

- (OIWindowEcoreEvasRef) ecoreEvas;
{
	return evas;
}

- (void) addShape:(OIShape*) shape;
{
	[shapes addObject:shape];
	[shape addToWindow:self];
}

- (void) removeShape:(OIShape*) shape;
{
	[shape removeFromWindow];
	[shapes removeObject:shape];
}

@end
