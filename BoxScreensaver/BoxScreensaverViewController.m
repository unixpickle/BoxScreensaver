//
//  BoxScreensaverViewController.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BoxScreensaverViewController.h"

@implementation BoxScreensaverViewController

- (void)dealloc {
	[menuBacking release];
	[newGameButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView {
	[super loadView];
	[[self view] setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:1]];
	menuBacking = [[MenuBackground alloc] initWithFrame:[[self view] bounds]];
	newGameButton = [[UIButton alloc] initWithFrame:CGRectMake(10, [[self view] frame].size.height / 2 - 38, 300, 75)];
	[newGameButton setBackgroundImage:[UIImage imageNamed:@"newgame_regular.png"] forState:UIControlStateNormal];
	[newGameButton setBackgroundImage:[UIImage imageNamed:@"newgame_press.png"] forState:UIControlStateHighlighted];
	[newGameButton addTarget:self action:@selector(showGame) forControlEvents:UIControlEventTouchUpInside];
	[[self view] addSubview:newGameButton];
	[[self view] addSubview:menuBacking];
	[[self view] sendSubviewToBack:menuBacking];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)showGame {
	[self presentModalViewController:[[[SortGameViewController alloc] initWithNibName:nil bundle:nil] autorelease] animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
