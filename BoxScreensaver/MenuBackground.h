//
//  MenuBackground.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxRunway.h"

@interface MenuBackground : UIView {
    BoxRunway * runway1;
	BoxRunway * runway2;
}

- (void)pushColoredItem;

@end
