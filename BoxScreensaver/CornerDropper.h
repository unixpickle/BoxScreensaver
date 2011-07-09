//
//  CornerDropper.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CornerDropper : UIView {
	UIImage * cornerImage;
	NSArray * acceptableClasses;
}

@property (nonatomic, retain) NSArray * acceptableClasses;
@property (nonatomic, retain) UIImage * cornerImage;

- (BOOL)acceptDrop:(NSObject *)theObject;

@end
