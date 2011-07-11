//
//  AdventureViewController.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortGameViewController.h"

#define kSecondsPerStage 35

@interface AdventureViewController : SortGameViewController {
    NSArray * stageArray;
	int stageIndex;
	
	int secondsLeft; // starts at kSecondsPerStage
	NSTimer * countdownTimer;
	UILabel * remainingTimeLabel;
}

- (void)nextAdventureStage;
- (void)decrementSeconds;

@end
