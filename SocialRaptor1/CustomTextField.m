//
//  CustomTextField.m
//  SocialRaptor1
//
//  Created by Rachael Koestartyo on 11/7/12.
//  Copyright (c) 2012 CS480. All rights reserved.
//

#import "CustomTextField.h"


@implementation CustomTextField
- (void)drawRect:(CGRect)rect{
    UIImage *textFieldBackground=[[UIImage imageNamed:@"text_field_yellow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 5, 15, 5)];
    [textFieldBackground drawInRect:self.bounds];
}
@end