//
//  Box.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	IncomingDirectionLeft, // starts on far right
	IncomingDirectionRight // starts on far left
} IncomingDirection;

@interface Box : UIView {
    IncomingDirection startDirection;
}

@property (readwrite) IncomingDirection startDirection;

@end
