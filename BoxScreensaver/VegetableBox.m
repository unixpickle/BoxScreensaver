//
//  VegetableBox.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VegetableBox.h"


@implementation VegetableBox

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		startDirection = IncomingDirectionLeft;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	static UIImage * broccoli = nil;
	if (!broccoli) {
		broccoli = [[UIImage imageNamed:@"broccoli_large.png"] retain];
	}
	[broccoli drawInRect:[self bounds]];
}

- (void)dealloc {
    [super dealloc];
}

@end
