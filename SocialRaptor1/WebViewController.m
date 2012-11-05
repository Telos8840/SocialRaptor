//
//  WebViewController.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/31/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView, window;

- (void)webViewDidFinishLoad:(UIWebView *)webview
{
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://socialraptor.com"]]];
    webView.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
