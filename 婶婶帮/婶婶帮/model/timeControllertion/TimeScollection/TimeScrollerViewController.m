//
//  TimeScrollerViewController.m
//  日期滚动
//
//  Created by 孙月明 on 16/4/23.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "TimeScrollerViewController.h"
@interface TimeScrollerViewController ()<UIScrollViewDelegate>
{
    UIButton * timeBtn;
    UIButton * timeLabel;
    UIImageView * XiaimageView;
}
@property (nonatomic,strong)UIScrollView * scroll;

@end

@implementation TimeScrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self UIScrollView:self.view];
    // Do any additional setup after loading the view, typically from a nib.
}
//年
- (NSInteger)isYear{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year = [comps year];
    return year;
}
//月
- (NSInteger)isMonDay{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitMonth;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger month = [comps month];
    return month;
}
//获取这个月的天数
- (NSInteger)numberOfDaysInMonth{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    //NSUInteger numberOfDaysInMonth = range.length;
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}
//获取今天是几号
- (NSInteger)isDay{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitDay;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger day = [comps day];
    return day;
}
//星期
- (NSInteger)isWeek{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    return week;
}
- (void)UIScrollView:(UIView *)view{
    _scroll = [[UIScrollView alloc]init];
    [_scroll setFrame:CGRectMake(25, 0, CGRectGetWidth(self.view.bounds)-50, 60)];
    _scroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)+180, 45);
    _scroll.contentOffset = CGPointMake(0, 0);
    _scroll.bounces = NO;
    _scroll.userInteractionEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //开启分页效果
    _scroll.pagingEnabled = NO;
    [self scrollView:_scroll];
    [view addSubview:_scroll];
}
- (void)scrollView:(UIView *)view{
    NSArray * arrWeek = [NSArray arrayWithObjects:@"星期日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    NSInteger weekFirst = [self isWeek]-1;
    NSLog(@"weekweek= %ld",weekFirst);
   
    NSMutableArray * weekarr = [NSMutableArray array];
    NSMutableArray * weekMonth = [NSMutableArray array];
    NSArray * ar = [NSArray arrayWithObjects:@"今天",@"明天", nil];
    [weekarr addObjectsFromArray:ar];
    if (weekFirst +1 > 6) {
        for (NSInteger i = 1; i < 6; i++) {
            [weekarr addObject:arrWeek[i]];
        }
    }else if(weekFirst +1 == 6){
        for (NSInteger i = 0; i < weekFirst; i++) {
            [weekarr addObject:arrWeek[i]];
        }
    }else{
        for (NSInteger i = weekFirst + 2; i <= 6; i++) {
            [weekarr addObject:arrWeek[i]];
        }
        NSLog(@"weekarr= %@",weekarr);
    }
    if (weekarr.count < 7) {
        for (NSInteger i = 0; i < [self isWeek]; i++) {
            [weekarr addObject:arrWeek[i]];
        }
    }
    //获取这个星期所对应的天数
    NSInteger surplusDay = 0;
    if ([self isDay]+7>[self numberOfDaysInMonth]) {
        surplusDay = [self isDay] + 7 - [self numberOfDaysInMonth];
    }
    if ([self isDay] == 1 && [self isDay]<= [self numberOfDaysInMonth]-7 ) {
        for (NSInteger i = [self isDay]; i < [self isDay]+7; i++) {
            NSInteger  sum = 0;
            sum = i;
            weekMonth = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"%ld月%ld日",[self isMonDay],sum]];
        }
    }
    
    if (weekMonth.count < 8) {
        for (NSInteger i = [self isDay]; i <=[self numberOfDaysInMonth]; i++) {
            NSInteger  sum = 0;
            sum = i;
            if (weekMonth == 0) {
                weekMonth = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"%ld月%ld日",[self isMonDay],sum]];
            }else{
                [weekMonth addObject:[NSString stringWithFormat:@"0%ld月%ld日",[self isMonDay],sum]];
            }
        }
        NSLog(@"weekMonth.count= %ld",weekMonth.count);
        NSLog(@"numberOfDaysInMonth= %ld",surplusDay);
        for (NSInteger i = 1; i <= surplusDay; i++) {
            [weekMonth addObject:[NSString stringWithFormat:@"0%ld月0%ld日",[self isMonDay]+1,i]];
        }
    }
    for (NSInteger i = 0; i < 7; i++) {
        timeBtn  = [[UIButton alloc]init];
        [timeBtn setFrame:CGRectMake(i*80, 0, 80, 35)];
        [timeBtn setTitle:weekarr[i] forState:UIControlStateNormal];
        [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        timeBtn.tag = i+1;
        if (timeBtn.tag == 1) {
            timeBtn.selected = YES;
        }
        [timeBtn setUserInteractionEnabled:YES];
        [timeBtn setTitleColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1] forState:UIControlStateSelected];
        [timeBtn addTarget:self action:@selector(TimeBtna:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:timeBtn];
        NSLog(@"%ld",weekMonth.count);
        timeLabel = [[UIButton alloc]initWithFrame:CGRectMake(i*80, 30, 80, 15)];
        timeLabel.tag = i+10;
        [timeLabel setTitle:weekMonth[i] forState:UIControlStateNormal];
        [timeLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [timeLabel setTitleColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1] forState:UIControlStateSelected];
        timeLabel.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [timeLabel setAlpha:0.4];
        if (timeLabel.tag == 10) {
            timeLabel.selected = YES;
        }
        [view addSubview:timeLabel];
    }
}
- (void)TimeBtna:(UIButton *)btn{
    NSArray * a = [_scroll subviews];
    for (NSInteger i = 0; i < a.count; i++) {
        if (i%2==/* DISABLES CODE */ (0)) {
            UIButton * b = a[i];
            if (btn == b) {
                btn.selected = YES;
            }else{
                b.selected = NO;
            }
        }else{
            UIButton * l = a[i];
            if (l.tag == btn.tag+9) {
                l.selected = YES;
            }else{
                l.selected = NO;
            }
        }
        
    }
//    for (NSInteger i = 0; i < a.count; i++) {
//        
//        
//    }
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
 NSInteger weekDay = [self isMonDay];
 NSInteger oneWeek = 0;
 NSInteger twoWeek = 0;
 NSInteger threeWeek = 0;
 NSInteger fourWeek = 0;
 NSInteger faveWeek = 0;
 if (weekFirst == 5) {
 oneWeek = 0;twoWeek= 1;threeWeek= 2;fourWeek= 3;faveWeek= 4;
 }else if (weekFirst == 0){
 oneWeek = 2;twoWeek= 3;threeWeek= 4;fourWeek= 5;faveWeek= 6;
 }else if (weekFirst == 1){
 oneWeek = 3;twoWeek= 4;threeWeek= 5;fourWeek= 6;faveWeek= 0;
 }else if (weekFirst == 2){
 oneWeek = 4;twoWeek= 5;threeWeek= 6;fourWeek= 0;faveWeek= 1;
 }else if (weekFirst == 3){
 oneWeek = 5;twoWeek= 6;threeWeek= 0;fourWeek= 1;faveWeek= 2;
 }else if(weekFirst == 4){
 oneWeek = 6;twoWeek= 0;threeWeek= 1;fourWeek= 2;faveWeek= 3;
 }else{
 oneWeek = 1;twoWeek= 2;threeWeek= 3;fourWeek= 4;faveWeek= 5;
 }
*/

@end
