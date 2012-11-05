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

@interface ContactTab2 ()

@end

@implementation ContactTab2

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
    labelName = [jsonContactObjects objectAtIndex:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
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
    
    return myCell;
}

@end
