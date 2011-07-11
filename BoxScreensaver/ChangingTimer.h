//
//  ChangingTimer.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChangingTimer;

@protocol ChangingTimerDelegate

- (NSTimeInterval)changingTimerTick:(ChangingTimer *)timer;

@end

@interface ChangingTimer : NSObject {
	BOOL isRunning;
	NSObject<ChangingTimerDelegate> * delegate;
}

/**
 * Returns a new timer that will begin calling the delegate with the specified interval.
 * This timer will be valid and retained until -invalidate is called.
 */
+ (ChangingTimer *)scheduledTimerWithInterval:(NSTimeInterval)interval delegate:(NSObject<ChangingTimerDelegate> *)callback;

/**
 * Cancels and releases the timer.
 */
- (void)invalidate;

@end
