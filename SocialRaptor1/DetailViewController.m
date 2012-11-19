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

@interface DetailViewController ()

- (void)configureView;
@end

@implementation DetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *activity = self.detailItem;
        
        //NSDateFormatter *fromTwitter = [[NSDateFormatter alloc] init];
        // here we set the DateFormat  - note the quotes around +0000
        //[fromTwitter setDateFormat:@"EEE MMM dd HH:mm:ss '+0000' yyyy"];
        // We need to set the locale to english - since the day- and month-names are in english
        //[fromTwitter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
        
        NSString *text = [activity objectForKey:@"content"];
        NSString *author = [activity objectForKey:@"author"];
        NSString *service = [activity objectForKey:@"service"];
        
        
        //NSString *dateString = [activity objectForKey:@"created_at"];
        //NSDate *tweetedDate = [fromTwitter dateFromString:dateString];
        
        nameLabel.text = author;
        tweetLabel.text = text;
        via.text = [NSString stringWithFormat:@"via %@",service];
        
        //tweetDate.text = [NSString stringWithFormat:@"%@",tweetedDate];
        NSString * timeStampString =[activity objectForKey:@"dateTime"];
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
        NSString *_date=[_formatter stringFromDate:date];
        tweetDate.text = [NSString stringWithFormat:@"%@", _date];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = [activity objectForKey:@"imageURL"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                profileImage.image = [UIImage imageWithData:data];
            });
        });
    }
}

//- (void)configureView
//{
//    if (self.detailItem) {
//        NSDictionary *tweet = self.detailItem;
//        
//        NSDateFormatter *fromTwitter = [[NSDateFormatter alloc] init];
//        // here we set the DateFormat  - note the quotes around +0000
//        [fromTwitter setDateFormat:@"EEE MMM dd HH:mm:ss '+0000' yyyy"];
//        // We need to set the locale to english - since the day- and month-names are in english
//        [fromTwitter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
//        
//        NSString *text = [tweet objectForKey:@"text"];
//        NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];        
//        
//        
//        NSString *dateString = [tweet objectForKey:@"created_at"];
//        NSDate *tweetedDate = [fromTwitter dateFromString:dateString];
//        
//        nameLabel.text = name;
//        tweetLabel.text = text;
//        tweetDate.text = [NSString stringWithFormat:@"%@",tweetedDate];
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                profileImage.image = [UIImage imageWithData:data];
//            });
//        });
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
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

}

- (void)swipedRight:(DetailViewController *)sender
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
