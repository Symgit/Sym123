//
//  TimeScrollerViewController.h
//  日期滚动
//
//  Created by 孙月明 on 16/4/23.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeScrollerViewController : UIViewController
/*
获取当前年数
**/
- (NSInteger)isYear;

/*
获取当前月份
**/
- (NSInteger)isMonDay;

/*
获取天是多少号
**/
- (NSInteger)isDay;

/*
获取当月有多少天
**/
- (NSInteger)numberOfDaysInMonth;

/*
获取今天是星期几
**/
- (NSInteger)isWeek;

/*
滚动的时间器
**/
- (void)UIScrollView:(UIView *)view;
@end
