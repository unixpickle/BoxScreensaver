//
//  AdventureViewController.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdventureViewController.h"


@implementation AdventureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		NSString * stageListPath = [[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"plist"];
		NSAssert([[NSFileManager defaultManager] fileExistsAtPath:stageListPath], @"Stage list not found.");
		NSDictionary * dictionary = [[[NSDictionary alloc] initWithContentsOfFile:stageListPath] autorelease];
		NSArray * levels = [dictionary objectForKey:@"Levels"];
		NSAssert([levels count] > 0, @"Invalid number of levels in stage list file.");
		stageArray = [levels retain];
		stageIndex = -1;
		secondsLeft = kSecondsPerStage;
	}
    return self;
}

- (void)dealloc {
	[remainingTimeLabel release];
	[stageArray release];
    [super dealloc];
}

- (void)loadView {
	[super loadView];
	remainingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 110, 20)];
	[remainingTimeLabel setBackgroundColor:[UIColor clearColor]];
	[remainingTimeLabel setText:@"--00:00--"];
	[[self view] addSubview:remainingTimeLabel];
}

- (void)nextAdventureStage {
	stageIndex++;
	if (stageIndex == [stageArray count]) stageIndex = 0;
	NSDictionary * stageInfo = [stageArray objectAtIndex:stageIndex];
	NSString * stagePlist = [stageInfo objectForKey:@"Resource"];
	NSAssert1(stagePlist != nil, @"No resource entry found for stage index %d.", stageIndex);
	[self startGame:[[[GameLevel alloc] initWithResourcePlist:stagePlist] autorelease]];
}

- (void)decrementSeconds {
	secondsLeft -= 1;
	if (secondsLeft == 0) {
		secondsLeft = kSecondsPerStage;
		[self nextAdventureStage];
	}
	[remainingTimeLabel setText:[NSString stringWithFormat:@"T-%d", secondsLeft]];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
	if ([self gameScore].isGameOver == NO) {
		if (!countdownTimer) {
			countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementSeconds) userInfo:nil repeats:YES];
		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[countdownTimer invalidate];
	countdownTimer = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
