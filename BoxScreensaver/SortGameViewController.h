//
//  SortGameViewController.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxRunway.h"
#import "CornerDropper.h"
#include "GameScore.h"
#import "GameLevel.h"
#import "CountdownView.h"
#import "AfterActionReportViewController.h"

@interface SortGameViewController : UIViewController {
    BoxRunway * runway;
	GameLevel * level;
	CornerDropper * leftDrop;
	CornerDropper * rightDrop;
	struct GameScore gameScore;
	UILabel * pointsLabel;
	UILabel * lossesLabel;
	CGFloat duration;
	BOOL isGameGoing;
	UInt32 animationID; // the animation ID of the nextItem method to show.
}

- (void)startGame:(GameLevel *)aLevel;

/**
 * Pushes the next food to our runway.
 * @param theAnimationID A number representing the valid animation ID.
 * If this is not nil, and animationID (global ivar) is different than this
 * arguments int value, the nextItem method will return without doing anything.
 */
- (void)nextItem:(NSNumber *)theAnimationID;

/**
 * Called by a countdown view to indicate that the countdown is done
 * and we should show the next item.
 */
- (void)countdownDone;

@end
