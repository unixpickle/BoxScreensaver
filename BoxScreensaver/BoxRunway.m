//
//  BoxRunway.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BoxRunway.h"


@implementation BoxRunway

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		startDirection = IncomingDirectionLeft;
		[self setClipsToBounds:NO];
	}
	return self;
}

- (Box *)generateBox {
	minY = 10;
	maxY = [self frame].size.height - 10;
	CGFloat nextY = minY;
	if ([boxStack count] > 0) {
		Box * b = [boxStack lastObject];
		nextY = [b frame].size.height + [b frame].origin.y + minY;
	}
	Box * newBox = [[Box alloc] initWithFrame:CGRectMake(0, nextY, [self frame].size.width, [self frame].size.width)];
	[newBox setStartDirection:startDirection];
	// toggle start direction
	startDirection = (startDirection == IncomingDirectionLeft ? IncomingDirectionRight : IncomingDirectionLeft);
	return [newBox autorelease];
}

- (void)pushNewBox:(Box *)box {
	if (!boxStack) {
		boxStack = [[NSMutableArray alloc] init];
		NSAssert(minY != 0, @"-generateBox must be called before pushing a box.");
	}
	CGRect boxFrame = [box frame];
	if ([box startDirection] == IncomingDirectionLeft) {
		boxFrame.origin.x = ([[self superview] frame].size.width - [self frame].origin.x);
	} else {
		boxFrame.origin.x = -([self frame].origin.x) - boxFrame.size.width;
	}
	if (boxFrame.size.height + boxFrame.origin.y > maxY) {
		CGFloat moveUp = ([box frame].size.height + [box frame].origin.y) - maxY;
		// move all of the boxes up, including our new box.
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.75];
		for (int i = 0; i < [boxStack count]; i++) {
			Box * b = [boxStack objectAtIndex:i];
			// translate the frame to move up.
			CGRect br = [b frame];
			if (br.origin.y < 0 - br.size.height) {
				// remove views that go over the top.
				[boxStack removeObjectAtIndex:i];
				i--;
			} else {
				br.origin.y -= moveUp;
				[b setFrame:br];
			}
		}
		[UIView commitAnimations];
		boxFrame.origin.y = boxFrame.origin.y - moveUp;
	}
	[box setFrame:boxFrame];
	[self addSubview:box];
	boxFrame.origin.x = 0;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[box setFrame:boxFrame];
	[UIView commitAnimations];
	[boxStack addObject:box];
}

- (void)dealloc {
    [super dealloc];
}

@end
