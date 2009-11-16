//
//  OIKeyboardEvent.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIKeyboardEvent.h"

NSString* const OIKeyPowerToggle = @"XF86PowerOff";

NSString* const OIKeyUpArrow = @"Up";
NSString* const OIKeyDownArrow = @"Down";
NSString* const OIKeyLeftArrow = @"Left";
NSString* const OIKeyRightArrow = @"Right";

NSString* const OIKeyNumber0 = @"KP_0";
NSString* const OIKeyNumber1 = @"KP_1";
NSString* const OIKeyNumber2 = @"KP_2";
NSString* const OIKeyNumber3 = @"KP_3";
NSString* const OIKeyNumber4 = @"KP_4";
NSString* const OIKeyNumber5 = @"KP_5";
NSString* const OIKeyNumber6 = @"KP_6";
NSString* const OIKeyNumber7 = @"KP_7";
NSString* const OIKeyNumber8 = @"KP_8";
NSString* const OIKeyNumber9 = @"KP_9";

NSString* const OIKeyEscape = @"Escape";
NSString* const OIKeyReturn = @"Return";

NSString* const OIKeyIncrease = @"KP_Add";
NSString* const OIKeyDecrease = @"KP_Subtract";

NSString* const OIKeySpace = @"space";

NSString* const OIKeyNext = @"Next";
NSString* const OIKeyPrevious = @"Prior";

NSString* const OIKeyRotateScreen = @"XF86RotateWindows";
NSString* const OIKeySearch = @"XF86Search";
NSString* const OIKeyPlayPause = @"XF86AudioPlay";

@interface OIKeyboardEvent ()

@property(retain) id sender;
@property(copy) NSString* key, * intendedKey, * inputString, * provisionalInputString;

@end


@implementation OIKeyboardEvent

- initWithSender:(id) se key:(NSString*) k intendedKey:(NSString*) i inputString:(NSString*) s provisionalInputString:(NSString*) p held:(BOOL) h;
{
	if (self = [super init]) {
		self.sender = se;
		self.key = k;
		self.intendedKey = i;
		self.inputString = s;
		self.provisionalInputString = p;
		held = h;
	}
	
	return self;
}

@synthesize sender;
@synthesize key, held, intendedKey, inputString, provisionalInputString;

- (void) dealloc
{
	self.sender = nil;
	self.key = nil;
	self.intendedKey = nil;
	self.inputString = nil;
	self.provisionalInputString = nil;
	
	[super dealloc];
}

- (NSString*) description;
{
	return [NSString stringWithFormat:@"%@ { key = %@, held = %d, intendedKey = %@, inputString = %@, provisional = %@ }", [super description], self.key, self.held, self.intendedKey, self.inputString, self.provisionalInputString];
}

@end
