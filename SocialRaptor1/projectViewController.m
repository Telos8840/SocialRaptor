//
//  projectViewController.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/13/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "projectViewController.h"
#import "TabBarViewController.h"
#import "SettingTab4.h"
#import "LaunchPage.h"
#import <CommonCrypto/CommonDigest.h>

@interface projectViewController ()

@end


////////////////////////////////////////////////////////////////////////////////////////////////
@interface NSString (MD5)
-(NSString *)MD5;
@end;

@implementation NSString (MD5)

- (NSString *)MD5
{
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}
@end
///////////////////////////////////////////////////////////////////////////////////////////////

@implementation projectViewController

@synthesize username, password, txtActiveField;

bool didAnimate = NO;

-(IBAction)signup
{
    if(!internetActive)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cannot Open the Web" message:@"You appear to be disconnected from the Internet"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [alert show];

    }
}

-(IBAction)login {
    
    if(internetActive)
    {
        user = username.text;
        
        //encrypt password with MD5 encryption
        passHash = [password.text MD5];
        
        //authenticate user
        NSString *auth = [NSString stringWithFormat:@"%s%@%s%@","http://webservices.socialraptor.com/auth/?uID=",username.text,"&auth=",passHash];
        jsonAuth = [NSData dataWithContentsOfURL:[NSURL URLWithString:auth]];
        jsonAuthentication = [NSJSONSerialization JSONObjectWithData:jsonAuth options:NSJSONReadingMutableContainers error:nil];
        
        if([[jsonAuthentication objectForKey:@"message"] isEqualToString:@"Invalid user ID or authentication."])
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Wrong username or password!" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
            [message show];
        }
        else //valid ID and password
        {
            //save username and password
            [self savedata:self];
            //go to activities page
            [self performSegueWithIdentifier:@"Login" sender:self];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"You appear to be disconnected from the Internet"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [alert show];
    }
    
}


-(IBAction)savedata:(id)sender
{
    NSString *saveUser = username.text;
    NSString *savePass = password.text;

    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:saveUser forKey:@"savedUser"];
    [defaults setObject:savePass forKey:@"savedPass"];

    [defaults synchronize];
}

//dismiss the keyboard when "return" or "done" is pressed
-(IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
    didAnimate = NO;
    [self textFieldDidEndEditing:txtActiveField];
}

- (void)viewDidLoad
{
	// load saved configurations
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadUser = [defaults objectForKey:@"savedUser"];
    NSString *loadPass = [defaults objectForKey:@"savedPass"];
    
    if(loadUser && loadPass)
    {
        [username setText:loadUser];
        [password setText:loadPass];
    }

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//scroll the view up when the keyboard appears
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(didAnimate == NO)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y = -160;
        [self.view setFrame:frame];
        [UIView commitAnimations];
        didAnimate = YES;
    }
        
    //check which text field was selected
    if (username.isFirstResponder) {
        txtActiveField = username;
    } else {
        txtActiveField = password;
    }
    
    //change keyboard type for user input
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    //adds previous, next and done to keyboard
    UIBarButtonItem *previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(previousField)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextField)];
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:previousButton, nextButton, extraSpace, doneButton, nil];
    
    [toolbar setItems:itemsArray];
    
    [textField setInputAccessoryView:toolbar];
}

//scroll the view down when the keyboard disappears
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(didAnimate)
        return;
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y = 20;
        [self.view setFrame:frame];
        [UIView commitAnimations];
        didAnimate = NO;
    }
}

-(void)previousField {
    if (txtActiveField == username) {
        return;
    } else {
        [username becomeFirstResponder];
    }
}

-(void)nextField {
    if (txtActiveField == password) {
        return;
    } else {
        [password becomeFirstResponder];
    }
}

-(void)resignKeyboard {
    [username resignFirstResponder];
    [password resignFirstResponder];
    didAnimate = NO;
    [self textFieldDidEndEditing:txtActiveField];
}

- (BOOL) shouldAutorotate
{
    return YES;
}

@end
