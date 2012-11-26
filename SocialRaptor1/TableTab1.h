//
//  TableTab1.h
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/13/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshTableViewController.h"
#import "DetailViewController.h"

@interface TableTab1 : PullToRefreshTableViewController<DetailViewControllerDelegate>

//UITableViewController <UITableViewDataSource, UITableViewDelegate>

-(void) requestActivity;
-(void) getServices;

@property (strong, nonatomic) UITableView *tableView;

@end

NSArray *tweets;
NSArray *activities;