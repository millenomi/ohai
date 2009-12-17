
#import "OIMap.h"
#import "OITargets.h"

@implementation NSObject (OIIntentExtras)

- (id) intentDelegate;
{
	return self;
}

- (BOOL) canPerformIntent:(SEL) intent forObject:(id) r;
{
	return [self respondsToSelector:intent];
}

@end

@implementation OIMap

- (BOOL) performIntentForKeyUpEvent:(OIKeyboardEvent*) e on:(id) r;
{
	return NO;
}

- (BOOL) performIntentForKeyDownEvent:(OIKeyboardEvent*) e on:(id) r;
{
	return NO;
}

@end
