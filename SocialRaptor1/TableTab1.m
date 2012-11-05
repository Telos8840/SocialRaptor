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

@interface TableTab1 () {
    NSMutableArray *_objects;
}
@end

@implementation TableTab1


//- (void) fetchTweets
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData* data = [NSData dataWithContentsOfURL:
//                        [NSURL URLWithString: @"https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=barackobama&count=200"]];
//        
//        NSError* error;
//        tweets = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];}); });
//}

- (void) requestActivity
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
//        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://webservices.socialraptor.com/activity/?uID=fred1234&auth=64575c3f7b916fa029f0d3bb13f3c9b6&maxID=3&offset=0&quantity=10&service=all"]];
//        
//        jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        activities = [jsonObjects objectAtIndex: 1];
        
        //NSLog(@"%@",[jsonObjects objectAtIndex: 1]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];}); });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return activities.count;
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return tweets.count;
//}

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
    
    NSDictionary *activity = [activities objectAtIndex:indexPath.row];
    
    NSString *text = [activity objectForKey: @"content"];
    NSString *author = [activity objectForKey: @"author"];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = [NSString stringWithFormat: @"by %@", author];
    //NSString *imageUrl = [[activity objectForKey: @"user"] objectForKey: @"profile_image_url"];
    //NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    //cell.imageView.image = [UIImage imageWithData:data];
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
//
//    NSString *text = [tweet objectForKey: @"text"];
//    NSString *name = [[tweet objectForKey: @"user"] objectForKey: @"name"];
//    cell.textLabel.text = text;
//    cell.detailTextLabel.text = [NSString stringWithFormat: @"by %@", name];
//    NSString *imageUrl = [[tweet objectForKey: @"user"] objectForKey: @"profile_image_url"];
//    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: imageUrl]];
//    cell.imageView.image = [UIImage imageWithData:data];
//    return cell;
//}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self fetchTweets];
    [self requestActivity];
}

/*- (void)viewDidLoad
 {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
 self.navigationItem.leftBarButtonItem = self.editButtonItem;
 
 UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
 self.navigationItem.rightBarButtonItem = addButton;
 }*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *activity = [activities objectAtIndex:row];
        
        DetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = activity;
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showTweet"]) {
//        
//        NSInteger row = [[self tableView].indexPathForSelectedRow row];
//        NSDictionary *tweet = [tweets objectAtIndex:row];
//        
//        DetailViewController *detailController = segue.destinationViewController;
//        detailController.detailItem = tweet;
//    }
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return _objects.count;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
 
 NSDate *object = [_objects objectAtIndex:indexPath.row];
 cell.textLabel.text = [object description];
 return cell;
 }*/

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
