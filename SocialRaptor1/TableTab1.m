//
//  TableTab1.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/13/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "TableTab1.h"
#import "DetailViewController.h"
#import "projectViewController.h"
#import "CustomNavController.h"
#import "SettingTab4.h"
#import "DetailView.h"
#import "LaunchPage.h"
#import <QuartzCore/QuartzCore.h>

@interface TableTab1 ()
-(UIImage *)selectedBackgroundImageForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@implementation TableTab1

-(void) getServices
{
    NSMutableArray *serv = [[NSMutableArray alloc]init];
    if([[defaults valueForKey:@"KEY0"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"Facebook"];
    if([[defaults valueForKey:@"KEY1"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"Twitter"];
    if([[defaults valueForKey:@"KEY2"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"LinkedIn"];
    if([[defaults valueForKey:@"KEY3"] isEqualToNumber:[NSNumber numberWithInt:1]])
        [serv addObject:@"GooglePlus"];
        
    service = [serv componentsJoinedByString:@","];
}

-(void) getActivities
{
    bool web = true; //when server can't be accessed, set this to false
    
    if(web)
    {
        NSError *error;
        
        [self getServices];
        
        url = [NSString stringWithFormat:@"%s%@%s%@%s","http://webservices.socialraptor.com/activity/?uID=",user,"&auth=",passHash,"&maxID=10000&offset=0&quantity=600&service="];
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", url, service]];
        
        jsonData = [NSData dataWithContentsOfURL:URL options:NSDataReadingUncached error:&error];
        
        jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        //NSLog(@"%@",[jsonObjects objectAtIndex: 0]);
    }
    else
    {
        //using json file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DATA" ofType:@"json"];
        NSError *error = nil;
        jsonData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
        
        jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    
}

- (void) requestActivity
{
    [self getActivities];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       activities = [jsonObjects objectAtIndex: 1];
       //NSLog(@"%@",[jsonObjects objectAtIndex: 1]);
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
       });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return activities.count;
}

- (NSIndexPath *)indexPathForSelectedRow
{
    return self.tableView.indexPathForSelectedRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImageView *selectedBackgroundView=[[UIImageView alloc] initWithFrame:cell.frame];
    selectedBackgroundView.image=[self selectedBackgroundImageForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView=selectedBackgroundView;
    
    NSDictionary *activity = [activities objectAtIndex:indexPath.row];
    
    NSString *text = [activity objectForKey: @"content"];
    NSString *author = [activity objectForKey: @"author"];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = [NSString stringWithFormat: @"by %@", author];
    
    NSString *imageUrl = [activity objectForKey: @"imageURL"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    [cell.imageView.layer setMasksToBounds:YES];
    cell.imageView.layer.cornerRadius = 8;
    cell.imageView.image = [UIImage imageWithData: data];
    return cell;
}

-(UIImage *)selectedBackgroundImageForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *background=[UIImage imageNamed:@"cellbg4click.png"];
    return background;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshHeaderView setLastRefreshDate:nil];
    [self requestActivity];
    UIImage *img = [UIImage imageNamed:@"cellbg4.png"];
	[[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:img]];
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBackgroundImage:[UIImage imageNamed:@"Plain_green_background.jpg"] forBarMetrics:UIBarMetricsDefault];
}

-(void) viewWillAppear:(BOOL)animated
{
    if(changes == YES)
    {
        [self getServices];
        [self getActivities];
        [self requestActivity];
        [self.tableView scrollsToTop];
        changes = NO;
        animated = NO;
    }
    else
    {
        [self.tableView scrollsToTop];
        animated = YES;
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)reloadTableViewDataSource{
    [self getServices];
    [super reloadTableViewDataSource];
	[super performSelector:@selector(dataSourceDidFinishLoadingNewData) withObject:nil afterDelay:2.0];
	
}
- (void)dataSourceDidFinishLoadingNewData{
	[super dataSourceDidFinishLoadingNewData];
    [refreshHeaderView setCurrentDate];  //  should check if data reload was successful
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        
        //        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        //        NSDictionary *activity = [activities objectAtIndex:row];
        
        DetailViewController *detailController = segue.destinationViewController;
        detailController.row = [[self tableView].indexPathForSelectedRow row];
        detailController.activities=activities;
        detailController.delegate=self;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark - DetailViewDelegate
-(void)detailviewControllerBack:(DetailViewController *)controller{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:controller.row inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
