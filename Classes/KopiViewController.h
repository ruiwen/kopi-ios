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
#import <QuartzCore/QuartzCore.h>

@interface KopiViewController : UIViewController {

	IBOutlet UILabel *drinkCaption;
	
	IBOutlet UIView *milkRow;
	IBOutlet UIView *strengthRow;
	IBOutlet UIView *sweetnessRow;
	IBOutlet UIView *iceRow;	
	
	IBOutlet UIButton *milkSelection;
	IBOutlet UIButton *strengthSelection;
	IBOutlet UIButton *sweetnessSelection;
	IBOutlet UIButton *iceSelection;
	
	NSArray *viewList;
	NSDictionary *drinks;
	NSMutableDictionary *selections;
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

@property (nonatomic, retain) NSArray *viewList;
@property (nonatomic, retain) NSDictionary *drinks;
@property (nonatomic, retain) NSMutableDictionary *selections;

- (IBAction)addCaption:(id)sender;

- (void)setCaption;
- (void)makeRound:(UIView *)v roundness:(CGFloat)roundness;

@end

