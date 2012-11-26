//
//  projectViewController.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/13/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface projectViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UIImageView *logo;
    IBOutlet UILabel *label;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UISwitch *keeplogin;
    UITextField *txtActiveField;
    
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) UITextField *txtActiveField;


-(IBAction)login;
-(IBAction)dismissKeyboard: (id) sender;
-(IBAction)signup;
-(IBAction)savedata:(id)sender;


@end

NSArray *jsonObjects;
NSArray *jsonContactObjects;
NSDictionary *jsonAuthentication;
NSData *jsonData;
NSData *jsonContacts;
NSData *jsonAuth;
NSString *url;
NSString *service;
NSString *user;
NSString *pwd;
NSString *passHash;
