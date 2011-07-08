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
	[runway release];
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
	runway = [[BoxRunway alloc] initWithFrame:CGRectMake([[self view] frame].size.width / 2 - 25, 0, 50, [[self view] frame].size.height)];
	[[self view] addSubview:runway];
	[self addNewBox];
}

- (void)addNewBox {
	[runway pushNewBox:[runway generateBox]];
	[self performSelector:@selector(addNewBox) withObject:nil afterDelay:1.0];
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
