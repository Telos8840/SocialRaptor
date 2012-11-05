//
//  DetailViewController.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/16/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIGestureRecognizerDelegate>{
    IBOutlet UILabel *via;
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UITextView *tweetLabel;
    IBOutlet UILabel *tweetDate;
}

- (void)swipedLeft:(DetailViewController *)sender;
- (void)swipedRight:(DetailViewController *)sender;

@property (weak, nonatomic) id detailItem;

@end
