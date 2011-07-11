//
//  AfterActionReportViewController.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AfterActionReportViewController : UIViewController {
    UILabel * totalPoints;
	UILabel * title;
}

- (void)done:(id)sender;
- (void)setScore:(int)score;

@end
