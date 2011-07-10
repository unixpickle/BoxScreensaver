//
//  ViewPositionAnimation.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewPositionAnimation.h"

@interface ViewPositionAnimation (Private)

+ (NSMutableArray *)globalAnimationList;
- (void)animationStep;

@end

@implementation ViewPositionAnimation

#pragma mark Static Animation List

+ (NSMutableArray *)globalAnimationList {
	static NSMutableArray * array = nil;
	if (!array) array = [[NSMutableArray alloc] init];
	return array;
}

+ (NSArray *)activeAnimationsForView:(UIView *)theView {
	NSMutableArray * global = [self globalAnimationList];
	NSMutableArray * viewAnimations = [[NSMutableArray alloc] init];
	for (ViewPositionAnimation * animation in global) {
		if ([animation targetView] == theView) {
			[viewAnimations addObject:animation];
		}
	}
	NSArray * immutable = [NSArray arrayWithArray:viewAnimations];
	[viewAnimations release];
	return immutable;
}

+ (void)cancelActiveAnimations {
	NSMutableArray * global = [self globalAnimationList];
	while ([global count] > 0) {
		[[global lastObject] cancel];
	}
}

+ (void)cancelAnimationsForView:(UIView *)view {
	NSMutableArray * global = [self globalAnimationList];
	for (int i = 0; i < [global count]; i++) {
		ViewPositionAnimation * animation = [global objectAtIndex:i];
		if ([animation targetView] == view || view == nil) {
			[animation cancel];
			i--;
		}
	}
}

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithView:(UIView *)view destinationLocation:(CGPoint)dest {
	if ((self = [super init])) {
		targetView = [view retain];
		destination = dest;
	}
	return self;
}

- (void)start:(CGFloat)duration {
	NSMutableArray * global = [[self class] globalAnimationList];
	if (![global containsObject:self]) [global addObject:self];
	start = [targetView frame].origin;
	if (destination.x != start.x) {
		animationX = [[EaseOutSmoothAnimation alloc] initWithDuration:duration destinationValue:(destination.x - start.x)];
	}
	if (destination.y != start.y) {
		animationY = [[EaseOutSmoothAnimation alloc] initWithDuration:duration destinationValue:(destination.y - start.y)];
	}
	// create a timer at 24FPS
	[t invalidate];
	t = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 24.0) target:self selector:@selector(animationStep) userInfo:nil repeats:YES];
}

- (void)animationStep {
	CGPoint newPosition = start;
	BOOL didMove = NO;
	if (animationX) {
		CGFloat movedX;
		if ([animationX getValueForCurrentTime:&movedX]) didMove = YES;
		newPosition.x += movedX;
	}
	if (animationY) {
		CGFloat movedY;
		if ([animationY getValueForCurrentTime:&movedY]) didMove = YES;
		newPosition.y += movedY;
	}
	CGRect viewFrame = [targetView frame];
	viewFrame.origin = newPosition;
	[targetView setFrame:viewFrame];
	if (!didMove) {
		[self cancel];
	}
}

- (void)cancel {
	[self retain];
	[t invalidate];
	t = nil;
	[self autorelease];
	NSMutableArray * global = [[self class] globalAnimationList];
	if ([global containsObject:self]) [global removeObject:self];
}

- (UIView *)targetView {
	return targetView;
}

- (void)dealloc {
	[animationX release];
	[animationY release];
	[targetView release];
    [super dealloc];
}

@end
