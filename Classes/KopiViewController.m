//
//  KopiViewController.m
//  Kopi
//
//  Created by Ruiwen Chua on 3/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "KopiViewController.h"

@implementation KopiViewController

@synthesize drinkCaption;
@synthesize drinks;
@synthesize selections, milkSelection, strengthSelection, sweetnessSelection, iceSelection;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		//drinkCaption.layer.cornerRadius = 50.0;
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
 	[super viewDidLoad];
	
	// Initialise the selections array
	selections = [[NSMutableDictionary alloc] initWithObjectsAndKeys:milkSelection, @"milk", strengthSelection, @"strength", sweetnessSelection, @"sweetness", iceSelection, @"ice", nil];
	
	// Load the plist file	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalpath = [path stringByAppendingPathComponent:@"Drinks.plist"];
	drinks = [[NSDictionary alloc] initWithContentsOfFile:finalpath];
	
	drinkCaption.layer.cornerRadius = 10.0;
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)setCaption {
	NSMutableString *caption = [[NSMutableString alloc] initWithString:@"kopi"];
	NSArray *order = [NSArray arrayWithObjects:@"milk", @"strength", @"sweetness", @"ice", nil];
	for (NSString *key in order) {
		[caption appendFormat:@" %@", [[drinks valueForKey:key] valueForKey:[[[selections valueForKey:key] currentTitle] lowercaseString]]];
	}
	
	drinkCaption.text = [caption uppercaseString];

	// order not release'd as it's been initialised as an auto-release object
	[caption release];
}

- (void)addToCaption:(NSString *)key sender:(id)sender {
	
	[[selections valueForKey:key] titleLabel].font = [UIFont boldSystemFontOfSize:15.0];
	[sender titleLabel].font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0]; // Normalise the current selection	
	[selections setValue:sender forKey:key];
	
	[selections setValue:sender forKey:[[sender currentTitle] lowercaseString]]; // Add the passed in sender (UIButton) to the selections Dictionary
	
	[self setCaption];
}

- (IBAction)setMilk:(id)sender{
	if([[sender currentTitle] isEqualToString:@"Condensed"] && [[[selections valueForKey:@"sweetness"] currentTitle] isEqualToString:@"None"]) {
		UIAlertView *kosongalert = [[UIAlertView alloc] initWithTitle:@"Whoops!" 
															  message:@"You've already chosen a coffee with no sweetness. Choosing Condensed milk will make it sweet. May we recommend Evaporated milk instead?" 
															 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[kosongalert show];
		[kosongalert release];
		
		return;								   
	}
	else {
		[self addToCaption:@"milk" sender:sender];
	}
}
									   
- (IBAction)setStrength:(id)sender{
	[self addToCaption:@"strength" sender:sender];
}


- (IBAction)setSweetness:(id)sender{
	if([[sender currentTitle] isEqualToString:@"None"] && [[[selections valueForKey:@"milk"] currentTitle] isEqualToString:@"Condensed"]) {
		UIAlertView *kosongalert = [[UIAlertView alloc] initWithTitle:@"Whoops!" 
															  message:@"You have chosen Condensed milk and it's already sweet! You can opt for Less sweetness with Condensed milk though!" 
															 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[kosongalert show];
		[kosongalert release];
		
		return;								   
	}
	else {
		[self addToCaption:@"sweetness" sender:sender];	
	}
}
									   
- (IBAction)setIced:(id)sender{
	[self addToCaption:@"ice" sender:sender];
}
									   
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {

	[milkSelection release];
	[strengthSelection release];
	[sweetnessSelection release];
	[iceSelection release];
	[selections release];
	[drinks release];
	[drinkCaption release];
    [super dealloc];
}

@end
