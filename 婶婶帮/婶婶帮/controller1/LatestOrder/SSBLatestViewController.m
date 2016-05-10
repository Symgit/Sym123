//
//  SSBLatestViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/6.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "SSBLatestViewController.h"
#import "SSBLatesDetailViewController.h"
#import "Header.h"
#define cellHeight 80


@interface SSBLatestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation SSBLatestViewController
- (instancetype)initWithTitle:(NSString *)title{
    if (self == [super init]) {
        [self setTitle:title];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    [self tableV];
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W_with, H_height-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.imageView.image = [UIImage imageNamed:@"4"];
   
    [self cellSectionIsView:cell.contentView indexPath:indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}
- (void)cellSectionIsView:(UIView *)view indexPath:(NSInteger)index{
//最新订单的头像
    UIImageView * HeaderImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, cellHeight-10, cellHeight-10)];
    [HeaderImageView setImage:[UIImage imageNamed:@"4"]];
    [view addSubview:HeaderImageView];
    
//姓名电话
    CGFloat label_x = HeaderImageView.frame.origin.x + HeaderImageView.frame.size.height + 5;
    CGFloat label_y = 10;
    CGFloat la_W = cellHeight/2-10;
    NSArray * arr = @[@"姓名：",@"电话："];
    for (NSInteger i = 0; i < 2; i++) {
        UILabel * label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(label_x, label_y +la_W * i , 300, la_W)];
        label.tag = i+1;
        //设置字体大小
        CGFloat lab_W = 0;
        if (label.tag == 1) {
            [label setText:[NSString stringWithFormat:@"%@%@",arr[i],@"玉皇大帝"]];
            lab_W = 18;
        }else{
            [label setText:[NSString stringWithFormat:@"%@%@",arr[i],@"99999999999"]];
            label.alpha = 0.6;
            lab_W = 16;
        }
        label.font = [UIFont systemFontOfSize:lab_W];
        [view addSubview:label];
    }
//查看详情
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"查看详情" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(W_with-80, cellHeight/2-20, 75, 40)];
    [btn addTarget:self action:@selector(SSBDetail) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}
- (void)SSBDetail{
    SSBLatesDetailViewController * ssb = [[SSBLatesDetailViewController alloc]init];
    [self.navigationController pushViewController:ssb animated:YES];
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
