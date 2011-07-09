//
//  CornerDropper.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CornerDropper.h"


@implementation CornerDropper

@synthesize acceptableClasses;
@synthesize cornerImage;

- (BOOL)acceptDrop:(NSObject *)theObject {
	if ([acceptableClasses containsObject:NSStringFromClass([theObject class])]) {
		return YES;
	}
	return NO;
}

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[cornerImage drawInRect:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
}

- (void)dealloc {
	self.acceptableClasses = nil;
	self.cornerImage = nil;
	[super dealloc];
}

@end
