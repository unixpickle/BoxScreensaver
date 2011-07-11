//
//  CountdownView.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownView : UIView {
    UILabel * timeLeft;
	id target;
	SEL action;
}

@property (nonatomic, assign) id target;
@property (readwrite) SEL action;

- (void)showInView:(UIView *)theView;
- (void)updateTime:(NSNumber *)timeLeft;
- (void)goAway;

@end
