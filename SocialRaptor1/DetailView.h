//
//  DetailView.h
//  SocialRaptor1
//
//  Created by 方 思惟 on 12/11/16.
//  Copyright (c) 2012年 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIView
@property (nonatomic, strong) UILabel *via;
@property (nonatomic, strong) UIImageView *profileImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextView *tweetLabel;
@property (nonatomic, strong) UILabel *tweetDate;
@property (nonatomic, strong) NSDictionary *detailItem;
- (void)configureView;
@end
