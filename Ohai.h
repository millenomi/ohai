/**
 \mainpage
 
 Ohai is a library designed to be used in OpenInkpot.org devices to create applications for e-book readers. It resembles Cocoa's AppKit and Cocoa Touch's UIKit in general structure and use, and borrows many terms and design decisions from these two frameworks while mapping them over OpenInkpot's preferred Enlightenment libraries (especially Ecore and Evas).
 
 An application is represented in Ohai by an instance of the OIApplication class; this application manages one or more windows, whose contents are drawn by using view objects. A window corresponds to an Ecore_Evas instance, while a view (with many caveats) to a Evas_Object instance.
 
 Events are relayed through a responder chain similar to Cocoa's, but are not encapsulated in object; rather, an event is represented by a message sent to a responder object, which can relay this message to its next responder if desired (typically if the event was not handled). Events are "raw" -- stimuli coming from the user without interpretation -- but OIResponder has a facility that can allow the responder to map the event to an "intent" depending on the device the app runs on. A responder uses one or more OIMap objects representing the logical intents the user may express and can optionally relay those messages to an "intent delegate", allowing a controller to receive a view's events.
 
 */

#import <Ohai/OIApplication.h>
#import <Ohai/OIScreen.h>
#import <Ohai/OIWindow.h>

#import <Ohai/OIKeyboardEvent.h>
#import <Ohai/OIResponder.h>
#import <Ohai/OIMap.h>

#import <Ohai/OIView.h>
#import <Ohai/OIColor.h>
#import <Ohai/OIRectangle.h>
#import <Ohai/OIImageView.h>
