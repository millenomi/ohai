//
//  OIMap.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIMap.h"

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

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)r;
{
	if ([e.key isEqual:OIKeyLeftArrow] || [e.key isEqual:OIKeyUpArrow] || [e.key isEqual:OIKeyNumber9]) {
		[r previousPage];
		return YES;
	} else if ([e.key isEqual:OIKeyRightArrow] || [e.key isEqual:OIKeyDownArrow] || [e.key isEqual:OIKeyNumber0]) {
		[r nextPage];
		return YES;
	}
	
	return NO;
}

@end

@implementation OIActionMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)r;
{
	if ([e.key isEqual:OIKeyEscape]) {
		if (e.held)
			[r forceCancelOrBack];
		else
			[r cancelOrBack];
		
		return YES;
	} else if ([e.key isEqual:OIKeyReturn]) {
		if (![r respondsToSelector:@selector(canPerformAction)] || [r canPerformAction])
			[r performAction];
		else
			[r showActions];
		
		return YES;
	}
	
	return NO;
}

@end

@implementation OIArrowsMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)r;
{
	if ([e.key isEqual:OIKeyNumber2]) {
		[r up];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber7]) {
		[r down];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber8]) {
		[r right];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber6]) {
		[r left];
		return YES;
	}
	
	return NO;
}

@end

@implementation OITextInputMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)r;
{
	if (e.inputString)
		[r appendString:e.inputString];
	
	if (e.provisionalInputString && [r respondsToSelector:@selector(setProvisionalString:)])
		[r setProvisionalString:e.provisionalInputString];
	
	return e.inputString && e.provisionalInputString;
}

@end

@implementation OIAdvancedControlsMap_HanlinV3

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent *)e on:(id)r;
{
	if ([e.key isEqual:OIKeyNumber6]) {
		[r bookmark];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber7]) {
		[r showDestinationsList];
		return YES;
	} else if ([e.key isEqual:OIKeyNumber8]) {
		[r zoom];
		return YES;
	}
	
	return NO;
}

@end
