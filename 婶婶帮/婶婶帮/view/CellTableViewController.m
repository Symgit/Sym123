//
//  CellTableViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/9.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "CellTableViewController.h"
#define scwidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define scHeight CGRectGetHeight([UIScreen mainScreen].bounds))
@interface CellTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * imageView;
    NSMutableArray * dataSource;
    NSMutableArray * arr;
    UILabel * sectionLabel;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *stateArray;

@end

@implementation CellTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    //NSArray * arr1 = @[@"1",@"2",@"3",@"4",@"5"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [dataSource addObjectsFromArray:self.titleArr];
    [self barBtn];
    [self tableV];
    NSLog(@"%@",dataSource);
    // Do any additional setup after loading the view.
}
- (void)barBtn{
    UIView * naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, scwidth, 64)];
    [self.view addSubview:naView];
    UIImageView * imageView1 = [[UIImageView alloc]init];
    [imageView1 setImage:[UIImage imageNamed:@"1"]];
    [imageView1 setFrame:CGRectMake(0, 63, scwidth, 64)];
    [naView addSubview:imageView1];
    //导航条左侧的返回按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(5, 20, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(returnBtn) forControlEvents:UIControlEventTouchUpInside];
    [naView addSubview:btn];
    //导航条标题
    CGFloat titleX = (scwidth-76)/2;
    UILabel * titleLabel = [[UILabel alloc]init];
    [titleLabel setFrame:CGRectMake(titleX, 18, 76, 40)];
    //titleLabel.center = naView.center;
    [titleLabel setText:@"使用帮助"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [naView addSubview:titleLabel];
}
//导航条返回按钮的点击事件
- (void)returnBtn{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)tableV{
    //arr = @[@"成功近在眼前，但是往往最容易抓不住的就是近在眼前的东西，因为容易得到的不懂得珍惜，往往得不到的却拼命的想要得到，人还真是贱啊",@"成功近在眼前，但是往往最容易抓不住的就是近在眼前的东西，因为容易得到的不懂得珍惜，往往得不到的却拼命的想要得到，人还真是贱啊",@"成功近在眼前，但是往往最容易抓不住的就是近在眼前的东西，因为容易得到的不懂得珍惜，往往得不到的却拼命的想要得到，人还真是贱啊",@"成功近在眼前，但是往往最容易抓不住的就是近在眼前的东西，因为容易得到的不懂得珍惜，往往得不到的却拼命的想要得到，人还真是贱啊",@"成功近在眼前，但是往往最容易抓不住的就是近在眼前的东西，因为容易得到的不懂得珍惜，往往得不到的却拼命的想要得到，人还真是贱"];
    arr = [NSMutableArray array];
    [arr addObjectsFromArray:self.sectionArr];
    _stateArray = [NSMutableArray array];
    
    for (int i = 0; i < arr.count; i++)
    {
        //所有的分区都是闭合
        [_stateArray addObject:@"0"];
    }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, scwidth, CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //[self.tableView setBackgroundColor:[UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1]];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    //self.tableView = tableView;
    
    //NSMutableArray * test_array = [NSMutableArray array];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        //NSArray *array = [arr objectAtIndex:section];
        return 1;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    [cell.textLabel setAlpha:0.5];
    [cell setBackgroundColor:[UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1]];
    [cell.textLabel setNumberOfLines:3];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
//[_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 1] withRowAnimation:UITableViewRowAnimationAutomatic];

- (NSString * )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return dataSource[section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, scwidth, 45)];
//    [btn setTitle:dataSource[section] forState:UIControlStateNormal];
    [btn setBackgroundColor: [UIColor whiteColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, scwidth-150)];
    UILabel * la = [[UILabel alloc]init];
    [la setText:dataSource[section]];
    [la setFrame:CGRectMake(10, 0, scwidth, 45)];
    [la setTextAlignment:NSTextAlignmentLeft];
    [btn addSubview:la];
    //[btn setBackgroundColor:[UIColor redColor]];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, btn.frame.size.height-1, btn.frame.size.width-10, 1)];
    [line setImage:[UIImage imageNamed:@"1"]];
    [sectionLabel setFrame:CGRectMake(0, 0, scwidth, 45)];
    [sectionLabel setNumberOfLines:2];
    [sectionLabel setAlpha:0.4];
    [sectionLabel setFont:[UIFont systemFontOfSize:15]];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (44-6)/2, 10, 6)];
    if ([_stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"3"];
    }else if ([_stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"2"];
    }
    [btn addSubview:_imgView];
    [btn addSubview:sectionLabel];
    [btn addSubview:line];
    [btn setTag:section];
    [btn addTarget:self action:@selector(sectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)sectionBtn:(UIButton *)btn{
    //isyer = YES;
    //NSLog(@"%@",);
    if ([_stateArray[btn.tag] isEqualToString:@"1"]){
        //修改
        [_stateArray replaceObjectAtIndex:btn.tag withObject:@"0"];
    }else{
        [_stateArray replaceObjectAtIndex:btn.tag withObject:@"1"];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
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
