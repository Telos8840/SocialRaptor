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

// Indicates whether the data is already loading.
// Don't load the next batch of data until this batch is finished.
// You MUST set loading = NO when the fetch of a batch of data is completed.
// See line 29 in DataLoader.m for example.
@property (nonatomic) BOOL loading;

// noMoreResultsAvail indicates if there are no more search results.
// Implement noMoreResultsAvail in your app.
// For demo purpsoses here, noMoreResultsAvail = NO.
@property (nonatomic) BOOL noMoreResultsAvail;

@property (strong, nonatomic) UITableView *tableView;

@end

NSArray *tweets;
NSMutableArray *activities;
int offset;
UIActivityIndicatorView *activityView;