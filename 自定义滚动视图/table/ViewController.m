//
//  ViewController.m
//  table
//
//  Created by 孙月明 on 16/6/18.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "ViewController.h"
#import "ScollectionView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * imageArr = @[@"1",@"2",@"3",@"4",@"5"];
    ScollectionView * sc = [[ScollectionView alloc]initWithFrame:self.view.frame andImageArr:imageArr rollingTimeMode:rollingTimeModeIsOne imageIsBlock:^(NSInteger index) {
        NSLog(@"点击了第%ld张图片",index);
    }];
    [sc setCurrtionTime:3.0];
    //如果rollingTimeMode等于rollingTimeModeIsTwo在实现[sc setTime:3.0f];//每张图片停留的时间
    
    [sc startAnimation];
    [self.view addSubview:sc];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)tabv{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
