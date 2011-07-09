//
//  SortGameViewController.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxRunway.h"
#import "FruitBox.h"
#import "VegetableBox.h"
#import "CornerDropper.h"
#include "GameScore.h"

@interface SortGameViewController : UIViewController {
    BoxRunway * runway;
	CornerDropper * vegetables;
	CornerDropper * fruits;
	struct GameScore gameScore;
	UILabel * pointsLabel;
	UILabel * lossesLabel;
	CGFloat duration;
	BOOL isGameGoing;
}

/**
 * Pushes the next food to our runway.
 */
- (void)nextItem;

@end
