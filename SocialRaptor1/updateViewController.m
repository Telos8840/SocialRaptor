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
@synthesize container, updateTextView, toolbar, navbar, camera, update, updateLabel;
NSUInteger charCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    //adds custom background to navbar and toolbar
    UIImage *navBarBG = [[UIImage imageNamed:@"navBarBG-rounded.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarBG forBarMetrics:UIBarMetricsDefault];
    
    [toolbar setBackgroundImage:[UIImage imageNamed:@"toolbarBG-rounded.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    updateTextView.delegate = self;
    //container.bounds = CGRectMake(0, 0, 0, 0);
	// Do any additional setup after loading the view.
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    //container.bounds = CGRectMake(20, 52, 280, 245);
    //CGRect frame = container.bounds;
    //frame.origin.x = -20;
    //frame.origin.y = 52;
    //[container setFrame:frame];
    [UIView commitAnimations];
    
    [updateTextView becomeFirstResponder];
    
    //changes keyboard to twitter type keyboard
    //updateTextField.keyboardType = UIKeyboardTypeTwitter;
    
    //adds rounded corners and shadow behind container
    container.layer.cornerRadius = 11;
    container.layer.masksToBounds = NO;
    container.layer.shadowOffset = CGSizeMake(-10, 10);
    container.layer.shadowRadius = 5;
    container.layer.shadowOpacity = 0.5;
    
    update.enabled = NO;
    updateLabel.text = @"";
}

- (void)textViewDidChange:(UITextView *)textView {
    //enable post button if user enters text
    update.enabled = YES;
    updateLabel.textColor = [UIColor blackColor];
    
    if ([updateTextView.text length] == 0 || [updateTextView.text length] > 140) {
        update.enabled = NO;
        updateLabel.text = @"";
        updateLabel.textColor = [UIColor redColor];
    }
    
    //counts the number of characters user has entered and outputs to label
    charCount = [updateTextView.text length];
    updateLabel.text = [NSString stringWithFormat:@"%u", charCount];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    update.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getPictures:(id)sender {
}

- (IBAction)postUpdate:(id)sender {
    NSString *message = [[NSString alloc] initWithFormat:@"Status posted!"];
    updateTextView.text = @"";
    [updateLabel setText:message];
    //NSLog(@"Update: %@", [updateTextField text]);
    [updateTextView resignFirstResponder];
}

- (IBAction)dismissKeyboard:(id)sender {
    [updateTextView resignFirstResponder];
}

- (IBAction)cancel {
    [updateTextView resignFirstResponder];
    updateTextView.text = @"";
    updateLabel.text = @"";
    charCount = 0;
}

@end
