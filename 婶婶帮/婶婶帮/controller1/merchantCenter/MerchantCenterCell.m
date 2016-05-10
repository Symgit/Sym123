//
//  MerchantCenterCell.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/4.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "MerchantCenterCell.h"
#import <CoreText/CoreText.h>
@implementation MerchantCenterCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 20, CGRectGetWidth(frame) - 60, CGRectGetWidth(frame) - 60)];
        //[self.imageView setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.imageView];
        CGFloat label_Y = self.imageView.frame.origin.y + self.imageView.frame.size.height + 10;
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, label_Y, CGRectGetWidth(frame), CGRectGetHeight(frame) - label_Y-10)];
        [self.label setTextAlignment:NSTextAlignmentCenter];
//        [self.label setFont:[UIFont fontWithName:@"Gill Sans" size:18]];
//        NSArray *familyNames = [UIFont familyNames];
//        NSLog(@"familyNames= %@",familyNames);
        [self addSubview:self.label];
    }
    return self;
}


@end
