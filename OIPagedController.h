//
//  OIPagedController.h
//  Ohai
//
//  Created by ∞ on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIWindow.h"
#import "OIResponder.h"
#import "OIPage.h"

@interface OIPagedController : OIResponder {
	OIWindow* window;
	NSRect frame;
	NSArray* pages;
	OIPage* currentPage;
	NSInteger currentPageIndex;
}

- (id) initWithFrame:(NSRect) r inWindow:(OIWindow*) w;
+ (id) pagedControllerWithFrame:(NSRect) r inWindow:(OIWindow*) w;

@property(retain) OIWindow* window;
@property(assign) NSRect frame;

@property(copy) NSArray* pages;
@property(assign) OIPage* currentPage;
@property(assign) NSInteger currentPageIndex;

@end
