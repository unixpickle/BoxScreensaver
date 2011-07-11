//
//  CornerDropper.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CornerDropper.h"

@interface CornerDropper (Private)

+ (UIImage *)cornerRight;
+ (UIImage *)cornerLeft;

@end

@implementation CornerDropper

@synthesize acceptableClasses;
@synthesize cornerImage;

+ (UIImage *)cornerRight {
	static UIImage * cRight = nil;
	if (!cRight) cRight = [[UIImage imageNamed:@"drag_right.png"] retain];
	return cRight;
}
+ (UIImage *)cornerLeft {
	static UIImage * cLeft = nil;
	if (!cLeft) cLeft = [[UIImage imageNamed:@"drag_left.png"] retain];
	return cLeft;
}

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
	if ([self frame].origin.x == 0) {
		[[[self class] cornerLeft] drawInRect:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
		[cornerImage drawInRect:CGRectMake(15, 15, 80, 80)];
	} else {
		[[[self class] cornerRight] drawInRect:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
		[cornerImage drawInRect:CGRectMake([self frame].size.width - 90, 10, 80, 80)];
	}
	
}

- (void)dealloc {
	self.acceptableClasses = nil;
	self.cornerImage = nil;
	[super dealloc];
}

@end
