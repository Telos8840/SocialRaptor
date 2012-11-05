//
//  updateViewController.h
//  SocialRaptor1
//
//  Created by Saul Guardado on 10/29/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface updateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UITextField *updateTextField;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, retain) IBOutlet UIBarButtonItem *camera;
@property (strong, retain) IBOutlet UIBarButtonItem * update;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;

- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)cancel;

@end
