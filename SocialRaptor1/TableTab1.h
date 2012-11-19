//
//  TableTab1.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/13/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableTab1 : UITableViewController <UITableViewDataSource, UITableViewDelegate>

//- (void) fetchTweets;
- (NSIndexPath *)indexPathForSelectedRow;
-(void) requestActivity;

@property (strong, nonatomic) UITableView *tableView;

@end

NSArray *tweets;
NSArray *activities;