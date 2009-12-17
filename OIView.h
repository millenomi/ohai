//
//  OIView2.h
//  Ohai
//
//  Created by ∞ on 16/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OITargets.h"

#import "OIWindow.h"
#import "OIColor.h"

typedef void* OIViewNativeHandle;
typedef void* OICanvasNativeHandle;

@interface OIView : OIResponder {
	OIViewNativeHandle nativeHandle;
	OIWindow* window;
	
	NSRect frame;
	BOOL hidden;
	OIColor color;
	BOOL firstResponder;
	
	NSArray* boundKeys;
}

- (NSArray*) boundKeys; // Automatically assigned to handle and updated on change via OIViewSynthesize...-generated accessors. Requires defining a <key>ApplyToHandle and a <key>ByQueryingHandle pair that do setting and getting to/from the handle with the current value of the property.
@property(readonly) OIViewNativeHandle nativeHandle;

@property(assign) NSRect frame;
@property(assign) BOOL hidden;
@property(assign) OIColor color;
@property(assign) BOOL firstResponder;

@property(assign) OIWindow* window;

- (void) becomeFirstResponder;

- (void) bringToFront;
- (void) sendToBack;

// -- - --
- (void) addToWindow:(OIWindow *)w;
- (void) removeFromWindow;

- (OIViewNativeHandle) createNativeObjectByAddingToNativeCanvas:(OICanvasNativeHandle) canvas;

@end

#define OIViewSynthesizeGetter(name, type, ivar) \
- (type) name ; \
{ \
	if (self.nativeHandle) \
		return [self name##ByQueryingHandle]; \
	else \
		return ivar; \
} \

#define OIViewSynthesizeAssignSetter(name, setterName, type, ivar) \
- (void) setterName (type) q; \
{ \
	ivar = q; \
	if (self.nativeHandle) \
		[self name##ApplyToHandle]; \
}

#define OIViewSynthesizeRetainSetter(name, setterName, type, ivar) \
- (void) setterName (type) q; \
{ \
	if (ivar != q) { \
		[ivar release]; \
		ivar = [q retain]; \
	} \
	if (self.nativeHandle) \
		[self name##ApplyToHandle]; \
}

#define OIViewSynthesizeCopySetter(name, setterName, type, ivar) \
- (void) setterName (type) q; \
{ \
	if (ivar != q) { \
		[ivar release]; \
		ivar = [q copy]; \
	} \
	if (self.nativeHandle) \
		[self name##ApplyToHandle]; \
}

#define OIViewSynthesizeAssignAccessors(name, setterName, type, ivar) \
OIViewSynthesizeGetter(name, type, ivar) \
OIViewSynthesizeAssignSetter(name, setterName, type, ivar)

#define OIViewSynthesizeRetainAccessors(name, setterName, type, ivar) \
OIViewSynthesizeGetter(name, type, ivar) \
OIViewSynthesizeRetainSetter(name, setterName, type, ivar)

#define OIViewSynthesizeCopyAccessors(name, setterName, type, ivar) \
OIViewSynthesizeGetter(name, type, ivar) \
OIViewSynthesizeCopySetter(name, setterName, type, ivar)
