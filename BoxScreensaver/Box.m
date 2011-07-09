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
	if (runway) return;
	BOOL point = NO;
	for (UIView * view in [[self superview] subviews]) {
		if ([view isKindOfClass:[CornerDropper class]] && view != self) {
			if (CGRectIntersectsRect([self frame], [view frame])) {
				if ([(CornerDropper *)view acceptDrop:self]) {
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

- (void)dealloc {
    [super dealloc];
}

@end
