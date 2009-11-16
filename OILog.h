//
//  OILog.h
//  Ohai
//
//  Created by ∞ on 15/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
\internal
This function is used by the framework to log debug messages. This function takes a channel, which corresponds to an environment variable; if that variable parses as YES, the message will be emitted. See other headers to check whether they offer any debug channel of their own.

\param channel The channel this text will be printed on.
\param text A NSLog-like format string.
*/
extern void _OILog(NSString* channel, NSString* text, ...);