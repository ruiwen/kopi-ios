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
	NSLog(@"%@", [caption uppercaseString]);
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
	NSLog(@"Milk");
	[self addToCaption:@"milk" sender:sender];
}
									   
- (IBAction)setStrength:(id)sender{
	NSLog(@"Strength");
	[self addToCaption:@"strength" sender:sender];
}


- (IBAction)setSweetness:(id)sender{
	NSLog(@"Sweetness");
	[self addToCaption:@"sweetness" sender:sender];
}
									   
- (IBAction)setIced:(id)sender{
	NSLog(@"Iced");	
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
