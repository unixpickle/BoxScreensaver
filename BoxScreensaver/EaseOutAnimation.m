//
//  EaseOutAnimation.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EaseOutAnimation.h"


@implementation EaseOutAnimation

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithDuration:(CGFloat)theDuration destinationValue:(CGFloat)theDestination {
	if ((self = [super init])) {
		easy_a = -0.75;
		easy_b = 1.5;
		easy_k = theDestination / ((easy_a * pow(theDuration, 2)) + (easy_b * theDuration));
		startDate = [[NSDate date] retain];
		duration = theDuration;
		destination = theDestination;
	}
	return self;
}

- (CGFloat)duration {
	return duration;
}

- (BOOL)getValueForCurrentTime:(CGFloat *)value {
	NSTimeInterval timeElapsed = [[NSDate date] timeIntervalSinceDate:startDate];
	if (timeElapsed >= duration) {
		*value = destination;
		return NO;
	}
	*value = easy_k * ((easy_a * pow(timeElapsed, 2)) + (easy_b * timeElapsed));
	return YES;
}

- (void)dealloc {
	[startDate release];
    [super dealloc];
}

@end
