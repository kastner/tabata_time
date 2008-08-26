//
//  TabataTimeAppDelegate.h
//  TabataTime
//
//  Created by Erik Kastner on 8/25/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class TabataTimeViewController;

@interface TabataTimeAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	IBOutlet UIButton *button;
	IBOutlet UILabel *label;
	IBOutlet UILabel *roundLabel;
	BOOL going;
	NSTimer *timer;
}

@property (nonatomic, retain) UIWindow *window;

- (IBAction)startTabata;

@end

