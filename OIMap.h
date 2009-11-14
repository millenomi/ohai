//
//  OIMap.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIKeyboardEvent.h"

@interface OIMap : NSObject {} // abstract.

- (BOOL) performIntentForKeyUpEvent:(OIKeyboardEvent*) e on:(id) r;
- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent*) e on:(id) r;

+ pageNavigationMap;
+ actionMap;
+ arrowsMap;
+ textInputMap;
+ advancedControlsMap;

@end

@interface NSObject (OIIntents)

// Intents for actionMap.
- (void) cancelOrBack;
- (void) forceCancelOrBack; // cancel held.
- (void) performAction;
- (void) showActions;
// YES while pressing a multi-use OK key causes an obvious action to happen. NO at any other time.
- (BOOL) canPerformAction; // optional -- YES if unimplemented.

// Intents for textInputMap.
- (void) appendString:(NSString*) string;
- (void) setProvisionalString:(NSString*) provisionalString; // optional

// Intents for pageNavigationMap.
- (void) nextPage;
- (void) previousPage;

// Intents for arrowsMap.
- (void) up;
- (void) down;
- (void) left;
- (void) right;

// Intents for advancedControlsMap.
- (void) bookmark;
- (void) showDestinationsList;
- (void) zoom;
- (void) search;

@end
