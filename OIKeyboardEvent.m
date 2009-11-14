//
//  OIKeyboardEvent.m
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIKeyboardEvent.h"

NSString* const OIPowerToggleKey = @"XF86PowerOff";

NSString* const OIUpKey = @"Up";
NSString* const OIDownKey = @"Down";
NSString* const OILeftKey = @"Left";
NSString* const OIRightKey = @"Right";

NSString* const OI0Key = @"KP_0";
NSString* const OI1Key = @"KP_1";
NSString* const OI2Key = @"KP_2";
NSString* const OI3Key = @"KP_3";
NSString* const OI4Key = @"KP_4";
NSString* const OI5Key = @"KP_5";
NSString* const OI6Key = @"KP_6";
NSString* const OI7Key = @"KP_7";
NSString* const OI8Key = @"KP_8";
NSString* const OI9Key = @"KP_9";

NSString* const OIEscapeKey = @"Escape";
NSString* const OIReturnKey = @"Return";

NSString* const OIIncreaseKey = @"KP_Add";
NSString* const OIDecreaseKey = @"KP_Subtract";

NSString* const OISpaceKey = @"space";

NSString* const OINextKey = @"Next";
NSString* const OIPreviousKey = @"Prior";

NSString* const OIRotateScreenKey = @"XF86RotateWindows";
NSString* const OISearchKey = @"XF86Search";
NSString* const OIPlayPauseKey = @"XF86AudioPlay";

@interface OIKeyboardEvent ()

@property(retain) id sender;
@property(copy) NSString* key, * intendedKey, * inputString, * provisionalInputString;

@end


@implementation OIKeyboardEvent

- initWithSender:(id) se key:(NSString*) k intendedKey:(NSString*) i inputString:(NSString*) s provisionalInputString:(NSString*) p;
{
	if (self = [super init]) {
		self.sender = se;
		
		if ([k hasPrefix:@"Hold-"] && ![k isEqual:@"Hold-"]) {
			held = YES;
			k = [k substringFromIndex:5];
		}
		
		self.key = k;
		self.intendedKey = i;
		self.inputString = s;
		self.provisionalInputString = p;
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
