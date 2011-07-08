//
//  Box.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Box.h"


@implementation Box

@synthesize startDirection;

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(ctx, 1, 1, 0.2, 1);
	CGContextFillRect(ctx, [self bounds]);
}

- (void)dealloc {
    [super dealloc];
}

@end
