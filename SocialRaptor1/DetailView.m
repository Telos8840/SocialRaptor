//
//  DetailView.m
//  SocialRaptor1
//
//  Created by 方 思惟 on 12/11/16.
//  Copyright (c) 2012年 CS480. All rights reserved.
//

#import "DetailView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DetailView
@synthesize via,nameLabel,tweetDate,tweetLabel,profileImage,detailItem;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        via=[[UILabel alloc] initWithFrame:CGRectMake(5, 350, 250, 60)];
        nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 250, 60)];
        tweetDate=[[UILabel alloc] initWithFrame:CGRectMake(12, 79, 250, 20)];
        tweetLabel=[[UITextView alloc] initWithFrame:CGRectMake(10, 110, 180, 270)];
        profileImage=[[UIImageView alloc] initWithFrame:CGRectMake(200, 115, 70, 70)];
        
        via.backgroundColor=[UIColor clearColor];
        nameLabel.backgroundColor=[UIColor clearColor];
        tweetDate.backgroundColor=[UIColor clearColor];
        tweetLabel.backgroundColor=[UIColor clearColor];
        
        via.textAlignment=NSTextAlignmentRight;
        via.font = [UIFont fontWithName:@"Zapfino" size:13];
        tweetDate.textAlignment=NSTextAlignmentCenter;
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.font=[UIFont fontWithName:@"Zapfino" size:20];
        nameLabel.adjustsFontSizeToFitWidth=YES;
        tweetLabel.font=[UIFont fontWithName:@"TimesNewRomanPSMT" size:16];
        tweetLabel.editable=NO;
        tweetLabel.dataDetectorTypes=UIDataDetectorTypeLink;
        tweetDate.font=[UIFont fontWithName:@"Papyrus" size:14];
        nameLabel.lineBreakMode=0;
        
        
        [self addSubview:via];
        [self addSubview:nameLabel];
        [self addSubview:tweetDate];
        [self addSubview:tweetLabel];
        [self addSubview:profileImage];
    }
    return self;
}

- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *activity = self.detailItem;
        
        NSString *text = [activity objectForKey:@"content"];
        NSString *author = [activity objectForKey:@"author"];
        NSString *service = [activity objectForKey:@"service"];
        
        nameLabel.text = author;
        tweetLabel.text = text;
        via.text = [NSString stringWithFormat:@"via %@",service];
        
        NSString * timeStampString =[activity objectForKey:@"dateTime"];
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"EEEE, MMM dd, yyyy @HH:mm:ss"];
        NSString *_date=[_formatter stringFromDate:date];
        tweetDate.text = [NSString stringWithFormat:@"%@", _date];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = [activity objectForKey:@"imageURL"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [profileImage.layer setMasksToBounds:YES];
                profileImage.layer.cornerRadius = 8;
                profileImage.image = [UIImage imageWithData:data];
            });
        });
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
