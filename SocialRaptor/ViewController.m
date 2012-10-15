//
//  ViewController.m
//  SocialRaptor
//
//  Created by Saul Guardado on 10/14/12.
//  Copyright (c) 2012 Saul Guardado. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize userInput;
@synthesize pwInput;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissKeyboard:(id)sender {
    [userInput resignFirstResponder];
    [pwInput resignFirstResponder];
}

- (IBAction)dismissKeyB:(id)sender {
    [userInput resignFirstResponder];
    [pwInput resignFirstResponder];
}
@end
