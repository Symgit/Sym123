//
//  AddBtn.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/27.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "AddBtn.h"

@implementation AddBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        sum = 2.0;
        NSArray * arr = @[@"-",@"2",@"+"];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(i * 44, 3, 44, 44)];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setBorderWidth:1];
            [btn.layer setBorderColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor];
            [btn setTag:i+1];
            if (btn.tag != 2) {
                btn.titleLabel.font = [UIFont systemFontOfSize:44];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(1, 5, 5, 5)];
            }else{
                [btn setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
            }
            [btn setTitleColor:[UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}
- (void)addBtn:(UIButton *)btn{
    UIButton * button2 = (UIButton *)[self viewWithTag:2];
    if (sum < 2) {
        sum = 2;
    }
    if (sum > 6) {
        sum = 6;
    }
    if (btn.tag == 3) {
        sum+= 0.5;
        if (sum <= 6) {
            [button2 setTitle:[NSString stringWithFormat:@"%.1f",sum] forState:UIControlStateNormal];
            self.BtnNum = sum;
        }
    }
    if(btn.tag == 1){
        sum -= 0.5;
        if (sum>=2) {
            [button2 setTitle:[NSString stringWithFormat:@"%.1f",sum] forState:UIControlStateNormal];
            self.BtnNum = sum;
        }
    }
    NSLog(@"self.BtnNum= %f",self.BtnNum);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
