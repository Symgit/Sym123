//
//  navBarView.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/5.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "navBarView.h"
#import "Header.h"
@implementation navBarView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * imageView1 = [[UIImageView alloc]init];
        [imageView1 setImage:[UIImage imageNamed:@"1"]];
        [imageView1 setFrame:CGRectMake(0, 63, W_with, 1)];
        [self addSubview:imageView1];
        //导航条左侧的返回按钮
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(5, 20, 40, 40)];
        [btn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(returnBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        //导航条标题
        CGFloat titleX = (W_with-76)/2;
        UILabel * titleLabel = [[UILabel alloc]init];
        [titleLabel setFrame:CGRectMake(titleX, 18, 76, 40)];
        //titleLabel.center = naView.center;
        [titleLabel setText:@"个人中心"];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:titleLabel];
    }
    return self;
}
- (void)returnBtn{
    [_delegate dismissViewControllerAnimated:YES completion:^{
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
