//
//  BoxRunway.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Box.h"
#import "ViewPositionAnimation.h"

@interface BoxRunway : UIView {
	NSMutableArray * boxStack;
	CGFloat minY;
	CGFloat maxY;
	IncomingDirection startDirection;
}

/**
 * Returns a new box that can be pushed to the box runway.
 */
- (Box *)generateBox;

/**
 * Creates a box of a specified class.  This can be used for concrete subclasses
 * of Box.
 * @param theClass The class that will be used while creating the new Box.
 * @return A box of class @param theClass.
 */
- (Box *)generateBoxOfClass:(Class)c;

/**
 * Adds a box to the bottom.
 */
- (void)pushNewBox:(Box *)box;

/**
 * Gets the first and therefore movable box on the runway.
 */
- (Box *)topBox;

/**
 * Removes a box from the runways stack, therefore stopping it
 * from animating.
 */
- (void)removeBox:(Box *)theBox;

@end
