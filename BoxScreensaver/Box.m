//
//  Box.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Box.h"
#import "BoxRunway.h"

@interface Box (Private)

/**
 * Moves our view to be a subview of our superview's superview.
 */
- (void)moveBackToParentsSuper;

@end

@implementation Box

@synthesize startDirection;
@synthesize runway;

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setBackgroundColor:[UIColor clearColor]];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(ctx, 1, 1, 0.2, 1);
	CGContextFillRect(ctx, [self bounds]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	dragState.startFrame = [self frame];
	dragState.startTouchPoint = [[touches anyObject] locationInView:[self superview]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	// We may be moving away from the runway!
	if (runway) {
		// back when you could only take from the top.
		// if ([runway topBox] != self) return;
		[runway removeBox:self];
		runway = nil;
		// This needed to be done when runway fruit was actually a subview
		// of the runway, which it no longer is.
		// [self moveBackToParentsSuper];
	}
	// return;
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
	if (runway) return;
	BOOL point = NO;
	for (UIView * view in [[self superview] subviews]) {
		if ([view isKindOfClass:[CornerDropper class]] && view != self) {
			if (CGRectIntersectsRect([self frame], [view frame])) {
				if ([(CornerDropper *)view acceptDrop:self]) {
					// we have a winner
					NSLog(@"Point!");
					point = YES;
				}
			}
		}
	}
	if (point) {
		[[NSNotificationCenter defaultCenter] postNotificationName:BoxMadePointNotification object:self];
	} else {
		[[NSNotificationCenter defaultCenter] postNotificationName:BoxLostPointNotification object:self];
	}
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[self setAlpha:0];
	[UIView commitAnimations];
	[self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.6];
}

- (void)moveBackToParentsSuper {
	UIView * superView = [self superview];
	UIView * superDuperView = [[self superview] superview];
	CGRect superFrame = [superView frame];
	CGRect ourNewFrame = CGRectMake([self frame].origin.x + superFrame.origin.x, [self frame].origin.y + superFrame.origin.y, [self frame].size.width, [self frame].size.height);
	// make a view transition.
	[self retain];
	[self removeFromSuperview];
	[self setFrame:ourNewFrame];
	[superDuperView addSubview:self];
	[self release];
	dragState.startFrame.origin.x += superFrame.origin.x;
	dragState.startFrame.origin.y += superFrame.origin.y;
	dragState.startTouchPoint.x += superFrame.origin.x;
	dragState.startTouchPoint.y += superFrame.origin.y;
}

- (void)dealloc {
    [super dealloc];
}

@end
