//
//  ContactTab2.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/29/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "ContactTab2.h"
#import "ContactCell.h"
#import "projectViewController.h"
#import "LaunchPage.h"
#import <QuartzCore/QuartzCore.h>

@interface ContactTab2 ()

@end

@implementation ContactTab2
@synthesize images, labelName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)getContacts
{
    bool web = true; //when server can't be accessed, set this to false
    NSError *error;
    
    if(web)
    {
        NSString *contactUrl = [NSString stringWithFormat:@"%s%@%s%@%s","http://webservices.socialraptor.com/contacts/?uID=",user,"&auth=",passHash,"&service="];
        
        jsonContacts = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",contactUrl,service]]];
        jsonContactObjects = [NSJSONSerialization JSONObjectWithData:jsonContacts options:NSJSONReadingMutableContainers error:&error];
    }
    else
    {
        
        NSString *contactFilePath = [[NSBundle mainBundle] pathForResource:@"CONTACTS" ofType:@"json"];
        
        jsonContacts = [NSData dataWithContentsOfFile:contactFilePath options:NSDataReadingMappedIfSafe error:&error];
        
        jsonContactObjects = [NSJSONSerialization JSONObjectWithData:jsonContacts options:NSJSONReadingMutableContainers error:nil];
    }
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self getServices];
    [self getContacts];
    labelName = [jsonContactObjects objectAtIndex:1];
    images = [jsonContactObjects objectAtIndex:1];
    [self.collectionView reloadData];
}

-(void) getServices
{
    NSMutableArray *serv = [[NSMutableArray alloc]init];
    if([[defaults valueForKey:@"KEY0"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"Facebook"];
    if([[defaults valueForKey:@"KEY1"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"Twitter"];
    if([[defaults valueForKey:@"KEY2"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"LinkedIn"];
    if([[defaults valueForKey:@"KEY3"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"Google+"];
    
    service = [serv componentsJoinedByString:@","];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getServices];
    [self getContacts];
    labelName = [jsonContactObjects objectAtIndex:1];
    images = [jsonContactObjects objectAtIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[jsonContactObjects objectAtIndex:1] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellID";
    
    ContactCell *myCell = (ContactCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    //NSLog(@"%@",[labelName objectAtIndex:indexPath.item]);
    
    myCell.name.text = [[labelName objectAtIndex:indexPath.item] objectForKey:@"name"];
    
    NSString *imageUrl = [[images objectAtIndex:indexPath.item] objectForKey: @"imageURL"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]];

    [myCell.profpic.layer setMasksToBounds:YES];
    myCell.profpic.layer.cornerRadius = 8;
    myCell.profpic.image = [UIImage imageWithData:data];
    
    //[self.view addSubview:uiimv];
    
    if([[[labelName objectAtIndex:indexPath.item] objectForKey:@"service"] isEqualToString:@"Twitter"])
    {
        myCell.servicepic.image = [UIImage imageNamed:@"twitter.png"];
    }
    else if([[[labelName objectAtIndex:indexPath.item] objectForKey:@"service"] isEqualToString:@"Facebook"])
    {
        myCell.servicepic.image = [UIImage imageNamed:@"facebook.png"];
    }
    return myCell;
}

@end
