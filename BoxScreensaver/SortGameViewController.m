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

@end

@implementation SortGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
	[runway release];
	[fruits release];
	[vegetables release];
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
	duration = 1.5;
	isGameGoing = YES;
	[[self view] setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
	runway = [[BoxRunway alloc] initWithFrame:CGRectMake([[self view] frame].size.width / 2 - 25, 0, 50, [[self view] frame].size.height)];
	vegetables = [[CornerDropper alloc] initWithFrame:CGRectMake(0, 0, 130, 130)];
	fruits = [[CornerDropper alloc] initWithFrame:CGRectMake([[self view] frame].size.width - 130, 0, 130, 130)];
	pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 130, 20)];
	lossesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 130, 20)];

	[lossesLabel setText:@"Mistakes: 0"];
	[pointsLabel setText:@"Points: 0"];
	
	[vegetables setAcceptableClasses:[NSArray arrayWithObject:@"VegetableBox"]];
	[fruits setAcceptableClasses:[NSArray arrayWithObject:@"FruitBox"]];
	[vegetables setCornerImage:[UIImage imageNamed:@"drop broccoli.png"]];
	[fruits setCornerImage:[UIImage imageNamed:@"drop apple.png"]];
	[runway setBackgroundColor:[UIColor grayColor]];
	[pointsLabel setBackgroundColor:[UIColor clearColor]];
	[lossesLabel setBackgroundColor:[UIColor clearColor]];
	[fruits setBackgroundColor:[UIColor clearColor]];
	[vegetables setBackgroundColor:[UIColor clearColor]];

	[[self view] addSubview:runway];
	[[self view] addSubview:fruits];
	[[self view] addSubview:vegetables];
	[[self view] addSubview:lossesLabel];
	[[self view] addSubview:pointsLabel];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointScoredNotification) name:BoxMadePointNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lifeLostNotification) name:BoxLostPointNotification object:nil];
	gameScore.points = 0;
	gameScore.losses = 0;
	[self nextItem];
}

- (void)nextItem {
	if (!isGameGoing) return;
	duration *= 0.985;
	if (duration < 0.8) duration = 0.8;
	if (arc4random() % 2 == 1) {
		[runway pushNewBox:[runway generateBoxOfClass:[VegetableBox class]] duration:duration];
	} else {
		[runway pushNewBox:[runway generateBoxOfClass:[FruitBox class]] duration:duration];
	}
	[self performSelector:@selector(nextItem) withObject:nil afterDelay:duration];
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

#pragma mark Notifications

- (void)pointScoredNotification {
	gameScore.points += 1;
	[pointsLabel setText:[NSString stringWithFormat:@"Points: %d", gameScore.points]];
}

- (void)lifeLostNotification {
	gameScore.losses += 1;
	[lossesLabel setText:[NSString stringWithFormat:@"Mistakes: %d", gameScore.losses]];
	if (gameScore.losses == 3) {
		isGameGoing = NO;
		[[self parentViewController] dismissModalViewControllerAnimated:YES];
	}
}

@end
