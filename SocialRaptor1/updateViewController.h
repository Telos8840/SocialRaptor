//
//  updateViewController.h
//  SocialRaptor1
//
//  Created by Saul Guardado on 10/29/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface updateViewController : UIViewController <UITextViewDelegate>
@property (strong, retain) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;
@property (strong, retain) IBOutlet UIBarButtonItem *camera;
@property (strong, retain) IBOutlet UIBarButtonItem * update;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (strong, nonatomic) IBOutlet UITextView *updateTextView;

- (IBAction)getPictures:(id)sender;
- (IBAction)postUpdate:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)cancel;

@end
