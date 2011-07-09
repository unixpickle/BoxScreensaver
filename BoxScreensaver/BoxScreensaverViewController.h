//
//  BoxScreensaverViewController.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxRunway.h"
#import "FruitBox.h"
#import "VegetableBox.h"

@interface BoxScreensaverViewController : UIViewController {
    BoxRunway * runway;
}

- (void)addNewBox;

@end
