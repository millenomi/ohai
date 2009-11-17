//
//  OIRectangle.m
//  Ohai
//
//  Created by ∞ on 16/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIRectangle.h"
#import <Evas.h>

@implementation OIRectangle

+ (id) rectangle;
{
	return [[self new] autorelease];
}

- (id) initWithFrame:(NSRect) f;
{
	if (self = [super init])
		self.frame = f;
	
	return self;
}

+ (id) rectangleWithFrame:(NSRect) f;
{
	return [[[self alloc] initWithFrame:f] autorelease];
}

- (OIViewEvasObjectRef) createEvasObjectByAddingToCanvas:(OIWindowEvasRef)canvas;
{
	return evas_object_rectangle_add(canvas);
}

@end
