//
//  ChangingTimer.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChangingTimer.h"

@interface ChangingTimer (Private)

- (id)initWithDelegate:(id<ChangingTimerDelegate>)delegateObj;
- (void)callDelegate;

@end

@implementation ChangingTimer

+ (ChangingTimer *)scheduledTimerWithInterval:(NSTimeInterval)interval delegate:(NSObject<ChangingTimerDelegate> *)callback {
	ChangingTimer * timer = [[ChangingTimer alloc] initWithDelegate:callback];
	// this will retain the timer until after callDelegate is finished running.
	[timer callDelegate];
	return [timer autorelease];
}

- (id)initWithDelegate:(NSObject<ChangingTimerDelegate> *)delegateObj {
	if ((self = [super init])) {
		isRunning = YES;
		delegate = [delegateObj retain];
	}
	return self;
}

- (void)invalidate {
	isRunning = NO;
}

/**
 * Calls the delegate, and repeats with the new time.
 */
- (void)callDelegate {
	if (!isRunning || !delegate) return;
	NSTimeInterval ti = [delegate changingTimerTick:self];
	if (ti <= 0) return;
	// this will retain us recursively, until we get cancelled.
	[self performSelector:@selector(callDelegate) withObject:nil afterDelay:ti];
}

- (void)dealloc {
	[delegate release];
	[super dealloc];
}

@end
