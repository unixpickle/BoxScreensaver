//
//  EaseOutAnimation.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasingAnimation.h"

@interface EaseOutAnimation : NSObject {
    CGFloat duration;
	CGFloat destination;
	NSDate * startDate;
	// our easing function looks like this:
	// F(t) = k(-0.2x^2 + 1.2x)
	// This is the integral of our rate of change function:
	// f(t) = -0.4x + 1.2
	CGFloat easy_a; // -0.2
	CGFloat easy_b; // 1.2
	CGFloat easy_k; // depends on the duration and destination.
}

- (id)initWithDuration:(CGFloat)theDuration destinationValue:(CGFloat)theDestination;

@end
