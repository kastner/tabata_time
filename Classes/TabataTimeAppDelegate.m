//
//  TabataTimeAppDelegate.m
//  TabataTime
//
//  Created by Erik Kastner on 8/25/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "TabataTimeAppDelegate.h"

@implementation TabataTimeAppDelegate

@synthesize window;

- (IBAction)startTabata {
	if (!going) {
		NSLog(@"Start");
		going = YES;
		timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateTabata:) userInfo:[NSDate date] repeats:YES];
		[button setTitle:@"Stop" forState:UIControlStateNormal];
	}
	else {
		NSLog(@"Stop %@", timer);
		[timer invalidate];
		[button setTitle:@"Start" forState:UIControlStateNormal];
		going = NO;
		[label setText:@""];
		[roundLabel setText:@""];
	}
}

- (void)updateTabata:(NSTimer *)itimer {
	int round = 0;
	
	float seconds = [[itimer userInfo] timeIntervalSinceNow] * -1.0f;
	
	float offset = 3.0f;
	float offwin = 0.2f;
	
	float onFor = 20.0f;
	float offFor = 10.0f;
	float roundLength = onFor + offFor;
		
	if (seconds > offset) {
		seconds -= offset;
		
		round = ceil(seconds / roundLength);
		if (round > 8) {
			[timer invalidate];
			[label setText:@"ALL DONE!"];
			return;
		}
		
		[roundLabel setText:[NSString stringWithFormat:@"Round: %i", round]];
		float startOfRound = (round - 1) * roundLength;
		float startOfNextRound = round * roundLength;
		float startOfBreak = startOfNextRound - offFor;
		
		if (seconds > startOfRound && seconds <= startOfRound + offwin) {
			AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
		}

		if (seconds > startOfBreak && seconds <= startOfBreak + offwin) {
			AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
		}
		
		if (seconds >= startOfRound && seconds < startOfBreak) {
			[label setText:[NSString stringWithFormat:@"Go Go Go!\n%0.0f", (startOfBreak - seconds)]];
		}
		else {
			[label setText:[NSString stringWithFormat:@"Rest\n%0.0f", (startOfNextRound - seconds)]];
		}
		
		if (seconds > 0 && seconds <= offwin) {
			AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
		}		
	}
	else {
		[label setText:[NSString stringWithFormat:@"Starting in\n%0.0f", (offset - seconds)]];
	}
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	going = NO;
	// Override point for customization after app launch	
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[window release];
	[super dealloc];
}


@end
