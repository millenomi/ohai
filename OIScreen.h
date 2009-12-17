//
//  OIScreen.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void* OIScreenNativeHandle;

@interface OIScreen : NSObject {
	OIScreenNativeHandle native;
}

+ (OIScreen*) mainScreen;

@property(readonly) NSSize size;

@end
