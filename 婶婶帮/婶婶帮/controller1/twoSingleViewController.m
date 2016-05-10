//
//  twoSingleViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/13.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "twoSingleViewController.h"
#import "SingleAppointment.h"
@interface twoSingleViewController ()

@end

@implementation twoSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SingleAppointment * single = [[SingleAppointment alloc]init];
    //[single cellArrAention:@[]];
    //single.arrSen = @[@"地点",@"时间"];
    single.str = @"地点";
    single.senStr = @"时间";
    // Do any additional setup after loading the view.
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
