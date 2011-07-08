//
//  BoxRunway.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Box.h"

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
 * Adds a box to the bottom.
 */
- (void)pushNewBox:(Box *)box;

@end
