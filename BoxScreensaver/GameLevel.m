//
//  GameLevel.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameLevel.h"


@implementation GameLevel

@synthesize title;
@synthesize classLeft;
@synthesize classRight;
@synthesize cornerLeft;
@synthesize cornerRight;
@synthesize maxDeaths;
@synthesize imageLeft;
@synthesize imageRight;

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if ((self = [super init])) {
		title = [[dictionary objectForKey:@"Name"] retain];
		classLeft = NSClassFromString([dictionary objectForKey:@"ClassLeft"]);
		classRight = NSClassFromString([dictionary objectForKey:@"ClassRight"]);
		cornerLeft = [[UIImage imageNamed:[dictionary objectForKey:@"CornerLeftImage"]] retain];
		cornerRight = [[UIImage imageNamed:[dictionary objectForKey:@"CornerRightImage"]] retain];
		maxDeaths = [[dictionary objectForKey:@"Max Deaths"] unsignedShortValue];
		imageLeft = [[UIImage imageNamed:[dictionary objectForKey:@"LeftImage"]] retain];
		imageRight = [[UIImage imageNamed:[dictionary objectForKey:@"RightImage"]] retain];
		if (maxDeaths == 0 || title == nil || classLeft == Nil || classRight == Nil || cornerLeft == nil || cornerRight == nil) {
			[self autorelease];
			return nil;
		}
	}
	return self;
}

- (id)initWithResourcePlist:(NSString *)resourceName {
	if ((self = [super init])) {
		NSString * resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:resourceName];
		if (![[NSFileManager defaultManager] fileExistsAtPath:resourcePath]) {
			[self autorelease];
			return nil;
		}
		NSDictionary * dictionary = [[NSDictionary alloc] initWithContentsOfFile:resourcePath];
		if (!dictionary) {
			[self autorelease];
			return nil;
		}
		title = [[dictionary objectForKey:@"Name"] retain];
		classLeft = NSClassFromString([dictionary objectForKey:@"ClassLeft"]);
		classRight = NSClassFromString([dictionary objectForKey:@"ClassRight"]);
		cornerLeft = [UIImage imageNamed:[dictionary objectForKey:@"CornerLeftImage"]];
		cornerRight = [UIImage imageNamed:[dictionary objectForKey:@"CornerRightImage"]];
		maxDeaths = [[dictionary objectForKey:@"Max Deaths"] intValue];
		imageLeft = [[UIImage imageNamed:[dictionary objectForKey:@"LeftImage"]] retain];
		imageRight = [[UIImage imageNamed:[dictionary objectForKey:@"RightImage"]] retain];
		[dictionary release];
		if (maxDeaths == 0 || title == nil || classLeft == Nil || classRight == Nil || cornerLeft == nil || cornerRight == nil) {
			[self autorelease];
			return nil;
		}
	}
	return self;
}

- (void)dealloc {
	[title release];
	[cornerLeft release];
	[cornerRight release];
	[imageLeft release];
	[imageRight release];
	[super dealloc];
}

@end
