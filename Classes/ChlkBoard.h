//
//  ChlkBoard.h
//  Kopi
//
//  Created by Ruiwen Chua on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

//@class ChlkBoard;

@interface ChlkBoard : NSObject<CLLocationManagerDelegate, UIWebViewDelegate> {

	IBOutlet UIView *adView;
	IBOutlet UIImageView *adImage;
	IBOutlet UILabel *adPromo;
	IBOutlet UIButton *adClick;
		
	NSString *kApikey;
	NSString *kApiEndPoint;
	
	NSMutableData *responseData;
	NSDictionary *jsonResponse;
		
	CLLocationManager *locationManager;
	
	UIWebView *webview;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) UIWebView *webview;
@property (nonatomic, retain) NSDictionary *jsonResponse;

@property (nonatomic, retain) IBOutlet UIView *adView;
@property (nonatomic, retain) IBOutlet UIImageView *adImage;
@property (nonatomic, retain) IBOutlet UILabel *adPromo;
@property (nonatomic, retain) IBOutlet UIButton *adClick;

- (id)initWithAdView:(UIView *)ibAdView withAdImage:(UIImageView *)ibAdImage withAdPromo:(UILabel *)ibAdPromo;
- (void)requestAd;
- (void)showAd;
- (void)stopUpdatingLocation;
- (IBAction)gotoAd;


@end
