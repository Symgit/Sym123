//
//  BiweeklyAppointment.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/11.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "BiweeklyAppointment.h"
#define scwidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define scHeight CGRectGetHeight([UIScreen mainScreen].bounds))
@interface BiweeklyAppointment ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation BiweeklyAppointment

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self tableV];
    // Do any additional setup after loading the view.
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, scwidth, CGRectGetHeight([UIScreen mainScreen].bounds)-44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //NSMutableArray * test_array = [NSMutableArray array];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    [self cell:cell.contentView andHeight:45 index:indexPath.item];
    //cell.textLabel.text = self.data_array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 2) {
        //[tableView.tableFooterView addSubview:view];
        return @" ";
    }
    return @" ";
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view1 = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [view1 setUserInteractionEnabled:YES];
    [view1 setBackgroundColor:[UIColor whiteColor]];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake((scwidth)/2-130, 27, 260, 46)];
    [btn setTitle:@"25-50元/小时(两小时起做)       >" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn.layer setCornerRadius:23];
    //btn.center = view1.center;
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(moneyBtn) forControlEvents:UIControlEventTouchUpInside];
    UIView * subView = [[UIView alloc]init];
    [subView setFrame:CGRectMake(0, 0, CGRectGetWidth(btn.frame)+2, CGRectGetHeight(btn.frame)+2)];
    [subView setUserInteractionEnabled:YES];
    subView.center = btn.center;
    [subView.layer setCornerRadius:24];
    [subView setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
    [view1 addSubview:subView];
    [view1 addSubview:btn];
    //view = self.tableView.tableHeaderView;
    return view1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [view setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, scwidth, 1)];
    [label1 setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:0.5]];
    [view addSubview:label1];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
//单元格头标题按钮
- (void)moneyBtn{
    NSLog(@"成功");
}
//为cell上面添加内容
- (void)cell:(UIView *)view andHeight:(CGFloat)height index:(NSInteger)integer{
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(15, (height-20)/2, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"time"]];
    [view addSubview:imageView];
    UILabel * label = [[UILabel alloc]init];
    NSArray * arr = @[@"请选择服务地点",@"请选择服务时间"];
    [label setText:arr[integer]];
    [label setTextColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]];
    [label setFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+15, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-85, height)];
    UIImageView * cellImage = [[UIImageView alloc]init];
    CGFloat cellImageX = label.frame.size.width+imageView.frame.size.width + 25;
    [cellImage setFrame:CGRectMake(cellImageX, (height-20)/2, 20, 20)];
    [cellImage setImage:[UIImage imageNamed:@"right"]];
    [view addSubview:cellImage];
    [view addSubview:label];
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
