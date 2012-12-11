//
//  SettingTab4.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/27/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "SettingTab4.h"
#import "projectViewController.h"
#import "LaunchPage.h"

@interface SettingTab4 ()
{
    NSArray *servicesArray;
    NSArray *miscArray;
}
//-(UIImage *)backgroundImageForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@implementation SettingTab4

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    servicesArray = [[NSArray alloc] init];
    miscArray = [[NSArray alloc] init];
    
    UIImageView *boxBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenpaper.jpg"]];
    [self.tableView setBackgroundView:boxBackView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(UIImage *)backgroundImageForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        UIImage *background=[[UIImage imageNamed:@"table_cell_top.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 70, 0, 64)];
//        return background;
//    }else if(indexPath.section ==0 && indexPath.row==2){
//        UIImage *background=[[UIImage imageNamed:@"table_cell_bottom.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 34, 0, 35)];
//        return background;
//    }else{
//        UIImage *background=[[UIImage imageNamed:@"table_cell_mid.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30)];
//        return background;
//    }
//}


#pragma mark - LogOut

- (IBAction)logout
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Log out of Social Raptor?\nAll settings will be cleared."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedUser"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedPass"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"KEY0"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"KEY1"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"KEY2"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"KEY3"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"Logout" sender:self];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
    {
        servicesArray = [NSArray arrayWithObjects:@"Facebook", @"Twitter", @"LinkedIn", @"Google+",nil];
        return [servicesArray count];
    }
    else if(section == 1)
    {
        miscArray = [NSArray arrayWithObjects: @"About", nil];
        return [miscArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *CellIdentifier;
    
    if(indexPath.section ==0)
    {
        CellIdentifier = @"settingCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//        
//        UIImageView *backgroundView=[[UIImageView alloc] initWithFrame:cell.frame];
//        backgroundView.image=[self backgroundImageForRowAtIndexPath:indexPath];
//        cell.backgroundView=backgroundView;
        
        // Configure the cell...
        cell.textLabel.text = [servicesArray objectAtIndex:indexPath.row];
        
        if([self getCheckedForIndex:indexPath.row]==YES)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
       // NSLog(@"%@",[[selectedIndices objectAtIndex:indexPath.row] description]);
    }
    else if(indexPath.section == 1)
    {
        CellIdentifier = @"miscCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        UIImage *img = [UIImage imageNamed:@"refresh.jpg"];
        [[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:img]];
        // Configure the cell...
        cell.textLabel.text = [miscArray objectAtIndex:indexPath.row];
        //NSLog(@"%d", indexPath.row);
    }
    
    return cell;
}

- (NSString *)getKeyForIndex:(int)index
{
    return [NSString stringWithFormat:@"KEY%d",index];
}

- (BOOL) getCheckedForIndex:(int)index
{
    if([[defaults valueForKey:[self getKeyForIndex:index]] boolValue]==YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void) checkedCellAtIndex:(int)index
{
    BOOL boolChecked = [self getCheckedForIndex:index];
    
    [defaults setValue:[NSNumber numberWithBool:!boolChecked] forKey:[self getKeyForIndex:index]];
    [defaults synchronize];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionHeader = nil;
	
	if(section == 0) {
		sectionHeader = @"Services";
	}
    if(section == 1) {
        sectionHeader = @"Miscellaneous";
    }
	return sectionHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
//    UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
//    if(section == 0) {
//		titleLabel.text = @"Services";
//	}
//    if(section == 1) {
//        titleLabel.text = @"Miscellaneous";
//    }
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    [customTitleView addSubview:titleLabel];
//    return customTitleView;
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20, 8, 320, 20);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(-1.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    
    return view;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch(indexPath.section)
    {
        case 0:
        {
            changes = YES;
            
            UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            
            if([self getCheckedForIndex:indexPath.row]==YES)
            {
                selectedCell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
            {
                selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            [self checkedCellAtIndex:indexPath.row];
            if([[defaults valueForKey:@"KEY0"] isEqualToNumber:[NSNumber numberWithInt:0]]&&[[defaults valueForKey:@"KEY1"] isEqualToNumber:[NSNumber numberWithInt:0]]&&[[defaults valueForKey:@"KEY2"] isEqualToNumber:[NSNumber numberWithInt:0]]&&[[defaults valueForKey:@"KEY3"] isEqualToNumber:[NSNumber numberWithInt:0]]){
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Select at least one service" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [message show];
                selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self checkedCellAtIndex:indexPath.row];
            }
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            break;
        }
        case 1:
            
            break;
    }
}

@end
