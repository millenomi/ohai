//
//  OIImageView.h
//  Ohai
//
//  Created by ∞ on 16/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIView.h"

@interface OIImageView : OIView {
	NSString* imagePath;
	NSRect imageFrame;
	BOOL sizeImageFrameToFit;
}

// Designated.
- (id) initWithImageAtPath:(NSString*) path;
+ (id) imageViewWithImageAtPath:(NSString*) path;

@property(copy) NSString* imagePath;
@property(assign) NSRect imageFrame;

@property(assign) BOOL sizeImageFrameToFit;

@property(readonly) NSSize imageSize;
@property(readonly, getter=isImageInformationAvailable) BOOL imageInformationAvailable;

@end
