//
//  FruitBox.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FruitBox.h"


@implementation FruitBox

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		startDirection = IncomingDirectionRight;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	static UIImage * appleImage = nil;
	if (!appleImage) {
		appleImage = [[UIImage imageNamed:@"apple_large.png"] retain];
	}
	[appleImage drawInRect:[self bounds]];
}

- (void)dealloc {
    [super dealloc];
}

@end
