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
@synthesize drinks, viewList;
@synthesize milkRow, strengthRow, sweetnessRow, iceRow;
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

	// Initialise the view list
	viewList = [[NSArray alloc] initWithObjects:milkRow, strengthRow, sweetnessRow, iceRow, nil];
	
	// Load the plist file	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalpath = [path stringByAppendingPathComponent:@"Drinks.plist"];
	drinks = [[NSDictionary alloc] initWithContentsOfFile:finalpath];
	
	// Make stuff round!
	[self makeRound:drinkCaption roundness:10.0];

	for (UIView *row in viewList) {
		for(UIView *v in [row subviews]) {
			if ([v isKindOfClass:[UIButton class]]) {
				[self makeRound:v roundness:11.0];
			}
		}		
	}
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)makeRound:(UIView *)v roundness:(CGFloat)roundness {
	v.layer.cornerRadius = roundness;
}


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


- (IBAction)addCaption:(id)sendeo {
	
	UIButton *sender = (UIButton *)sendeo;
	
	// Condensed while Kosong
	if([[sender currentTitle] isEqualToString:@"Condensed"] && [[[selections valueForKey:@"sweetness"] currentTitle] isEqualToString:@"None"]) {
		UIAlertView *kosongalert = [[UIAlertView alloc] initWithTitle:@"Whoops!" 
															  message:@"You have indicated that you'd like your coffee unsweetened. Choosing Condensed milk now will make it sweet. Please make another type of milk for your coffee." 
															 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[kosongalert show];
		[kosongalert release];
		
		return;								   
	}
	
	// Kosong while Condensed
	if([[sender currentTitle] isEqualToString:@"None"] && ([[sender superview] tag] == 3) && [[[selections valueForKey:@"milk"] currentTitle] isEqualToString:@"Condensed"]) {
		UIAlertView *kosongalert = [[UIAlertView alloc] initWithTitle:@"Whoops!" 
															  message:@"You have indicated that you'd like Condensed milk in your coffee, which makes it sweet. Please choose another level of sweetness, like Less." 
															 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[kosongalert show];
		[kosongalert release];
		
		return;								   
	}
	
	
	// Retrieve the row we're at.
	// Silly iPhone SDK uses int's for tags instead of strings =(
	//
	// From the innermost nested []'s
	// Obtain the tag of the bounding UIView of the incoming UIButton ([[sender superview] tag]), eg. milkRow, which has a single digit tag, eg. 1
	// Multiply the integer tag by 10, to give, say, 10, which is the integer tag of the label for that row
	// Retrieve the UILabel with tag 10x of the parent UIView, eg. [[self.view viewWithTag:[[sender superview] tag] * 10 ]
	// Get the text label of the UILabel and lowercase it. That's our key for the next section, eg. 'milk'
	NSString *key = [[[self.view viewWithTag:[[sender superview] tag] *10 ] text] lowercaseString];
	
	// Change the highlighting for the selected (and recently unselected) UIButton using transparency and fonts
	UIButton *prevSelection = [selections valueForKey:key];

	[prevSelection titleLabel].font = [UIFont boldSystemFontOfSize:15.0];
	prevSelection.backgroundColor = [prevSelection.backgroundColor colorWithAlphaComponent:0.60];
	
	[sender titleLabel].font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0]; // Normalise the current selection	
	sender.backgroundColor = [sender.backgroundColor colorWithAlphaComponent:1.0];
	
	[selections setValue:sender forKey:key];	
	//[selections setValue:sender forKey:[[sender currentTitle] lowercaseString]]; // Add the passed in sender (UIButton) to the selections Dictionary
	
	[self setCaption];
	
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
