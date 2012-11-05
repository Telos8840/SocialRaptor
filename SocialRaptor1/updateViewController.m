//
//  updateViewController.m
//  SocialRaptor1
//
//  Created by Saul Guardado on 10/29/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "updateViewController.h"


@interface updateViewController () 

@end

@implementation updateViewController
@synthesize container, updateTextField, toolbar, camera, update, updateLabel;

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
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    
    //change text field height
    CGRect textFrame = updateTextField.frame;
    textFrame.size.height = 180;
    textFrame.origin.y = -160;
    [container setFrame:textFrame];
    [UIView commitAnimations];
    updateTextField.frame = textFrame;
    [updateTextField becomeFirstResponder];
    
    //changes keyboard to twitter type keyboard
    //updateTextField.keyboardType = UIKeyboardTypeTwitter;
    
    //adds rounded corners and shadow behind container
//    container.layer.cornerRadius = 8;
//    container.layer.masksToBounds = NO;
    container.layer.shadowOffset = CGSizeMake(-10, 10);
    container.layer.shadowRadius = 5;
    container.layer.shadowOpacity = 0.5;
    
    //adds buttons to toolbar
    camera = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    update = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(updateStatus)];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:camera, space, update, nil];
    [toolbar setItems:toolbarItems animated:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateStatus
{
    NSString *message = [[NSString alloc] initWithFormat:@"Status posted!"];
    [updateLabel setText:message];
    //NSLog(@"Update: %@", [updateTextField text]);
    [updateTextField resignFirstResponder];
}

- (IBAction)dismissKeyboard:(id)sender
{
    [updateTextField resignFirstResponder];
}

- (IBAction)cancel
{
    updateTextField.text = @"";
}

@end
