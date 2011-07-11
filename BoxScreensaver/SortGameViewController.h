//
//  SortGameViewController.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "GameScore.h"
#import "AfterActionReportViewController.h"
#import "BoxRunway.h"
#import "CornerDropper.h"
#import "GameLevel.h"
#import "CountdownView.h"
#import "ChangingTimer.h"

@interface SortGameViewController : UIViewController <ChangingTimerDelegate> {
    BoxRunway * runway;
	GameLevel * level;
	CornerDropper * leftDrop;
	CornerDropper * rightDrop;
	struct GameScore gameScore;
	UILabel * pointsLabel;
	UILabel * lossesLabel;
	CGFloat duration;
	ChangingTimer * itemTimer;
}

@property (readonly) struct GameScore gameScore;

- (void)startGame:(GameLevel *)aLevel;

/**
 * Pushes the next food to our runway.
 * @param theAnimationID A number representing the valid animation ID.
 * If this is not nil, and animationID (global ivar) is different than this
 * arguments int value, the nextItem method will return without doing anything.
 */
- (void)nextItem;

/**
 * Called by a countdown view to indicate that the countdown is done
 * and we should show the next item.
 */
- (void)countdownDone;

@end
