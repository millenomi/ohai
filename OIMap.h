//
//  OIMap.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIKeyboardEvent.h"

/**
An input map maps keyboard events to "intents", probable user intentions. The built-in maps enable you to receive page navigation, action, 4-way arrows, text input and 'advanced controls' intents by mapping them to the known key layouts of the current device.

\bug For now, this class only supports the Hanlin V3.
*/
@interface OIMap : NSObject {} // abstract.

/**
	Parses this key-up event, and sends the resulting intent messages, if any, to \a r or its intent delegate. (See NSObject(OIIntentDelegate)::intentDelegate.)
*/
- (BOOL) performIntentForKeyUpEvent:(OIKeyboardEvent*) e on:(id) r;
/**
	Parses this key-down event, and sends the resulting intent messages, if any, to \a r or its intent delegate. (See NSObject::intentDelegate.)
*/
- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent*) e on:(id) r;

@end

@interface OIMap (OIDeviceDependentMaps)

/**
Adding this map to a responder enables 'next page' and 'previous page' navigation intents, tied to existing page next/back keys or suitable replacements.
*/
+ pageNavigationMap;

/**
Adding this map to a responder enables 'back', 'act' ('OK') and 'show actions menu' intents.
*/
+ actionMap;

/**
Adding this map to a responder enables intents tied to a 4-way directional pad. If the device has no directional pad, it may use other keys to simulate one.
*/
+ arrowsMap;

/**
Adding this map to a responder allows it to receive the text insertion content of key presses, allowing it to receive text input.
*/
+ textInputMap;

/**
Adding this map to a responder allows it to receive intents tied to either special function keys or the secondary, labeled function of other keys. (For example, a numeric key also labeled with a 'bookmark' icon may cause a 'bookmark' intent to be produced by this map.)
*/
+ advancedControlsMap;

@end

/** \category OIIntentDelegate
Contains the intentDelegate method, which allows a map to retarget an intent message.
*/
@interface NSObject (OIIntentExtras)

/** \addtogroup categories Categories. */
/*@{*/

/**
Any object may implement this method to indicate that their intent messages must be sent not to themselves, but to another object. OIResponder has a corresponding property for easy overriding.
*/
- (id) intentDelegate;

/**
 This method is called before any intent method is to check whether, in the current state of this object, handling this intent makes sense. It can be used to try other intents, or to pass the event up the responder chain (by returning NO from OIMap's methods) to some other object that can.
 
 The default implementation returns YES if the method was implemented in the receiver's class, NO otherwise.
 
 \param intent The intent selector that's going to be invoked.
 \param r The original receiver of the intent. This is the object that received the event (which is the same as the receiver unless that object has an intent delegate).
 */
- (BOOL) canPerformIntent:(SEL) intent forObject:(id) r;

/*@}*/

@end

/** \category OIIntents
Contains intent messages that are sent by the built-in maps.
*/
@interface NSObject (OIIntents)

/** \addtogroup actionMap Action intents (for OIMap::actionMap). */
/*@{*/
- (void) cancelOrBack; /**< Sent when the user presses a 'Cancel' or 'Back' button. Usually cancels the current operation or goes back to the previous screen or application (for example, by exiting). */
- (void) forceCancelOrBack; /**< Sent when the user tries to cancel an operation with force (for example, by holding a key). Should terminate the application or go back all the way to the initial screen of an application. */
- (void) performAction; /**< Sent when the user confirms an action, for example by pressing 'OK'. */
- (void) showActions; /**< Sent when the user requires a list of actions. */
// YES while pressing a multi-use OK key causes an obvious action to happen. NO at any other time.
- (BOOL) canPerformAction; // optional -- YES if unimplemented.
/*@}*/

/** \addtogroup textInputMap Text input intents (for OIMap::textInputMap). */
/*@{*/
- (void) appendString:(NSString*) string; /**< Sent when the user presses a key that causes input, to insert the given string in the current position. */
- (void) setProvisionalString:(NSString*) provisionalString;  /**< Sent as the system produces a provisional text as a hint for further input. See OIKeyboardEvent::provisionalInputString. */
/*@}*/

/** \addtogroup pageNavigationMap Page navigation intents (for OIMap::pageNavigationMap). */
/*@{*/
- (void) nextPage; /**< Moves to the next page in a sequence of pages. */
- (void) previousPage; /**< Moves to the previous page in a sequence of pages. */
/*@}*/

/** \addtogroup arrowsMap 4-way directional pad intents (for OIMap::arrowsMap). */
/*@{*/
- (void) up; /**< Sent when the up arrow in a d-pad is pressed. */
- (void) down; /**< Sent when the down arrow in a d-pad is pressed. */
- (void) left; /**< Sent when the left arrow in a d-pad is pressed. */
- (void) right; /**< Sent when the right arrow in a d-pad is pressed. */
/*@}*/

/** \addtogroup advancedControlsMap Advanced action intents (for OIMap::advancedControlsMap). */
/*@{*/
- (void) bookmark; /**< Sent when the user presses a button to show or add bookmarks. */
- (void) showDestinationsList; /**< Sent when the user presses a button to list chapters, links or destinations. */
- (void) zoom; /**< Sent when the user presses a button to toggle a zoom level. */
- (void) search; /**< Sent when the user presses a button to begin a search in the current content. */
/*@}*/

@end
