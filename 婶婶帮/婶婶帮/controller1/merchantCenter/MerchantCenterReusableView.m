//
//  MerchantCenterReusableView.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/5.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "MerchantCenterReusableView.h"

@implementation MerchantCenterReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.center.x-70, self.center.y -100, 140, 140)];
        //self.imageView.center = self.center;
        [_imageView setImage:[UIImage imageNamed:@"4"]];
        [_imageView setUserInteractionEnabled:YES];
        [_imageView setAlpha:0];
        [_imageView.layer setCornerRadius:70];
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.center.x-120, _imageView.center.y+110, 240, 35)];
        _label.font = [UIFont boldSystemFontOfSize:22];
        [_label setText:@""];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setAlpha:0];
        //[_label setBackgroundColor:[UIColor redColor]];
        [self addSubview:_label];
    }
    return self;
}
@end
