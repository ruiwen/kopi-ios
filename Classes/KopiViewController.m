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
@synthesize e, drinks, viewList;
@synthesize milkRow, strengthRow, sweetnessRow, iceRow;
@synthesize selections, milkSelection, strengthSelection, sweetnessSelection, iceSelection;
@synthesize playButton, stopButton, resetButton, shouldContinue;

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
	
	// Initialise the order array
	order = [[NSArray alloc] initWithObjects:@"milk", @"strength", @"sweetness", @"ice", nil];
	
	// Load the plist file	
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *finalpath = [path stringByAppendingPathComponent:@"Drinks.plist"];
	drinks = [[NSDictionary alloc] initWithContentsOfFile:finalpath];
	
	// Make stuff round!
	[self makeRound:drinkCaption roundness:10.0];

	[self makeRound:playButton roundness:11.0];
	[self makeRound:stopButton roundness:11.0];
	[self makeRound:resetButton roundness:11.0];
	
	for (UIView *row in viewList) {
		for(UIView *v in [row subviews]) {
			if ([v isKindOfClass:[UIButton class]]) {
				[self makeRound:v roundness:11.0];
			}
		}		
	}
	
	
	// Make sure the stop flag is off on startup
	shouldContinue = YES;
	
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

	/*
	[prevSelection titleLabel].font = [UIFont boldSystemFontOfSize:15.0];
	prevSelection.backgroundColor = [prevSelection.backgroundColor colorWithAlphaComponent:0.60];
	
	[sender titleLabel].font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0]; // Normalise the current selection	
	sender.backgroundColor = [sender.backgroundColor colorWithAlphaComponent:1.0];
	*/
	
	[self toggleButton:prevSelection on:NO];
	[self toggleButton:sender on:YES];
	
	[selections setValue:sender forKey:key];	
	//[selections setValue:sender forKey:[[sender currentTitle] lowercaseString]]; // Add the passed in sender (UIButton) to the selections Dictionary
	
	[self setCaption];
	
}


- (void)toggleButton:(UIButton *)v on:(BOOL)on {
	
	if(on) {
		[v titleLabel].font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15.0];
		v.backgroundColor = [v.backgroundColor colorWithAlphaComponent:1.0];
	}
	else {
		[v titleLabel].font = [UIFont boldSystemFontOfSize:15.0];
		v.backgroundColor = [v.backgroundColor colorWithAlphaComponent:0.60];	
	}	
}


- (IBAction)playCaption {
	// Tutorial and code on: http://howtomakeiphoneapps.com/2009/08/how-to-play-a-short-sound-in-iphone-code/
	NSLog(@"Playing!");
	
	// Flip the Play/Stop buttons' visibility
	[self flipPlayStop:YES];
	
	NSMutableArray *sounds = [NSMutableArray arrayWithCapacity:5];
	[sounds insertObject:@"kopi" atIndex:0];
	
	// Get the list of files to play
	for (NSString *key in order) {
		NSString *say = [[drinks valueForKey:key] valueForKey:[[[selections valueForKey:key] currentTitle] lowercaseString]];
		if(![say isEqual:@""]) {
			say = [say stringByReplacingOccurrencesOfString:@" " withString:@""]; // Chop out the spaces in the string, eg. "siew dai" -> "siewdai"
			[sounds addObject:say];
		}
	}
	
	NSLog(@"%@", sounds);
	e = [sounds objectEnumerator];
	[e retain];
	//NSLog(@"%@", [e allObjects]); 	
	
	[self playCaptionSounds];
	
	
	/*
	//NSError *error = [[NSError alloc] init];
	NSString *path = [[NSBundle mainBundle] pathForResource:[e nextObject] ofType:@"wav"];
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO]; NSLog(@"%@", filePath);
	AVAudioPlayer *avp = [[AVAudioPlayer alloc] initWithContentsOfURL:filePath error:NULL];
	avp.delegate = self;
	
	[avp play];
	*/

}

- (void)playCaptionSounds {
	NSLog(@"playCaptionSounds");
	NSString *next = [e nextObject];
	NSLog(@"%@", next);
	if(next != nil && shouldContinue) {
		NSString *path = [[NSBundle mainBundle] pathForResource:next ofType:@"wav"]; NSLog(@"%@", path); // Build the path string
		NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO]; // Make it an actual file path in the system
		AVAudioPlayer *avp = [[AVAudioPlayer alloc] initWithContentsOfURL:filePath error:NULL]; // Init the player with the file path
		avp.delegate = self;
		[avp play];
	}
	else {
		NSLog(@"End of caption");
		shouldContinue = YES;
		
		// Flip the Stop/Play buttons back
		[self flipPlayStop:NO];
	}
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	//NSError *error = [[NSError alloc] init];
	NSLog(@"Done playing!");
	NSLog(@"%@", self);
	[self playCaptionSounds];
}


- (void)flipPlayStop:(BOOL)isPlaying {

	if(isPlaying) {
		// Flip the UI to show the Stop button instead
		playButton.hidden = YES;
		stopButton.hidden = NO;
	}
	else {
		// Flip the UI to show the Stop button instead
		playButton.hidden = NO;
		stopButton.hidden = YES;
	}
}


- (IBAction)stopPlaying {
	NSLog(@"Stopping!");
	shouldContinue = NO;
}


- (IBAction)resetSelection {
	// Cheap hack, but probably more efficient than looping through the default list in Drinks.plist
	NSLog(@"Reset!");
	// Our default selected tags are 12, 22, 33, 42	
	NSArray *defaultSelection = [NSArray arrayWithObjects:
								 [NSNumber numberWithInt:12],
								 [NSNumber numberWithInt:22], 
								 [NSNumber numberWithInt:33], 
								 [NSNumber numberWithInt:42], nil];
	NSEnumerator *d = [defaultSelection objectEnumerator];	
	NSLog(@"%@", d);
	
	for(NSString *key in order){
		UIButton *oldSelection = [selections objectForKey:key];
		
		[self toggleButton:oldSelection on:NO];

		UIButton *newSelection = [self.view viewWithTag:[[d nextObject] intValue]];
		NSLog(@"%@", newSelection);
		[self toggleButton:newSelection on:YES];
		
		[selections setObject:newSelection forKey:key];
	}
	
	[self setCaption];
}

/*
static void testCallback(SystemSoundID sID, void* e) {
	NSLog(@"Test callback: %d, %@", sID, e);
}

static void playCaptionSound(SystemSoundID soundID, NSEnumerator *e) {
	NSLog(@"In the callback!: %d, %@", soundID, e);

	NSString *sound = [e nextObject]; // Get the leading soundclip name off e
	NSLog(@"Sound: %@", sound);
	//Get the filename of the sound file:
	NSString *path = [[NSBundle mainBundle] pathForResource:sound ofType:@"wav"];

	NSLog(@"%@", path);
	
	
	//Get a URL for the sound file
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
		
	//Use audio sevices to create the sound
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	
	// Point the callback back here	
	AudioServicesAddSystemSoundCompletion (soundID,NULL,NULL,
										   testCallback,
										   self);
	
	//Use audio services to play the sound
	AudioServicesPlaySystemSound(soundID);
	
}
*/
									   
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
	[viewList release];
	[drinks release];
	[drinkCaption release];
    [super dealloc];
}

@end
