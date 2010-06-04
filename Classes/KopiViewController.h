//
//  KopiViewController.h
//  Kopi
//
//  Created by Ruiwen Chua on 3/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIInterface.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface KopiViewController : UIViewController <AVAudioPlayerDelegate, CLLocationManagerDelegate> {

	IBOutlet UILabel *drinkCaption;
	
	IBOutlet UIView *milkRow;
	IBOutlet UIView *strengthRow;
	IBOutlet UIView *sweetnessRow;
	IBOutlet UIView *iceRow;	
	
	IBOutlet UIButton *milkSelection;
	IBOutlet UIButton *strengthSelection;
	IBOutlet UIButton *sweetnessSelection;
	IBOutlet UIButton *iceSelection;
	
	IBOutlet UIButton *playButton;
	IBOutlet UIButton *stopButton;
	IBOutlet UIButton *resetButton;
	
	IBOutlet UIView *ibAdView;
	IBOutlet UIImageView *ibAdImage;
	IBOutlet UILabel *ibAdPromo;
	
	UIView *adView;
	UIImageView *adImage;
	UILabel *adPromo;
	
	NSEnumerator *e;
	NSArray *order;
	NSArray *viewList;
	NSDictionary *drinks;
	NSMutableDictionary *selections;
	bool *shouldContinue;
	
	NSString *kApikey;
	NSString *kApiEndPoint;	
	NSDictionary *jsonResponse;
	CLLocationManager *locationManager;
	
}

@property (nonatomic, retain) IBOutlet UILabel *drinkCaption;

@property (nonatomic, retain) IBOutlet UIView *milkRow;
@property (nonatomic, retain) IBOutlet UIView *strengthRow;
@property (nonatomic, retain) IBOutlet UIView *sweetnessRow;
@property (nonatomic, retain) IBOutlet UIView *iceRow;

@property (nonatomic, retain) IBOutlet UIButton *milkSelection;
@property (nonatomic, retain) IBOutlet UIButton *strengthSelection;
@property (nonatomic, retain) IBOutlet UIButton *sweetnessSelection;
@property (nonatomic, retain) IBOutlet UIButton *iceSelection;

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
@property (nonatomic, retain) IBOutlet UIButton *resetButton;

@property (nonatomic, retain) NSEnumerator *e;
@property (nonatomic, retain) NSArray *order;
@property (nonatomic, retain) NSArray *viewList;
@property (nonatomic, retain) NSDictionary *drinks;
@property (nonatomic, retain) NSMutableDictionary *selections;

@property (nonatomic) bool *shouldContinue;

@property (nonatomic, retain) IBOutlet UIView *ibAdView;
@property (nonatomic, retain) IBOutlet UIImageView *ibAdImage;
@property (nonatomic, retain) IBOutlet UILabel *ibAdPromo;

@property (nonatomic, retain) UIView *adView;
@property (nonatomic, retain) UIImageView *adImage;
@property (nonatomic, retain) UILabel *adPromo;

@property (nonatomic, retain) NSString *kApikey;
@property (nonatomic, retain) NSString *kApiEndPoint;
@property (nonatomic, retain) NSDictionary *jsonResponse;
@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction)addCaption:(id)sender;
- (IBAction)playCaption;
- (IBAction)stopPlaying;
- (IBAction)resetSelection;

- (void)setCaption;
- (void)makeRound:(UIView *)v roundness:(CGFloat)roundness;
- (void)toggleButton:(UIButton *)v on:(BOOL)on;
- (void)playCaptionSounds;
- (void)isPlaying:(BOOL)isPlaying;

- (IBAction)testChlkBoard;

- (void)requestAd;
- (void)showAd;
- (void)stopUpdatingLocation;
- (IBAction)gotoAd;

/*
static void testCallback(SystemSoundID, void* );
static void playCaptionSound(SystemSoundID, NSEnumerator *);
*/

@end

