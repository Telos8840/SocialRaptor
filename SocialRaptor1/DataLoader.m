//
//  DataLoader.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 11/27/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "DataLoader.h"
#import "TableTab1.h"
#import "projectViewController.h"
#import "LaunchPage.h"

@implementation DataLoader

@synthesize delegate;

- (void)loadData
{
    [self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:2];
}

- (void)loadDataDelayed
{
    NSError *error;

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    NSMutableArray *tempArray;
    
    offset = offset+30;
    
    url = [NSString stringWithFormat:@"%s%@%s%@%s%d%s","http://webservices.socialraptor.com/activity/?uID=",user,"&auth=",passHash,"&maxID=0&offset=",offset,"&quantity=30&service="];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", url, service]];
    
    jsonData = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
    
    if(jsonData == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Load" message:@"You appear to be disconnected from the Internet"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [alert show];
    }
    else
    {
        tempArray = [jsonObjects objectAtIndex:1];
        
        array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        [tempArray addObjectsFromArray:[array objectAtIndex:1]];
        
        //NSLog(@"%@",[activities description]);
        
        if([[array objectAtIndex:1] count] == 0)
        {
            delegate.noMoreResultsAvail = true;
            if(internetActive)
                [delegate.tableView reloadData];
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                activities = tempArray;
                //NSLog(@"%@",[jsonObjects objectAtIndex: 1]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [delegate.tableView reloadData];
                });
            });
        }
    }
    delegate.loading = NO;
}

@end

