
#import <stdint.h>

/**
	\file
	This file defines the OIColor structure and utility functions and macros to produce colors.
*/

/**
	An OIColor is a set of RGB color values. Unlike corresponding objects in AppKit and UIKit, this is a structure and is not associated with any specific colorspace; rather, it is interpreted and possibly color-corrected by the object that happens to use it for actual drawing (usually a view or window).
	
	Even though this is an RGB color, all devices that run OpenInkpot have a grayscale screen; colors other than grays will be turned to monochrome by the OS when drawn on these devices.
	
	All fields of this structure are integer with a range going from 0x00 (black) to 0xFF (white).
 */
typedef struct {
	uint8_t red, green, blue, alpha;
} OIColor;

/**
	Makes an OIColor using integer values in the range 0x00 to 0xFF for each component.
*/
static inline OIColor OIColorMakeInt(uint8_t r, uint8_t g, uint8_t b, uint8_t a) {
	OIColor c;
	c.red = r; c.green = g;
	c.blue = b;	c.alpha = a;
	return c;
}

/**
	Makes an OIColor using fractional values for colors, as is usual in other frameworks. These values will be each mapped to a value in the OIColor integer range.
*/
static inline OIColor OIColorMake(float r, float g, float b, float a) {
	return OIColorMakeInt(r * 255, g * 255, b * 255, a * 255);
}

/*
	Makes an OIColor that is a grayscale color. All components of a grayscale color, save alpha, are equal.
*/
static inline OIColor OIColorMakeGray(float gray, float alpha) {
	return OIColorMake(gray, gray, gray, alpha);
}

#define OIColorWhite OIColorMakeGray(1.0, 1.0) /**< The white color, with no alpha transparency. */
#define OIColorBlack OIColorMakeGray(0.0, 1.0) /**< The black color, with no alpha transparency. */
#define OIColorClear OIColorMakeGray(0.0, 0.0) /**< A color with full alpha transparency (that is, completely transparent). */

/**
	Returns a NSString that describes the content of \a c. Useful for debugging. The string does not have an easily parseable structure and may change with different versions of the library; parsing it back into a color is not recommended.
*/
static inline NSString* NSStringFromOIColor(OIColor c) {
	return [NSString stringWithFormat:@"(OIColor) { .red = %d, .green = %d, .blue = %d, .alpha = %d }", c.red, c.green, c.blue, c.alpha];
}
