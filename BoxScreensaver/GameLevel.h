//
//  GameLevel.h
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameLevel : NSObject {
    NSString * title;
	Class classLeft;
	Class classRight;
	UIImage * cornerLeft;
	UIImage * cornerRight;
	UInt16 maxDeaths;
	UIImage * imageLeft;
	UIImage * imageRight;
}

@property (readonly) NSString * title;
@property (readonly) Class classLeft;
@property (readonly) Class classRight;
@property (readonly) UIImage * cornerLeft;
@property (readonly) UIImage * cornerRight;
@property (readonly) UInt16 maxDeaths;
@property (readonly) UIImage * imageLeft;
@property (readonly) UIImage * imageRight;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithResourcePlist:(NSString *)resourceName;

@end
