//
//  CountdownView.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CountdownView.h"


@implementation CountdownView

@synthesize target;
@synthesize action;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		timeLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:timeLeft];
		[timeLeft setFont:[UIFont boldSystemFontOfSize:50]];
		[timeLeft setTextAlignment:UITextAlignmentCenter];
		[timeLeft setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
		[timeLeft setTextColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	[timeLeft setFrame:[self bounds]];
}

- (void)showInView:(UIView *)theView {
	[self setFrame:[theView bounds]];
	[theView addSubview:self];
	[self setAlpha:0];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[self setAlpha:1];
	[UIView commitAnimations];
	[timeLeft setText:@"3"];
	[self performSelector:@selector(updateTime:) withObject:[NSNumber numberWithInt:2] afterDelay:1];
}

- (void)updateTime:(NSNumber *)timeLeftN {
	[timeLeft setText:[NSString stringWithFormat:@"%d", [timeLeftN intValue]]];
	if ([timeLeftN intValue] > 1) {
		[self performSelector:@selector(updateTime:) withObject:[NSNumber numberWithInt:[timeLeftN intValue] - 1] afterDelay:1];
	} else [self performSelector:@selector(goAway) withObject:nil afterDelay:1];
}

- (void)goAway {
	[target performSelector:action withObject:self afterDelay:0.6];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.4];
	[self setAlpha:0];
	[UIView commitAnimations];
	[self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[timeLeft release];
    [super dealloc];
}

@end
