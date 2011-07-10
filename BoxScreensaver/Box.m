//
//  Box.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Box.h"
#import "BoxRunway.h"

@implementation Box

@synthesize startDirection;
@synthesize runway;
@synthesize isDraggable;

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		isDraggable = YES;
		[self setBackgroundColor:[UIColor clearColor]];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (![self isDraggable]) return;
	dragState.startFrame = [self frame];
	dragState.startTouchPoint = [[touches anyObject] locationInView:[self superview]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (![self isDraggable]) return;
	if (runway) {
		[runway removeBox:self];
		runway = nil;
	}
	// Use the offset of the current point to the original point to calculate
	// to new position of ourselves.
	CGPoint touchPoint = [[touches anyObject] locationInView:[self superview]];
	CGPoint offset = CGPointMake(touchPoint.x - dragState.startTouchPoint.x, touchPoint.y - dragState.startTouchPoint.y);
	CGRect newFrame = dragState.startFrame;
	newFrame.origin.x += round(offset.x);
	newFrame.origin.y += round(offset.y);
	[self setFrame:newFrame];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (![self isDraggable]) return;
	if (runway) return;
	BOOL point = NO;
	
	// If we are inside the correct corner, they have a point.
	// Otherwise they lost a point.
	for (UIView * view in [[self superview] subviews]) {
		if ([view isKindOfClass:[CornerDropper class]] && view != self && CGRectIntersectsRect([self frame], [view frame])) {
			if ([(CornerDropper *)view acceptDrop:self]) {
				point = YES;
			}
		}
	}
	
	if (isDraggable) {
		// if it is not draggable, it doesn't count that they did anything with it.
		if (point) [[NSNotificationCenter defaultCenter] postNotificationName:BoxMadePointNotification object:self];
		else [[NSNotificationCenter defaultCenter] postNotificationName:BoxLostPointNotification object:self];
	}
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[self setAlpha:0];
	[UIView commitAnimations];
	[self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.6];
}

- (void)dealloc {
    [super dealloc];
}

@end
