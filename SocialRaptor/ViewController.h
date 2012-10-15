//
//  ViewController.h
//  SocialRaptor
//
//  Created by Saul Guardado on 10/14/12.
//  Copyright (c) 2012 Saul Guardado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userInput;

@property (weak, nonatomic) IBOutlet UITextField *pwInput;

- (IBAction)dismissKeyboard:(id)sender;

@end
