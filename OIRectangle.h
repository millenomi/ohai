//
//  OIRectangle.h
//  Ohai
//
//  Created by ∞ on 16/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OIView.h"

@interface OIRectangle : OIView {

}

// Convenience constructors.
- (id) initWithFrame:(NSRect) frame;
+ (id) rectangleWithFrame:(NSRect) frame;

@end
