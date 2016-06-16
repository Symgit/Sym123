//
//  ViewController.m
//  界面跳转动画
//
//  Created by 孙月明 on 16/6/1.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
@interface ViewController ()

- (IBAction)addBtn:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]]];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 45, 45)];
    btn.center = self.view.center;
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBtn:(UIButton *)sender {
    OneViewController * vc = [OneViewController new];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
