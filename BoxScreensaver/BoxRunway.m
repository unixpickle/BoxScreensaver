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
	Box * newBox = [self generateBoxOfClass:[Box class]];
	[newBox setStartDirection:startDirection];
	// toggle start direction
	startDirection = (startDirection == IncomingDirectionLeft ? IncomingDirectionRight : IncomingDirectionLeft);
	return newBox;
}

- (Box *)generateBoxOfClass:(Class)c {
	minY = 10;
	maxY = [self frame].size.height - 10;
	CGFloat nextY = maxY - [self frame].size.width;
	Box * newBox = [[c alloc] initWithFrame:CGRectMake(0, nextY, [self frame].size.width, [self frame].size.width)];
	NSAssert([newBox isKindOfClass:[Box class]], @"Invalid class was provided.");
	[newBox setRunway:self];
	return [newBox autorelease];
}

- (void)pushNewBox:(Box *)box duration:(CGFloat)duration {
	if (!boxStack) {
		boxStack = [[NSMutableArray alloc] init];
		NSAssert(minY != 0, @"At least one box must be generated before pushing a box.");
	}
	CGRect boxFrame = [box frame];
	if ([box startDirection] == IncomingDirectionLeft) {
		boxFrame.origin.x = ([[self superview] frame].size.width);
	} else {
		boxFrame.origin.x = -(boxFrame.size.width);
	}
	CGFloat moveUp = [box frame].size.height + 10;
	// move all of the boxes up, including our new box.
	for (int i = 0; i < [boxStack count]; i++) {
		Box * b = [boxStack objectAtIndex:i];
		// translate the frame to move up.
		CGRect br = [b frame];
		if (br.origin.y < 0 - br.size.height) {
			// remove views that go over the top.
			if ([b isDraggable]) [[NSNotificationCenter defaultCenter] postNotificationName:BoxLostPointNotification object:b];
			[boxStack removeObjectAtIndex:i];
			[b removeFromSuperview];
			i--;
		} else {
			br.origin.y -= moveUp;
			// create view animation
			CGPoint destination = CGPointMake(br.origin.x, br.origin.y);
			ViewPositionAnimation * animation = [[ViewPositionAnimation alloc] initWithView:b destinationLocation:destination];
			[animation start:0.75*duration];
			[animation release];
		}
	}
	[box setFrame:boxFrame];
	[[self superview] addSubview:box];
	CGPoint destinationBox = CGPointMake([self frame].origin.x, boxFrame.origin.y);
	ViewPositionAnimation * boxAnimation = [[ViewPositionAnimation alloc] initWithView:box destinationLocation:destinationBox];
	[boxAnimation start:duration*0.9];
	[boxAnimation release];
	[boxStack addObject:box];
}

- (Box *)topBox {
	if ([boxStack count] == 0) return nil;
	return [boxStack objectAtIndex:0]; // will always be first.
}

- (void)removeBox:(Box *)theBox {
	[ViewPositionAnimation cancelAnimationsForView:theBox];
	[boxStack removeObject:theBox];
}

- (void)removeFromSuperview {
	for (UIView * v in boxStack) {
		[ViewPositionAnimation cancelAnimationsForView:v];
		[v removeFromSuperview];
	}
	[boxStack release];
	boxStack = nil;
	[super removeFromSuperview];
}

- (void)dealloc {
	[boxStack release];
    [super dealloc];
}

@end
