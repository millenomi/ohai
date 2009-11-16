//
//  OIKeyboardEvent.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const OIKeyPowerToggle;

extern NSString* const OIKeyUpArrow;
extern NSString* const OIKeyDownArrow;
extern NSString* const OIKeyLeftArrow;
extern NSString* const OIKeyRightArrow;

extern NSString* const OIKeyNumber0;
extern NSString* const OIKeyNumber1;
extern NSString* const OIKeyNumber2;
extern NSString* const OIKeyNumber3;
extern NSString* const OIKeyNumber4;
extern NSString* const OIKeyNumber5;
extern NSString* const OIKeyNumber6;
extern NSString* const OIKeyNumber7;
extern NSString* const OIKeyNumber8;
extern NSString* const OIKeyNumber9;

extern NSString* const OIKeyEscape;
extern NSString* const OIKeyReturn;

extern NSString* const OIKeyIncrease;
extern NSString* const OIKeyDecrease;

extern NSString* const OIKeySpace;

extern NSString* const OIKeyNext;
extern NSString* const OIKeyPrevious;

extern NSString* const OIKeyRotateScreen;
extern NSString* const OIKeySearch;
extern NSString* const OIKeyPlayPayse;


@interface OIKeyboardEvent : NSObject {
	id sender;
	NSString* key, * intendedKey, * inputString, * provisionalInputString;
	BOOL held;
}

- initWithSender:(id) se key:(NSString*) k /* modifiers:(-) modifiers locks:(-) locks */ intendedKey:(NSString*) i inputString:(NSString*) s provisionalInputString:(NSString*) p held:(BOOL) held;

@property(readonly, retain) id sender;
@property(readonly, copy) NSString* key, * intendedKey, * inputString, * provisionalInputString;

@property(readonly, getter=isHeld) BOOL held;

@end
