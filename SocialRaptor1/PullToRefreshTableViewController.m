//
//  PullToRefreshTableViewController.m
//  TableViewPull
//
//  Created by Jesse Collis on 1/07/10.
//  Copyright 2010 JC Multimedia Design. All rights reserved.
//

#import "PullToRefreshTableViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "TableTab1.h"
#import "projectViewController.h"
#import "SettingTab4.h"
#import "LaunchPage.h"


@implementation PullToRefreshTableViewController
@synthesize reloading=_reloading;
@synthesize refreshHeaderView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	 if (refreshHeaderView == nil) {
		 refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 320.0f, self.tableView.bounds.size.height)];
         UIImage *img = [UIImage imageNamed:@"refresh.jpg"];
         [[self refreshHeaderView] setBackgroundColor:[UIColor colorWithPatternImage:img]];
		 //refreshHeaderView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		 //refreshHeaderView.bottomBorderThickness = 1.0;
		 [self.tableView addSubview:refreshHeaderView];
		 self.tableView.showsVerticalScrollIndicator = YES;
	 }
 
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

#pragma mark -
#pragma mark ScrollView Callbacks
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	if (scrollView.isDragging) {
		if (refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshNormal];
		} else if (refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_reloading) {
			[refreshHeaderView setState:EGOOPullRefreshPulling];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (scrollView.contentOffset.y <= - 65.0f && !_reloading) {
		if(internetActive)
        {
            _reloading = YES;
            [self reloadTableViewDataSource];
            [refreshHeaderView setState:EGOOPullRefreshLoading];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Refresh" message:@"You appear to be disconnected from the Internet"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
            [alert show];
        }
	}
}

#pragma mark -
#pragma mark refreshHeaderView Methods

- (void)dataSourceDidFinishLoadingNewData{
	
	_reloading = NO;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[refreshHeaderView setState:EGOOPullRefreshNormal];
}

- (void) reloadTableViewDataSource
{
    if(internetActive==true)
    {
        NSError *error;
        TableTab1 *tt = [[TableTab1 alloc]init];
        [tt getServices];
        
        url = [NSString stringWithFormat:@"%s%@%s%@%s","http://webservices.socialraptor.com/activity/?uID=",user,"&auth=",passHash,"&maxID=0&offset=0&quantity=30&service="];
        
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", url, service]];
        jsonData = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        
        if(jsonData == nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Refresh" message:@"You appear to be disconnected from the Internet"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
            [alert show];
        }
        else
        {
            jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                activities = [jsonObjects objectAtIndex: 1];
                //NSLog(@"%@",[jsonObjects objectAtIndex: 1]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            });
        }
        offset = 0;
        [self dataSourceDidFinishLoadingNewData];
    }
    else
    {
        [self dataSourceDidFinishLoadingNewData];
    }
        
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	refreshHeaderView=nil;
}


@end

