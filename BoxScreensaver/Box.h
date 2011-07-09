//
//  Box.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#include "BoxDragstate.h"

@class BoxRunway;

typedef enum {
	IncomingDirectionLeft, // starts on far right
	IncomingDirectionRight // starts on far left
} IncomingDirection;

@interface Box : UIView {
    IncomingDirection startDirection;
	BoxRunway * runway;
	struct Dragstate dragState;
}

@property (readwrite) IncomingDirection startDirection;
@property (nonatomic, assign) BoxRunway * runway;

@end
