//
//  WebViewController.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/31/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    UIWindow *window;
}

@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) IBOutlet UIWindow *window;

@end
