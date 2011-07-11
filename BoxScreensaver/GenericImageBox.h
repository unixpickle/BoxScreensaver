//
//  GenericLeftBox.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box.h"

@interface GenericImageBox : Box {
    UIImage * boxImage;
}

@property (nonatomic, retain) UIImage * boxImage;

@end
