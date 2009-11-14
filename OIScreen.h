//
//  OIScreen.h
//  Ohai
//
//  Created by ∞ on 14/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void* _OIScreenEvasXScreenRef;

@interface OIScreen : NSObject {
	_OIScreenEvasXScreenRef screenRef;
}

+ (OIScreen*) mainScreen;

@property(readonly) NSSize size;

@end
