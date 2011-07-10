//
//  MenuBackground.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuBackground.h"

@interface MenuBackground (Private)

- (UIColor *)randomColor;

@end

@implementation MenuBackground

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		runway1 = [[BoxRunway alloc] initWithFrame:CGRectMake(60, 0, 60, [self frame].size.height)];
		runway2 = [[BoxRunway alloc] initWithFrame:CGRectMake([self frame].size.width - 120, 0, 60, [self frame].size.height)];
		[self addSubview:runway1];
		[self addSubview:runway2];
		[self pushColoredItem];
    }
    return self;
}

- (void)pushColoredItem {
	UIColor * theColor = [self randomColor];
	Box * boxLeft = [runway1 generateBox];
	Box * boxRight = [runway2 generateBox];
	[boxLeft setBackgroundColor:theColor];
	[boxRight setBackgroundColor:theColor];
	[boxLeft setDraggable:NO];
	[boxRight setDraggable:NO];
	[boxLeft setStartDirection:IncomingDirectionRight];
	[boxRight setStartDirection:IncomingDirectionLeft];
	[runway1 pushNewBox:boxLeft duration:0.75];
	[runway2 pushNewBox:boxRight duration:0.75];
	[self performSelector:@selector(pushColoredItem) withObject:nil afterDelay:0.8];
}

- (UIColor *)randomColor {
	return [UIColor colorWithWhite:((CGFloat)(arc4random() % 513) / 512.0) alpha:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
	[runway1 release];
	[runway2 release];
    [super dealloc];
}

@end
