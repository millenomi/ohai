//
//  OIPagedController.m
//  Ohai
//
//  Created by ∞ on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OIPagedController.h"


@interface OIPagedController ()

- (void) moveAwayFromCurrentPage;
- (void) moveOntoCurrentPage;

@end


@implementation OIPagedController

- (id) initWithFrame:(NSRect) r inWindow:(OIWindow*) w;
{
	if (self = [super init]) {
		self.frame = r;
		self.window = w;
		self.pages = [NSArray array];
		
		[self addMap:[OIMap pageNavigationMap]];
	}
	
	return self;
}

+ (id) pagedControllerWithFrame:(NSRect) r inWindow:(OIWindow*) w;
{
	return [[[self alloc] initWithFrame:r inWindow:w] autorelease];
}

@synthesize frame, window, pages, currentPage, currentPageIndex;

- (void) dealloc
{
	self.window = nil;
	self.currentPage = nil;
	self.pages = nil;
	[super dealloc];
}

// -- - --

- (void) setPages:(NSArray*) p;
{
	if (pages != p) {
		[pages release];
		p = [pages retain];

		if (![pages containsObject:self.currentPage])
			self.currentPage = ([pages count] == 0? nil : [pages objectAtIndex:0]);
	}
}

- (void) setCurrentPage:(OIPage *) p;
{
	NSInteger idx = p? [self.pages indexOfObject:p] : NSNotFound;
	NSAssert(!p || idx != NSNotFound, @"Cannot assign a current page that's not in the .pages array.");
	
	if (p == currentPage)
		return;
	
	if (currentPage)
		[self moveAwayFromCurrentPage];
	currentPage = p;
	currentPageIndex = idx;
	if (currentPage)
		[self moveOntoCurrentPage];
}

- (void) moveAwayFromCurrentPage;
{
	[self.currentPage removeFromWindow];
}

- (void) moveOntoCurrentPage;
{
	[self.currentPage addWithFrame:self.frame inWindow:self.window nextResponder:self];
}

- (void) setCurrentPageIndex:(NSInteger) i;
{
	self.currentPage = (i == NSNotFound? nil : [self.pages objectAtIndex:i]);
}

// -- - --

- (id) nextResponder;
{
	id x = [super nextResponder];
	if (!x)
		x = self.window;
	return x;
}

- (BOOL) canPerformIntent:(SEL)intent forObject:(id)r;
{
	if (intent == @selector(nextPage))
		return currentPageIndex < [self.pages count] - 1;
	else if (intent == @selector(previousPage))
		return currentPageIndex != 0;
	
	return [super canPerformIntent:intent forObject:r];
}

- (void) nextPage;
{
	NSInteger nextPage = self.currentPageIndex + 1;
	NSAssert(nextPage < [self.pages count], @"Must not go out of bounds.");
	
	self.currentPageIndex = nextPage;
}

- (void) previousPage;
{
	NSInteger prevPage = self.currentPageIndex - 1;
	NSAssert(prevPage >= 0, @"Must not go out of bounds.");
	
	self.currentPageIndex = prevPage;
}

@end
