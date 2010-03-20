//
//  KopiAppDelegate.h
//  Kopi
//
//  Created by Ruiwen Chua on 3/17/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KopiViewController;

@interface KopiAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    KopiViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet KopiViewController *viewController;

@end

