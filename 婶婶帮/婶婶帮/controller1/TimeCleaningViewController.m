//
//  TimeCleaningViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/11.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "TimeCleaningViewController.h"
#import "WJSegmentMenuVc.h"
#import "SingleAppointment.h"
#import "BiweeklyAppointment.h"
#import "CycleReservation.h"
#import "twoSingleViewController.h"
@interface TimeCleaningViewController ()

@end

@implementation TimeCleaningViewController
- (void)viewWillAppear:(BOOL)animated{
    WJSegmentMenuVc *segmentMenuVc = [[WJSegmentMenuVc alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    [self.view addSubview:segmentMenuVc];
    segmentMenuVc.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    segmentMenuVc.titleFont = [UIFont systemFontOfSize:13];
    segmentMenuVc.unlSelectedColor = [UIColor darkGrayColor];
    segmentMenuVc.selectedColor = [UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1];
    segmentMenuVc.MenuVcSlideType = WJSegmentMenuVcSlideTypeSlide;
    segmentMenuVc.SlideColor = [UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1];
    segmentMenuVc.advanceLoadNextVc = YES;
    NSArray *titles =@[@"单次预约",@"双周预约",@"周期预约"];
    segmentMenuVc.integer = 3;
    segmentMenuVc.vcInteger = self.intager;
    twoSingleViewController * two = [[twoSingleViewController alloc]init];
    SingleAppointment * sing = [[SingleAppointment alloc]init];
    //BiweeklyAppointment * biweek = [[BiweeklyAppointment alloc]init];
    CycleReservation * cyc = [[CycleReservation alloc]init];
    NSArray * vcArr = @[sing,two,cyc];
    [segmentMenuVc addSubVc:vcArr subTitles:titles];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"预约保洁"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//导航条按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 75, 45)];
    [btn setTitle:@"服务介绍" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BarBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1;
    [btn setTitleColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"retarnLeft"] forState:UIControlStateNormal];
    leftBtn.tag = 2;
    [leftBtn addTarget:self action:@selector(BarBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [self.navigationItem setRightBarButtonItem:barItem];
    [self.navigationItem setLeftBarButtonItem:bar];
    // Do any additional setup after loading the view.
}
- (void)BarBtn:(UIButton *)btn{
    if (btn.tag == 1) {
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
