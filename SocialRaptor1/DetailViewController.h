//
//  DetailViewController.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/16/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"

@class DetailViewController;

@protocol DetailViewControllerDelegate <NSObject>
-(void)detailviewControllerBack:(DetailViewController *)controller;

@end

@interface DetailViewController : UIViewController <UIGestureRecognizerDelegate>

- (void)swipedLeft:(DetailViewController *)sender;
- (void)swipedRight:(DetailViewController *)sender;

@property (strong, nonatomic) NSArray *activities;
@property (assign, nonatomic) NSInteger row;

@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;

@end
