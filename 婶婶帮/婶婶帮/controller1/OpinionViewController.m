//
//  OpinionViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/7.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "OpinionViewController.h"
#define Width CGRectGetWidth([UIScreen mainScreen].bounds)
@interface OpinionViewController ()<UITextViewDelegate>
{
    UITextView * _textView;
    UILabel * _placeHolderLabel;
}
@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"意见反馈"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self opinionUI];
    // Do any additional setup after loading the view.
}
- (void)opinionUI{
//提交按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 45, 45)];
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:btnItem];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    
//背景颜色
    UIView * backView = [[UIView alloc]init];
    [backView setFrame:[UIScreen mainScreen].bounds];
    [backView setBackgroundColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:0.5]];
    [self.view addSubview:backView];
//意见反馈
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 84, Width, 100)];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _textView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _placeHolderLabel = [[UILabel alloc]init];
    [_placeHolderLabel setText:@"请描述你的意见或建议，我们会尽快帮你解决..."];
    [_placeHolderLabel setFrame:CGRectMake(5, 0, Width, 30)];
    [_placeHolderLabel setFont:[UIFont systemFontOfSize:13]];
    [_placeHolderLabel setTextColor:[UIColor blackColor]];
    _placeHolderLabel.alpha = 0.2;
    [_textView addSubview:_placeHolderLabel];
    [backView addSubview:_textView];
}
- (void)rightBtn{
    
}
- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [_placeHolderLabel setText:@"请描述你的意见或建议，我们会尽快帮你解决..."];
    }else{
        [_placeHolderLabel setText:@""];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
