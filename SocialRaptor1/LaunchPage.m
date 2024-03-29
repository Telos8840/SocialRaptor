//
//  LaunchPage.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 11/21/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "LaunchPage.h"
#import "projectViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "Reachability.h"

@interface LaunchPage ()

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

@implementation LaunchPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            //NSLog(@"The internet is down.");
            internetActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            //NSLog(@"The internet is working via WIFI.");
            internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            //NSLog(@"The internet is working via WWAN.");
            internetActive = YES;
            
            break;
        }
    }
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            //NSLog(@"A gateway to the host server is down.");
            hostActive = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            //NSLog(@"A gateway to the host server is working via WIFI.");
            hostActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            //NSLog(@"A gateway to the host server is working via WWAN.");
            hostActive = YES;
            
            break;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	imageView.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"raptor0.png"],
                                 [UIImage imageNamed:@"raptor1.png"],
                                 [UIImage imageNamed:@"raptor2.png"],
                                 [UIImage imageNamed:@"raptor3.png"],
                                 [UIImage imageNamed:@"raptor4.png"],
                                 [UIImage imageNamed:@"raptor5.png"],
                                 [UIImage imageNamed:@"raptor6.png"],
                                 [UIImage imageNamed:@"raptor7.png"],
                                 [UIImage imageNamed:@"raptor6.png"],
                                 [UIImage imageNamed:@"raptor5.png"],
                                 [UIImage imageNamed:@"raptor4.png"],
                                 [UIImage imageNamed:@"raptor3.png"],
                                 [UIImage imageNamed:@"raptor2.png"],
                                 [UIImage imageNamed:@"raptor1.png"],nil];
    
    
    imageView.animationDuration = 3.0;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to a random host exists
    hostReachable = [Reachability reachabilityWithHostName: @"www.apple.com"];
    [hostReachable startNotifier];
   
}

-(void) viewDidAppear:(BOOL)animated
{
    sleep(5);
    
    [self checkNetworkStatus:nil];
    
    if(internetActive)
    {
        defaults = [NSUserDefaults standardUserDefaults];
        NSString *loadUser = [defaults objectForKey:@"savedUser"];
        NSString *loadPass = [defaults objectForKey:@"savedPass"];
        //    NSLog(@"%@ %@",loadUser,loadPass);
        if(loadUser && loadPass){
            user = loadUser;
            
            //encrypt password with MD5 encryption
            passHash = [loadPass MD5];
            
            //authenticate user
            NSString *auth = [NSString stringWithFormat:@"%s%@%s%@","http://webservices.socialraptor.com/auth/?uID=",user,"&auth=",passHash];
            jsonAuth = [NSData dataWithContentsOfURL:[NSURL URLWithString:auth]];
            jsonAuthentication = [NSJSONSerialization JSONObjectWithData:jsonAuth options:NSJSONReadingMutableContainers error:nil];
            
            [self performSegueWithIdentifier:@"Tabbed" sender:self];
        }
        else
        {
            [self performSegueWithIdentifier:@"LoginPage" sender:self];
        }
            
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Social Raptor cannot be opened because you are not connected to the Internet"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [alert show];
        
        [self performSegueWithIdentifier:@"LoginPage" sender:self];
    }
        
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
