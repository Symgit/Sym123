//
//  CycleReservation.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/11.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "CycleReservation.h"
//#import "AppointmentTableViewCell.h"dd
#import "timeScViewController.h"

#define scwidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define scHeight CGRectGetHeight([UIScreen mainScreen].bounds))

@interface CycleReservation ()<UITableViewDelegate ,UITableViewDataSource>{
    NSMutableArray * dataSource;
    timeScViewController * timea;
}
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation CycleReservation
- (void)viewWillAppear:(BOOL)animated{
    //[self.tableView reloadData];
    [self tableV];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, scwidth, CGRectGetMaxY([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataSource.count == 0) {
        return 20;
    }
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [self cellViewSection:cell.contentView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    timea = [[timeScViewController alloc]init];
    [self.navigationController pushViewController:timea animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 46.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    [view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 46)];
    [view setBackgroundColor:[UIColor colorWithRed:255/255.0 green:232/255.0 blue:148/255.0 alpha:0.1]];
    UIImageView * imageview = [[UIImageView alloc]init];
    [imageview setFrame:CGRectMake(15, 8, 30, 30)];
    [imageview setImage:[UIImage imageNamed:@"weizhi"]];
    [view addSubview:imageview];
    UILabel * textLabel = [[UILabel alloc]init];
    [textLabel setFrame:CGRectMake(50, 3, 300, 40)];
    [textLabel setText:@"津门公寓B座"];
    [view addSubview:textLabel];
    UIImageView * rightImageView = [[UIImageView alloc]init];
    [rightImageView setFrame:CGRectMake(CGRectGetWidth(self.view.bounds)-40, 8, 30, 30)];
    [rightImageView setImage:[UIImage imageNamed:@"right"]];
    [view addSubview:rightImageView];
    UIImageView * imageView1 = [[UIImageView alloc]init];
    [imageView1 setFrame:CGRectMake(0, view.bounds.size.height-1, CGRectGetWidth(self.view.bounds), 1)];
    [imageView1 setImage:[UIImage imageNamed:@"1"]];
    [view addSubview:imageView1];
    UIImageView * imageView2 = [[UIImageView alloc]init];
    [imageView2 setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    [imageView2 setImage:[UIImage imageNamed:@"1"]];
    [view addSubview:imageView2];
    return view;
}
- (void)cellViewSection:(UIView *)view {
//头像
    UIImageView * imageView = [[UIImageView alloc]init
    ];
    [imageView setFrame:CGRectMake(15, 7, 100, 100)];
    [imageView.layer setCornerRadius:50];
    //[imageView setBackgroundColor:[UIColor redColor]];
    [imageView setImage:[UIImage imageNamed:@"heardOne"]];
    [view addSubview:imageView];
    
//人名
    UILabel * nameLabel = [[UILabel alloc]init];
    [nameLabel setText:@"张无忌"];
    [nameLabel setTextColor:[UIColor blackColor]];
    //[nameLabel setAlpha:0.3];
    [nameLabel setFont:[UIFont systemFontOfSize:17]];
    [nameLabel setFrame:CGRectMake(imageView.frame.size.width+30, 7, 65, 35)];
    //[nameLabel setBackgroundColor:[UIColor redColor]];
    [view addSubview:nameLabel];
    
//服务次数
    UILabel * Fwlabel = [[UILabel alloc]init];
    CGFloat Fx = imageView.frame.size.width+30+65+20;
    [Fwlabel setFrame:CGRectMake(Fx, 7, 120, 35)];
    [Fwlabel setTextColor:[UIColor blackColor]];
    [Fwlabel setText:@"攻击指数"];
    [Fwlabel setAlpha:0.3];
    [Fwlabel setTextAlignment:NSTextAlignmentCenter];
    [Fwlabel setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:Fwlabel];
    
//分数
    UILabel * Fslabel = [[UILabel alloc]init];
    [Fslabel setFrame:CGRectMake(Fx, 114/2-17, 120, 34)];
    [Fslabel setTextColor:[UIColor blackColor]];
    [Fslabel setText:@"5分"];
    [Fslabel setAlpha:0.3];
    [Fslabel setTextAlignment:NSTextAlignmentCenter];
    [Fslabel setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:Fslabel];
//星星数目
    for (NSInteger i = 0; i < 5; i++) {
        //UILabel * starlabel = [[UILabel alloc]init];
        UIImageView * starImageView = [[UIImageView alloc]init];
        [starImageView setFrame:CGRectMake(nameLabel.frame.origin.x+i*20, 114/2-10, 20, 20)];
        [starImageView setImage:[UIImage imageNamed:@"star"]];
        [view addSubview:starImageView];
    }
    
//选择按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(CGRectGetWidth(self.view.bounds)- 70, 114 - 47, 60, 25)];
    [btn setTitle:@"选择" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setTitleColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    [btn.layer setBorderWidth:1];
    [btn.layer setBorderColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1].CGColor];
    [btn.layer setCornerRadius:4];
    [btn addTarget:self action:@selector(XzBtn:) forControlEvents:UIControlEventTouchUpInside];
    //[btn setBackgroundColor:[UIColor redColor]];
    [view addSubview:btn];
}
- (void)XzBtn:(UIButton *)btn{
    
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
