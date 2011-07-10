//
//  ViewPositionAnimation.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EaseOutSmoothAnimation.h"

/**
 * An animation that runs in the background to translate the origin
 * of a UIView.
 *
 * This class manages a global list of all active ViewPositionAnimation objects.
 * This will allow any view to find animations for its origin, and cancel them.
 */
@interface ViewPositionAnimation : NSObject {
    UIView * targetView;
	NSTimer * t;
	EasingAnimation * animationX;
	EasingAnimation * animationY;
	CGPoint start;
	CGPoint destination;
}

/**
 * Finds all active animations with a specified target.
 */
+ (NSArray *)activeAnimationsForView:(UIView *)theView;

/**
 * Cancels all animations on ALL views!
 */
+ (void)cancelActiveAnimations;

/**
 * Cancels all animations for a specified view.
 */
+ (void)cancelAnimationsForView:(UIView *)view;

/**
 * Create an eased animation that will translate the position of a view.
 * @param view The target view to which the animated translation will apply.
 * This object will be retained until the animation is deallocated.
 * @param dest The destination origin of the view's frame.
 * @return A new and unstarted animation.
 */
- (id)initWithView:(UIView *)view destinationLocation:(CGPoint)dest;

/**
 * Starts up a timer that will move the view to the destination.
 * This will retain the animation object.
 */
- (void)start:(CGFloat)duration;

/**
 * Cancels and autoreleases the animation.
 */
- (void)cancel;

/**
 * Returns the target of the animation.
 */
- (UIView *)targetView;

@end
