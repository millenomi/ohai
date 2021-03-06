//
//  OIImageView.m
//  Ohai
//
//  Created by ∞ on 16/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OITargets.h"

#if OITargetFeatureEnlightenment

#import "OIImageView.h"
#import "OILog.h"
#import <Evas.h>

@implementation OIImageView

- (id) initWithImageAtPath:(NSString*) p;
{
	if (self = [super init]) {
		self.imagePath = p;
	}
	
	return self;
}

+ (id) imageViewWithImageAtPath:(NSString*) path;
{
	return [[[self alloc] initWithImageAtPath:path] autorelease];
}

- (NSArray*) boundKeys;
{
	NSMutableArray* k = [NSMutableArray arrayWithArray:[super boundKeys]];
	[k removeObject:@"color"];
	[k addObject:@"sizeImageFrameToFit"];
	[k addObject:@"imageFrame"];
	[k addObject:@"imagePath"];
	return k;
}

- (OIViewNativeHandle) createNativeObjectByAddingToNativeCanvas:(OICanvasNativeHandle)canvas;
{
	return evas_object_image_add(canvas);
}

// -- Image Path --

// TODO implement NSFileManager in Cocotron.

- (void) imagePathApplyToHandle;
{
	evas_object_image_file_set(self.nativeHandle, imagePath? [imagePath UTF8String] : NULL, NULL);
	if (imagePath) {
		evas_object_image_reload(self.nativeHandle);
		int error = evas_object_image_load_error_get(self.nativeHandle);
		if (error != EVAS_LOAD_ERROR_NONE) {
			// TODO non-exception way to report the error.
			[NSException raise:@"OIImageViewCouldNotLoadImageException" format:@"Load error is %d", error];
		}
	}
}

- (NSString*) imagePathDescription;
{
	return self.imagePath;
}

- (NSString*) imagePathByQueryingHandle;
{
	const char* file, * key;
	evas_object_image_file_get(self.nativeHandle, &file, &key);

	_OILog(OIWindowViewLog, @"Image path from handle was %s", file? file : "((null))");
	
	return file? [NSString stringWithCString:file encoding:NSUTF8StringEncoding] : nil;
}

OIViewSynthesizeCopyAccessors(imagePath, setImagePath:, NSString*, imagePath)

// -- Image Frame --

- (void) imageFrameApplyToHandle;
{
	NSRect r = imageFrame;
	if (!sizeImageFrameToFit)
		evas_object_image_fill_set(self.nativeHandle, r.origin.x, r.origin.y, r.size.width, r.size.height);
}

- (NSString*) imageFrameDescription;
{
	return NSStringFromRect(self.imageFrame);
}

- (NSRect) imageFrameByQueryingHandle;
{
	Evas_Coord x, y, w, h;
	evas_object_image_fill_get(self.nativeHandle, &x, &y, &w, &h);
	return NSMakeRect(x, y, w, h);
}

OIViewSynthesizeAssignAccessors(imageFrame, setImageFrame:, NSRect, imageFrame)

// -- Size to fit --

- (void) sizeImageFrameToFitApplyToHandle;
{
	evas_object_image_filled_set(self.nativeHandle, sizeImageFrameToFit? EINA_TRUE : EINA_FALSE);
}

- (NSString*) sizeImageFrameToFitDescription;
{
	return self.sizeImageFrameToFit? @"YES" : @"NO";
}

- (BOOL) sizeImageFrameToFitByQueryingHandle;
{
	return evas_object_image_filled_get(self.nativeHandle) == EINA_TRUE;
}

OIViewSynthesizeAssignAccessors(sizeImageFrameToFit, setSizeImageFrameToFit:, BOOL, sizeImageFrameToFit)

// -- Image views ignore the .color property --

- (OIColor) color;
{
	return OIColorClear;
}

- (void) setColor:(OIColor) c;
{
	// Do nothing.
}

// -- Image info --

- (NSSize) imageSize;
{
	if (!self.nativeHandle)
		return NSZeroSize;
	
	int w, h;
	evas_object_image_size_get(self.nativeHandle, &w, &h);
	return NSMakeSize(w, h);
}

- (BOOL) isImageInformationAvailable;
{
	return self.nativeHandle != nil;
}

@end

#else
#error This file should only be included in an Enlightenment build.
#endif
