//
//  projectViewController.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/13/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "projectViewController.h"
#import "TabBarViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface projectViewController ()

@end

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

@implementation projectViewController

@synthesize username, password, portrait, landscape, txtActiveField;
bool didAnimate = NO;

-(IBAction)signup
{
    
}

-(IBAction)login {
    //NSLog(@"Username: %@", username.text);
    //NSLog(@"Password: %@", password.text);
    
    NSString *passHash = [password.text MD5];
    //NSLog(@"%@", passHash);
    
    NSString *auth = [NSString stringWithFormat:@"%s%@%s%@","http://webservices.socialraptor.com/auth/?uID=",username.text,"&auth=",passHash];
    
    //NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=barackobama&count=200"]];
    
    jsonAuth = [NSData dataWithContentsOfURL:[NSURL URLWithString:auth]];
    
    jsonAuthentication = [NSJSONSerialization JSONObjectWithData:jsonAuth options:NSJSONReadingMutableContainers error:nil];
    
    
    if([[jsonAuthentication objectForKey:@"message"] isEqualToString:@"Invalid user ID or authentication."])
    {
        //NSLog(@"wrong username or password");
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Wrong username or password!" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
        [message show];
        
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%s%@%s%@%s","http://webservices.socialraptor.com/activity/?uID=",username.text,"&auth=",passHash,"&maxID=10&offset=0&quantity=10&service=all"];
        
        jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        //NSLog(@"%@",[jsonObjects objectAtIndex: 0]);
        
        NSString *contactUrl = [NSString stringWithFormat:@"%s%@%s%@%s","http://webservices.socialraptor.com/contacts/?uID=",username.text,"&auth=",passHash,"&service=all"];
        
        jsonContacts = [NSData dataWithContentsOfURL:[NSURL URLWithString:contactUrl]];
        
        jsonContactObjects = [NSJSONSerialization JSONObjectWithData:jsonContacts options:NSJSONReadingMutableContainers error:nil];
        
        //NSLog(@"%@",[jsonContactObjects objectAtIndex: 0]);
        //NSLog(@"%@",[jsonContactObjects objectAtIndex: 1]);
        
        [self performSegueWithIdentifier:@"Login" sender:self];
    }
}


//dismiss the keyboard when "return" or "done" is pressed
-(IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
    didAnimate = NO;
    [self textFieldDidEndEditing:txtActiveField];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//scroll the view up when the keyboard appears
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (didAnimate == NO) {
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
    if (didAnimate) {
        return;
    } else {
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

- (void) orientationChanged: (NSNotification *) object
{
    UIDeviceOrientation deviceOrientation = [[object object] orientation];
    
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft || deviceOrientation == UIDeviceOrientationLandscapeRight)
    {
        //[self performSegueWithIdentifier:@"Landscape" sender:self];
    }
    else
    {
        //[self performSegueWithIdentifier:@"Portrait" sender:self];
    }
}

- (BOOL) shouldAutorotate
{
    return YES;
}

@end
