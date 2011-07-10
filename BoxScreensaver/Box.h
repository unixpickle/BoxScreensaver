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
#import "CornerDropper.h"

#define BoxMadePointNotification @"BoxMadePointNotification"
#define BoxLostPointNotification @"BoxLostPointNotification"

@class BoxRunway;

typedef enum {
	IncomingDirectionLeft, // starts on far right
	IncomingDirectionRight // starts on far left
} IncomingDirection;

@interface Box : UIView {
    IncomingDirection startDirection;
	BoxRunway * runway;
	struct Dragstate dragState;
	BOOL isDraggable;
}

@property (readwrite) IncomingDirection startDirection;
@property (nonatomic, assign) BoxRunway * runway;
@property (readwrite, setter=setDraggable:) BOOL isDraggable;

@end
