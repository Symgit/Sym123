//
//  SSBLatesDetailViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/7.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "SSBLatesDetailViewController.h"
#import "Header.h"

#define cellFootHeight 60

@interface SSBLatesDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    //NSArray * dataArr;
}
@property (nonatomic,strong) NSArray * dataArr;//单元格标题
@property (nonatomic,strong) NSMutableArray * dataSource;//数据源***单元格内容
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation SSBLatesDetailViewController
- (NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = @[@"姓名：",
                    @"电话：",
                    @"地址：",
                    @"服务时间：",
                    @"时间段：",
                    @"预计时长：",
                    @"服务项目：",];
    }
    return _dataArr;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        NSArray * arr = @[@"玉皇大帝",
                          @"999999999999",
                          @"上苍18号第九重天凌霄宝殿凌霄宝座",
                          @"天界14世纪205年",
                          @"1天--100天",
                          @"人间100年",
                          @"日间维护"];
        [_dataSource addObjectsFromArray:arr];
        //_dataSource = [NSMutableArray ];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"订单详情"];
    [self tableV];
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W_with, H_height-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [UIView new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =[self dataArr][indexPath.item];
    [self cellSectionIsView:cell.contentView indexPath:indexPath.item];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W_with, cellFootHeight)];
    UIButton * FootBtn = [[UIButton alloc]init];
    [FootBtn setFrame:CGRectMake(0, 0, W_with-75, 44)];
    [FootBtn.layer setMasksToBounds:YES];
    [FootBtn.layer setCornerRadius:22];
    [FootBtn setTitle:@"接单" forState:UIControlStateNormal];
    FootBtn.center = footView.center;
    [FootBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FootBtn setBackgroundColor:RGBColol(253, 209, 62, 1)];
    [FootBtn addTarget:self action:@selector(SSBDetail) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:FootBtn];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return cellFootHeight;
}
- (void)cellSectionIsView:(UIView *)view indexPath:(NSInteger)index{
    UILabel * label = [[UILabel alloc]init];
    [label setFrame:CGRectMake(W_with/3-20, 3, W_with/3*2, 36)];
    [label setText:[self dataSource][index]];
    [view addSubview:label];
}
- (void)SSBDetail{
    
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
