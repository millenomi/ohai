//
//  OIMap.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIMap.h"
#import "OIResponder.h"
#import "OILog.h"

#define OIMLog(intent, event, object) _OILog(OIResponderEventLog, @"%@: performing intent %@ for event %@ on object %@ (intent delegate %@)", self, intent, event, object, [object intentDelegate])

// Hanlin V3 maps.

@interface OIPageNavigationMap_HanlinV3 : OIMap {}
@end

@interface OIActionMap_HanlinV3 : OIMap {}
@end

@interface OIArrowsMap_HanlinV3 : OIMap {}
@end

@interface OITextInputMap_HanlinV3 : OIMap {}
@end

@interface OIAdvancedControlsMap_HanlinV3 : OIMap {}
@end


@implementation OIMap

- (BOOL) performIntentForKeyUpEvent:(OIKeyboardEvent*) e on:(id) r;
{
	return NO;
}

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent*) e on:(id) r;
{
	return NO;
}

// TODO multidevice

+ pageNavigationMap;
{
	return [[OIPageNavigationMap_HanlinV3 new] autorelease];
}

+ actionMap;
{
	return [[OIActionMap_HanlinV3 new] autorelease];	
}

+ arrowsMap;
{
	return [[OIArrowsMap_HanlinV3 new] autorelease];
}

+ textInputMap;
{
	return [[OITextInputMap_HanlinV3 new] autorelease];
}

+ advancedControlsMap;
{
	return [[OIAdvancedControlsMap_HanlinV3 new] autorelease];
}

@end

// -- - --

// Hanlin V3 map implementations

@implementation OIPageNavigationMap_HanlinV3 : OIMap

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)rorig;
{
	id r = [rorig intentDelegate];
	if ([e.key isEqual:OIKeyLeftArrow] || [e.key isEqual:OIKeyUpArrow] || [e.key isEqual:OIKeyNumber9]) {
		OIMLog(@"Previous page", e, rorig);
		[r previousPage];
		return YES;
	} else if ([e.key isEqual:OIKeyRightArrow] || [e.key isEqual:OIKeyDownArrow] || [e.key isEqual:OIKeyNumber0]) {
		OIMLog(@"Next page", e, rorig);
		[r nextPage];
		return YES;
	}
	
	return NO;
}

@end

@implementation OIActionMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)rorig;
{
	id r = [rorig intentDelegate];
	if ([e.key isEqual:OIKeyEscape]) {
		if (e.held) {
			OIMLog(@"Force cancel", e, rorig);
			[r forceCancelOrBack];
		} else {
			OIMLog(@"Cancel", e, rorig);
			[r cancelOrBack];
		}
		
		return YES;
	} else if ([e.key isEqual:OIKeyReturn]) {
		if (![r respondsToSelector:@selector(canPerformAction)] || [r canPerformAction]) {
			OIMLog(@"Perform action", e, rorig);
			[r performAction];
		} else {
			OIMLog(@"Show actions", e, rorig);
			[r showActions];
		}
		
		return YES;
	}
	
	return NO;
}

@end

@implementation OIArrowsMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)rorig;
{
	id r = [rorig intentDelegate];
	if ([e.key isEqual:OIKeyNumber2]) {
		OIMLog(@"Up", e, rorig);
		[r up];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber7]) {
		OIMLog(@"Down", e, rorig);
		[r down];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber8]) {
		OIMLog(@"Right", e, rorig);
		[r right];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber6]) {
		OIMLog(@"Left", e, rorig);
		[r left];
		return YES;
	}
	
	return NO;
}

@end

@implementation OITextInputMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)rorig;
{
	id r = [rorig intentDelegate];
	if (e.inputString) {
		OIMLog(@"Append string", e, rorig);
		[r appendString:e.inputString];
	}
	
	if (e.provisionalInputString && [r respondsToSelector:@selector(setProvisionalString:)]) {
		OIMLog(@"Set provisional string", e, rorig);
		[r setProvisionalString:e.provisionalInputString];
	}
	
	return e.inputString && e.provisionalInputString;
}

@end

@implementation OIAdvancedControlsMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)rorig;
{
	id r = [rorig intentDelegate];
	if ([e.key isEqual:OIKeyNumber6]) {
		OIMLog(@"Bookmark", e, rorig);
		[r bookmark];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber7]) {
		OIMLog(@"Show destinations list", e, rorig);
		[r showDestinationsList];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber8]) {
		OIMLog(@"Zoom", e, rorig);
		[r zoom];
		return YES;
	}
	
	return NO;
}

@end

@implementation NSObject (OIIntentDelegate)

- (id) intentDelegate;
{
	return self;
}

@end
