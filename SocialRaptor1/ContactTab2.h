//
//  ContactTab2.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/29/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTab2 : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *images, *labelName;
}

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSArray *labelName;

@end
