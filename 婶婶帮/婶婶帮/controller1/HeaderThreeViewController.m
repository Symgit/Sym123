//
//  HeaderThreeViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/13.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "HeaderThreeViewController.h"
#define Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define Height CGRectGetHeight([UIScreen mainScreen].bounds))
@interface HeaderThreeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * phoneLabel;
    UILabel * FenLabel;
    UILabel * moneyLabel;
}
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation HeaderThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
    [self tableV];
    [self UIViewBtn];
    // Do any additional setup after loading the view.
}
- (void)UIViewBtn{
    UIView * naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 64)];
    [naView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:naView];
    UIImageView * imageView1 = [[UIImageView alloc]init];
    [imageView1 setImage:[UIImage imageNamed:@"1"]];
    [imageView1 setFrame:CGRectMake(0, 63, Width, 1)];
    [naView addSubview:imageView1];
    //导航条左侧的返回按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(5, 20, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(returnBtn) forControlEvents:UIControlEventTouchUpInside];
    [naView addSubview:btn];
    //导航条标题
    CGFloat titleX = (Width-76)/2;
    UILabel * titleLabel = [[UILabel alloc]init];
    [titleLabel setFrame:CGRectMake(titleX, 18, 76, 40)];
    //titleLabel.center = naView.center;
    [titleLabel setText:@"我的信息"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [naView addSubview:titleLabel];
//退出登录按钮
    UIButton * noEnderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noEnderBtn setFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds)-44, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    [noEnderBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [noEnderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [noEnderBtn setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
    [noEnderBtn addTarget:self action:@selector(noEnderBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noEnderBtn];
}
- (void)returnBtn{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)noEnderBtn1{
    
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 84, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-108) style:UITableViewStylePlain];
    [tableView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    [self cellLabel:cell.contentView index:indexPath.item];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)cellLabel:(UIView *)view index:(NSInteger)integer{
    NSArray * arr = @[@"手机号:",@"积 分:",@"余 额:"];
    NSLog(@"integer= %ld",integer);
    UILabel * label = [[UILabel alloc]init];
    [label setFrame:CGRectMake(15, 0, 65, 45)];
    [label setText:arr[integer]];
    [view addSubview:label];
    phoneLabel = [[UILabel alloc]init];
    FenLabel = [[UILabel alloc]init];
    moneyLabel = [[UILabel alloc]init];
    CGRect rect = CGRectMake(CGRectGetMaxX(label.frame)+15, 0, 170, 45);
    if (integer == 0) {
        [phoneLabel setFrame:rect];
        [phoneLabel setText:@"13612179590"];
        [view addSubview:phoneLabel];
    }else if(integer == 1){
        [FenLabel setFrame:rect];
        [FenLabel setText:@"0"];
        [view addSubview:FenLabel];
    }else{
        [moneyLabel setFrame:rect];
        [moneyLabel setText:@"0"];
        [view addSubview:moneyLabel];
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
