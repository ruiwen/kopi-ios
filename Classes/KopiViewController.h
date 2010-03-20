//
//  KopiViewController.h
//  Kopi
//
//  Created by Ruiwen Chua on 3/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KopiViewController : UIViewController {

	IBOutlet UILabel *drinkCaption;
	
	IBOutlet UIButton *milkSelection;
	IBOutlet UIButton *strengthSelection;
	IBOutlet UIButton *sweetnessSelection;
	IBOutlet UIButton *iceSelection;
	
	NSDictionary *drinks;
	NSMutableDictionary *captionList;
	NSMutableDictionary *selections;
}

@property (nonatomic, retain) IBOutlet UILabel *drinkCaption;

@property (nonatomic, retain) IBOutlet UIButton *milkSelection;
@property (nonatomic, retain) IBOutlet UIButton *strengthSelection;
@property (nonatomic, retain) IBOutlet UIButton *sweetnessSelection;
@property (nonatomic, retain) IBOutlet UIButton *iceSelection;

@property (nonatomic, retain) NSDictionary *drinks;
@property (nonatomic, retain) NSMutableDictionary *captionList;
@property (nonatomic, retain) NSMutableDictionary *selections;

- (IBAction)makeRed;
- (IBAction)setMilk:(id)sender;
- (IBAction)setStrength:(id)sender;
- (IBAction)setSweetness:(id)sender;
- (IBAction)setIced:(id)sender;

- (void)setCaption;
- (void)addToCaption: key:(NSString *)key sender:(id)sender;

- (void)doStuff;

@end

