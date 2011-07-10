//
//  BoxScreensaverViewController.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortGameViewController.h"
#import "MenuBackground.h"

@interface BoxScreensaverViewController : UIViewController {
	MenuBackground * menuBacking;
	UIButton * newGameButton;
}

/** 
 * Presents the user with a vegetable/apple sorting game.
 */
- (void)showGame;

@end
