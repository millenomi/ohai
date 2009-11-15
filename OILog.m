//
//  OILog.m
//  Ohai
//
//  Created by ∞ on 15/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OILog.h"
#import <stdarg.h>

extern void _OILog(NSString* channel, NSString* format, ...) {
	if (![[[[NSProcessInfo processInfo] environment] objectForKey:channel] boolValue])
		return;
	
	va_list list;
	va_start(list, format);
	NSString* toLog = [[NSString alloc] initWithFormat:format arguments:list];
	
	NSLog(@"[%@]: %@", channel, toLog);
	
	[toLog release];
	va_end(list);
}
