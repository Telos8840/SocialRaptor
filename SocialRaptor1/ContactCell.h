//
//  ContactCell.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/29/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profpic;
@property (strong, nonatomic) IBOutlet UIImageView *servicepic;
@property (strong, nonatomic) IBOutlet UILabel *name;

@end
