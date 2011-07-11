//
//  AfterActionReportViewController.m
//  BoxScreensaver
//
//  Created by Alex Nichol on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AfterActionReportViewController.h"

@interface AfterActionReportViewController (Private)

- (void)loadDoneButton;

@end

@implementation AfterActionReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
	[title release];
	[totalPoints release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)done:(id)sender {
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)setScore:(int)score {
	[totalPoints setText:[NSString stringWithFormat:@"Total points: %d", score]];
}

#pragma mark - View lifecycle

- (void)loadDoneButton {
	UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[doneButton setFrame:CGRectMake([[self view] frame].size.width - 90, [[self view] frame].size.height - 40, 80, 30)];
	[doneButton setTitle:@"Done" forState:UIControlStateNormal];
	[doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
	[[self view] addSubview:doneButton];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	[[self view] setBackgroundColor:[UIColor grayColor]];
	title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
	totalPoints = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 20)];
	[title setBackgroundColor:[UIColor clearColor]];
	[totalPoints setBackgroundColor:[UIColor clearColor]];
	[title setFont:[UIFont boldSystemFontOfSize:20]];
	[totalPoints setText:@"Total points: 0"];
	[title setText:@"After Action Report"];
	[[self view] addSubview:totalPoints];
	[[self view] addSubview:title];
	[self loadDoneButton];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
