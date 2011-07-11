//
//  SortGameViewController.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SortGameViewController.h"

@interface SortGameViewController (Private)

/* Methods called by notifications */
- (void)pointScoredNotification;
- (void)lifeLostNotification;

- (void)closeView;
- (NSTimeInterval)nextItemTimer;

@end

@implementation SortGameViewController

@synthesize gameScore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
	[runway release];
	[leftDrop release];
	[rightDrop release];
	[level release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	[[self view] setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
	gameScore.isGameOver = NO;
	runway = [[BoxRunway alloc] initWithFrame:CGRectMake([[self view] frame].size.width / 2 - 25, 0, 50, [[self view] frame].size.height)];
	pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 130, 20)];
	lossesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 130, 20)];

	[lossesLabel setText:@"Mistakes: 0"];
	[pointsLabel setText:@"Points: 0"];
	
	[runway setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
	[pointsLabel setBackgroundColor:[UIColor clearColor]];
	[lossesLabel setBackgroundColor:[UIColor clearColor]];

	[[self view] addSubview:runway];
	[[self view] addSubview:lossesLabel];
	[[self view] addSubview:pointsLabel];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointScoredNotification) name:BoxMadePointNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lifeLostNotification) name:BoxLostPointNotification object:nil];
	gameScore.points = 0;
	gameScore.losses = 0;
}

- (void)startGame:(GameLevel *)aLevel {
	NSAssert(aLevel != nil, @"Cannot start a nil game.");
	duration = 1.5;
	[runway removeAllBoxes];
	[level release];
	level = [aLevel retain];
	if (leftDrop || rightDrop) {
		[leftDrop removeFromSuperview];
		[rightDrop removeFromSuperview];
		[leftDrop release];
		[rightDrop release];
	}
	for (int i = 0; i < [[[self view] subviews] count]; i++) {
		UIView * v = [[[self view] subviews] objectAtIndex:i];
		if ([v isKindOfClass:[Box class]]) {
			[v removeFromSuperview];
			i--;
		}
	}
	leftDrop = [[CornerDropper alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
	rightDrop = [[CornerDropper alloc] initWithFrame:CGRectMake([[self view] frame].size.width - 130, 0, 130, 130)];
	[leftDrop setAcceptableClasses:[NSArray arrayWithObject:NSStringFromClass([level classLeft])]];
	[rightDrop setAcceptableClasses:[NSArray arrayWithObject:NSStringFromClass([level classRight])]];
	[leftDrop setCornerImage:[level cornerLeft]];
	[rightDrop setCornerImage:[level cornerRight]];
	[rightDrop setBackgroundColor:[UIColor clearColor]];
	[leftDrop setBackgroundColor:[UIColor clearColor]];
	[[self view] addSubview:rightDrop];
	[[self view] addSubview:leftDrop];
	[itemTimer invalidate];
	itemTimer = nil;
	CountdownView * cv = [[CountdownView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
	[cv setTarget:self];
	[cv setAction:@selector(countdownDone)];
	[cv showInView:[self view]];
	[cv release];
}

- (void)nextItem {
	duration *= 0.98;
	if (duration < 0.8) duration = 0.8;
	if (arc4random() % 2 == 1) {
		Box * box = [runway generateBoxOfClass:[level classLeft]];
		[runway pushNewBox:box duration:duration];
		if ([box respondsToSelector:@selector(setBoxImage:)]) {
			[box performSelector:@selector(setBoxImage:) withObject:[level imageLeft]];
		}
	} else {
		Box * box = [runway generateBoxOfClass:[level classRight]];
		[runway pushNewBox:box duration:duration];
		if ([box respondsToSelector:@selector(setBoxImage:)]) {
			[box performSelector:@selector(setBoxImage:) withObject:[level imageRight]];
		}
	}
}

- (NSTimeInterval)changingTimerTick:(id)sender {
	[self nextItem];
	return duration;
}

- (void)countdownDone {
	if (itemTimer) {
		[itemTimer invalidate];
	}
	itemTimer = [ChangingTimer scheduledTimerWithInterval:duration delegate:self];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)closeView {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
	[super dismissModalViewControllerAnimated:animated];
	[self performSelector:@selector(closeView) withObject:nil afterDelay:0.5];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Notifications

- (void)pointScoredNotification {
	gameScore.points += 1;
	[pointsLabel setText:[NSString stringWithFormat:@"Points: %d", gameScore.points]];
}

- (void)lifeLostNotification {
	gameScore.losses += 1;
	[lossesLabel setText:[NSString stringWithFormat:@"Mistakes: %d", gameScore.losses]];
	if (gameScore.losses == [level maxDeaths]) {
		[itemTimer invalidate];
		itemTimer = nil;
		gameScore.isGameOver = YES;
		AfterActionReportViewController * aarvc = [[AfterActionReportViewController alloc] initWithNibName:nil bundle:nil];
		[self presentModalViewController:aarvc animated:YES];
		[aarvc setScore:gameScore.points];
		[aarvc release];
	}
}

@end
