//
//  OIKeyboardEvent.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const OIPowerToggleKey;

extern NSString* const OIUpKey;
extern NSString* const OIDownKey;
extern NSString* const OILeftKey;
extern NSString* const OIRightKey;

extern NSString* const OI0Key;
extern NSString* const OI1Key;
extern NSString* const OI2Key;
extern NSString* const OI3Key;
extern NSString* const OI4Key;
extern NSString* const OI5Key;
extern NSString* const OI6Key;
extern NSString* const OI7Key;
extern NSString* const OI8Key;
extern NSString* const OI9Key;

extern NSString* const OIEscapeKey;
extern NSString* const OIReturnKey;

extern NSString* const OIIncreaseKey;
extern NSString* const OIDecreaseKey;

extern NSString* const OISpaceKey;

extern NSString* const OINextKey;
extern NSString* const OIPreviousKey;

extern NSString* const OIRotateScreenKey;
extern NSString* const OISearchKey;
extern NSString* const OIPlayPauseKey;


@interface OIKeyboardEvent : NSObject {
	id sender;
	NSString* key, * intendedKey, * inputString, * provisionalInputString;
	BOOL held;
}

- initWithSender:(id) se key:(NSString*) k /* modifiers:(-) modifiers locks:(-) locks */ intendedKey:(NSString*) i inputString:(NSString*) s provisionalInputString:(NSString*) p;

@property(readonly, retain) id sender;
@property(readonly, copy) NSString* key, * intendedKey, * inputString, * provisionalInputString;

@property(readonly, getter=isHeld) BOOL held;

@end
