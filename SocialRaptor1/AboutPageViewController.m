//
//  AboutPageViewController.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 12/1/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "AboutPageViewController.h"

@interface AboutPageViewController ()

@end

@implementation AboutPageViewController

-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
