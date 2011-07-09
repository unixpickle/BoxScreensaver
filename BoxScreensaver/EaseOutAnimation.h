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
	// F(t) = k(-0.75x^2 + 1.5x)
	// This is the product of k and the integral of our rate of change function:
	// f(t) = -1.5x + 1.5
	CGFloat easy_a;
	CGFloat easy_b;
	CGFloat easy_k; // depends on the destination.
}

- (id)initWithDuration:(CGFloat)theDuration destinationValue:(CGFloat)theDestination;

@end
