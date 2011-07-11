//
//  GenericLeftBox.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GenericImageBox.h"


@implementation GenericImageBox

- (UIImage *)boxImage {
	return [[boxImage retain] autorelease];
}

- (void)setBoxImage:(UIImage *)theImage {
	[boxImage autorelease];
	boxImage = [theImage retain];
}

- (void)drawRect:(CGRect)rect {
	[boxImage drawInRect:[self bounds]];
}

@end
