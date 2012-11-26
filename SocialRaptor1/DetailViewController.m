//
//  DetailViewController.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 10/16/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "DetailViewController.h"
#import "TableTab1.h"
#import "CustomNavController.h"

@interface DetailViewController () {
    NSMutableArray *detailViews;
}
@end

@implementation DetailViewController
@synthesize activities,row;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Newspaperbg.jpg"]];
    [self.view addSubview:bg];
    
    detailViews=[[NSMutableArray alloc] initWithCapacity:4];
    
    if (row>0) {
        DetailView *detailviewLeft=[[DetailView alloc] initWithFrame:CGRectMake(-260, 20, 280, 415)];
        detailviewLeft.detailItem=[activities objectAtIndex:row-1];
        [detailviewLeft configureView];
        [self.view addSubview:detailviewLeft];
        [detailViews addObject:detailviewLeft];
        detailviewLeft.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailviewbg.png"]];
    }
    
    DetailView *detailviewMid=[[DetailView alloc] initWithFrame:CGRectMake(20, 20, 280, 415)];
    detailviewMid.detailItem=[activities objectAtIndex:row];
    [detailviewMid configureView];
    [self.view addSubview:detailviewMid];
    [detailViews addObject:detailviewMid];
    detailviewMid.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailviewbg.png"]];
    
    if (row<[activities count]-1) {
        DetailView *detailviewRight=[[DetailView alloc] initWithFrame:CGRectMake(300, 20, 280, 415)];
        detailviewRight.detailItem=[activities objectAtIndex:row+1];
        [detailviewRight configureView];
        [self.view addSubview:detailviewRight];
        [detailViews addObject:detailviewRight];
        detailviewRight.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailviewbg.png"]];
    }
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    
    // Do any additional setup after loading the view.
}

- (void)swipedLeft:(DetailViewController *)sender
{
    if (row==[activities count]-1) {
        return;
    }
    
    DetailView *detailRight2;
    if (row<[activities count]-2) {
        detailRight2=[[DetailView alloc] initWithFrame:CGRectMake(580, 20, 280, 415)];
        detailRight2.detailItem=[activities objectAtIndex:row+2];
        [detailRight2 configureView];
        [self.view addSubview:detailRight2];
        [detailViews addObject:detailRight2];
        detailRight2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailviewbg.png"]];
    }
    
    
    DetailView *detailLeft;
    DetailView *detailMid;
    DetailView *detailRight;
    if (row==0||row==[activities count]-1) {
        detailMid=[detailViews objectAtIndex:0];
        detailRight=[detailViews objectAtIndex:1];
    }else{
        detailLeft=[detailViews objectAtIndex:0];
        detailMid=[detailViews objectAtIndex:1];
        detailRight=[detailViews objectAtIndex:2];
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    
    detailRight2.frame=detailRight.frame;
    detailRight.frame=detailMid.frame;
    
    if (row>0) {
        detailMid.frame=detailLeft.frame;
        CGRect frame = detailLeft.frame;
        frame.origin.x = -540;
        [detailLeft setFrame:frame];
    }else{
        detailMid.frame=CGRectMake(-260, 20, 280, 415);
    }
    
    [UIView commitAnimations];
    
    
    if (row>0) {
        DetailView *detailLeft=[detailViews objectAtIndex:0];
        [detailLeft removeFromSuperview];
        [detailViews removeObjectAtIndex:0];
        detailLeft=nil;
    }
    
    row+=1;
}

- (void)swipedRight:(DetailViewController *)sender
{
    if (row==0) {
        return;
    }
    
    DetailView *detailLeft2;
    DetailView *detailLeft;
    DetailView *detailMid;
    if (row>1) {
        detailLeft2=[[DetailView alloc] initWithFrame:CGRectMake(-540, 20, 280, 415)];
        detailLeft2.detailItem=[activities objectAtIndex:row-2];
        [detailLeft2 configureView];
        [self.view addSubview:detailLeft2];
        [detailViews insertObject:detailLeft2 atIndex:0];
        detailLeft2.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailviewbg.png"]];
        
        detailLeft=[detailViews objectAtIndex:1];
        detailMid=[detailViews objectAtIndex:2];
    }else{
        detailLeft=[detailViews objectAtIndex:0];
        detailMid=[detailViews objectAtIndex:1];
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    
    detailLeft2.frame=detailLeft.frame;
    detailLeft.frame=detailMid.frame;
    if (row<[activities count]-1) {
        DetailView *detailRight=[detailViews objectAtIndex:(row==1)?2:3];
        detailMid.frame=detailRight.frame;
        CGRect frame = detailRight.frame;
        frame.origin.x = 580;
        [detailRight setFrame:frame];
    }else{
        detailMid.frame=CGRectMake(300, 20, 280, 415);
    }
    
    [UIView commitAnimations];
    
    
    
    if (row<[activities count]-1) {
        DetailView *detailRight=[detailViews objectAtIndex:(row==1)?2:3];
        [detailRight removeFromSuperview];
        [detailViews removeLastObject];
        detailRight=nil;
    }
    
    row-=1;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.delegate detailviewControllerBack:self];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
