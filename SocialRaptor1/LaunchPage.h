//
//  LaunchPage.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 11/21/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;

@interface LaunchPage : UIViewController
{
    IBOutlet UIImageView *imageView;
    Reachability* internetReachable;
    Reachability* hostReachable;
    
}
-(void) checkNetworkStatus:(NSNotification *)notice;
@end

NSUserDefaults *defaults;
bool internetActive;
bool hostActive;