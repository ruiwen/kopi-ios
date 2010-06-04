//
//  ChlkBoard.m
//  Kopi
//
//  Created by Ruiwen Chua on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ChlkBoard.h"
#import "JSON.h"

@implementation ChlkBoard

@synthesize responseData, jsonResponse;
@synthesize locationManager;
@synthesize adView, adImage, adPromo, adClick;

/*
- (void)awakeFromNib {
	[self retain];
	
}*/

- (id)init {
	// Init API
	kApikey = @"sJPzGk6ut5Ou4j8UshpyZBA0XRL8ceD97Bp8FbvC5VHTvndrit";
	kApiEndPoint = @"http://www.chlkboard.com/api/search.php?";
	
	responseData = [[NSMutableData data] retain];	
	
	return self;
}

- (id)initWithAdView:(UIView *)ibAdView withAdImage:(UIImageView *)ibAdImage withAdPromo:(UILabel *)ibAdPromo {
	
	
	// Init API
	//kApikey = @"sJPzGk6ut5Ou4j8UshpyZBA0XRL8ceD97Bp8FbvC5VHTvndrit";
	//kApiEndPoint = @"http://www.chlkboard.com/api/search.php?";
	
	[self init];
	
	
	// Accept the views
	self.adView = ibAdView;
	self.adImage = ibAdImage;
	self.adPromo = ibAdPromo;
	
	NSLog(@"Adclick: %@", adClick);
	
	return self;
}

- (void)showAd {

	// Load up the image
	NSData *imagedata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[jsonResponse valueForKey:@"pic"] objectAtIndex:0]]];
	UIImage *image = [[UIImage alloc] initWithData:imagedata];
	self.adImage.image = image;
	[adImage sizeToFit];
	NSLog(@"adImage: %@", adImage);
	
	
	// Display the promo
	self.adPromo.text = [[jsonResponse valueForKey:@"promo"] objectAtIndex:0];
	NSLog(@"adPromo: %@", self.adPromo);
	
	NSLog(@"Adview: %@", self.adView);
	self.adView.hidden = NO;
	
	NSLog(@"Got stuff!");

}

- (void)requestAd {
	
	// Init location manager
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
	[locationManager startUpdatingLocation];
	NSLog(@"Started updating location!");
	
	// Set the timeout
	[self performSelector:@selector(stopUpdatingLocation) withObject:@"Timed Out" afterDelay:10.0];
}

- (void)stopUpdatingLocation {
	NSLog(@"Stopped getting location");
	[locationManager stopUpdatingLocation];
    locationManager.delegate = nil;    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

	CLLocationDegrees lat = newLocation.coordinate.latitude;
	CLLocationDegrees lng = newLocation.coordinate.longitude;

	// Once we're satisfied that we have a proper location, stop the polling
	if(lat && lng) {
		[self stopUpdatingLocation];
	}
	else {
		return;
	}
	
	// Build API query
	NSString *apiUrl = [kApiEndPoint stringByAppendingFormat:@"key=%@&lat=%f&lng=%f&n=1", kApikey, lat, lng];
	if(!apiUrl) {
		NSLog(@"%f", lat);
		NSLog(@"%f", lng);
		NSLog(@"%@", kApikey);
		NSLog(@"%@", apiUrl);
		NSLog(@"Blank URL!");
		return; // Blank URL! Abort!
	}	   
	
	// Retrieve JSON call
	NSString *data = [NSString stringWithContentsOfURL:[NSURL URLWithString:apiUrl]];
	
	/*
	NSLog(@"%@", [data JSONValue]);
	NSLog(@"%@", [[[data JSONValue] valueForKey:@"results"] class]);
	NSLog(@"%@", [[[data JSONValue] valueForKey:@"results"] valueForKey:@"pic"]);
	*/
	
	// Pull the real stuff
	jsonResponse = [[data JSONValue] valueForKey:@"results"];
	[jsonResponse retain];
	NSLog(@"%@", jsonResponse);
	
	[self showAd];


	/*
	UIWebView *w = [[UIWebView alloc] initWithFrame:[self.view convertRect:self.view.frame fromView:self.view.superview]];
	w.delegate = self;
	NSLog(@"%@", self.view);
	NSLog(@"%@", [self.view subviews]);
	NSLog(@"%@", [jsonResults count]);
	//self.view.hidden = YES;
	
	if([[jsonResults valueForKey:@"url"] count] > 0){
		[w loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[jsonResults valueForKey:@"url"] objectAtIndex:0]]]];
	}
	else {
		// DEBUG ONLY!
		[w loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
	}*/
	
	/*
	if([[jsonResults valueForKey:@"url"] count] > 0){
		[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[jsonResults valueForKey:@"url"] objectAtIndex:0]]]];
	}
	else {
		// DEBUG ONLY!
		[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
	}*/
	
	
	//[self.view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[jsonResults valueForKey:@"url"]]]];
	//NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[jsonResults valueForKey:@"pic"]];*/
	
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Web view loading!");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Web view finished loading");	
	
	//self.view.backgroundColor = [UIColor blackColor];
	//[self.view addSubview:webView];
	//[self.view bringSubviewToFront:webView];
	NSLog(@"%@", webView);
}

- (void)loadAdImage:(NSString *)imageUrl {

}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	
	[self showAd];
}

- (IBAction)gotoAd {
	NSLog(@"Goto Ad");
	//NSLog([NSURL URLWithString:[[jsonResponse objectForKey:@"url"] objectAtIndex:0]]);
	//NSURL *url = [NSURL URLWithString:[[jsonResponse objectForKey:@"url"] objectAtIndex:0]];
	//[[UIApplication sharedApplication] openURL:url];
}


- (void)dealloc {
	[responseData release];
	[locationManager release];
	[super dealloc];
}

@end
