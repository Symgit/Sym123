//
//  UseHelpViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/9.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "UseHelpViewController.h"
#import "CellTableViewController.h"
#import "navBarView.h"
#define Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define Height CGRectGetHeight([UIScreen mainScreen].bounds))
#define SectionHeight CGRectGetHeight([UIScreen mainScreen].bounds) - 270
@interface UseHelpViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView * imageView;
    NSMutableArray * dataSource;
    NSArray * arr;
    UILabel * sectionLabel;
    NSArray * labelArr;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *stateArray;
@end

@implementation UseHelpViewController
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self useHelpBarBtn];
    navBarView * nav = [[navBarView alloc]initWithFrame:CGRectMake(0, 0, Width, 64)];
    nav.delegate = self;
    [self.view addSubview:nav];
    [self tableV];
    //[cell table:self.view cellSection:@[@"1",@"2",@"3"] andSource:@[@"1",@"2",@"3"]];
    // Do any additional setup after loading the view.
}
//自定义导航条
- (void)useHelpBarBtn{
    UIView * naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 64)];
    //[self.view addSubview:naView];
    UIImageView * imageView1 = [[UIImageView alloc]init];
    [imageView1 setImage:[UIImage imageNamed:@"1"]];
    [imageView1 setFrame:CGRectMake(0, 63, Width, 64)];
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
    [titleLabel setText:@"使用帮助"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [naView addSubview:titleLabel];
    
//自定义工具条按钮
    UIButton * Zaibtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Zaibtn setFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-44, Width/2, 44)];
    [Zaibtn setTitle:@"在线客服" forState:UIControlStateNormal];
    [Zaibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Zaibtn.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.3 });
    Zaibtn.layer.borderColor = colorref;
    [btn.layer setBorderColor:colorref];
    [self.view addSubview:Zaibtn];
    UIButton * Zaibtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Zaibtn1 setFrame:CGRectMake(Width/2, CGRectGetHeight([UIScreen mainScreen].bounds)-44, Width/2, 44)];
    [Zaibtn1 setTitle:@"电话客服" forState:UIControlStateNormal];
    [Zaibtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Zaibtn1.layer.borderWidth = 1;
    Zaibtn1.layer.borderColor = colorref;
    [self.view addSubview:Zaibtn1];
}
//导航条返回按钮的点击事件
- (void)returnBtn{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)tableV{
    NSArray * arr1 = @[@"常见问题",@"1.优惠卷如何使用？",@"2.取消订单的时候钱什么时候到账?",@"3.可以固定同一个阿姨服务吗？",@"4.如何选择上一次服务的阿姨？",@"5.预约成功后在哪里查看？",@""];
     arr = @[@"asdadad",@"在您“递交订单”的时候，系统会自动匹配可用的优惠卷，选择在线支付后，系统会自动抵扣相应金额。如果选择现金支付，则不能使用优惠卷。",@"取消订单，涉及款项将会按支付渠道3-7个工作日内退还。",@"可以，您可以选择“周期预约”指定的阿姨下单，系统会有限推荐服务过您的阿姨，同时系统也会匹配您服务范围的所有阿姨，您可自行选择，预约成功后，此“周期预约”没得服务都有选择的阿姨统一服务。",@"在“订单”选项中，查看您上次服务的订单，点击“再次预约”，即可快速制定同一阿姨再次服务",@"您预约成功后，可以通过APP中的订单选项查看订单状态，订单状态会自动更新，同时系统会自动触发短信告知您。",@""];
    dataSource = [NSMutableArray array];
    [dataSource addObjectsFromArray:arr1];
    _stateArray = [NSMutableArray array];
    
    for (int i = 0; i < arr.count; i++)
    {
        //所有的分区都是闭合
        [_stateArray addObject:@"0"];
    }
    //NSLog(@"arr= %@",arr);
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Width, CGRectGetHeight([UIScreen mainScreen].bounds)-108) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [UIView new];
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
    cell.textLabel.text = arr[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    [cell.textLabel setAlpha:0.5];
    [cell setBackgroundColor:[UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1]];
    [cell.textLabel setNumberOfLines:3];
    //[UILabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    //cell.textLabel.text = self.data_array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}- (NSString * )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return dataSource[section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 6) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, Width, 45)];
        //[btn setTitle:dataSource[section] forState:UIControlStateNormal];
        [btn setBackgroundColor: [UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UILabel * la = [[UILabel alloc]init];
        [la setText:dataSource[section]];
        if (section == 0) {
            UIView * eaView = [[UIView alloc]init];
            [eaView setFrame:CGRectMake(13, 13, 5, 19)];
            [eaView setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
            [btn addSubview:eaView];
            [la setFrame:CGRectMake(20, 0, Width, 45)];
            [la setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        }else{
            [la setFrame:CGRectMake(10, 0, Width, 45)];
        }
        [la setTextAlignment:NSTextAlignmentLeft];
        [btn addSubview:la];
        //[btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, Width-250)];
        //[btn setBackgroundColor:[UIColor redColor]];
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, btn.frame.size.height-1, btn.frame.size.width-10, 1)];
        [sectionLabel setFrame:CGRectMake(0, 0, Width, 45)];
        [sectionLabel setNumberOfLines:2];
        [sectionLabel setAlpha:0.4];
        [sectionLabel setFont:[UIFont systemFontOfSize:15]];
        
        UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (44-6)/2, 10, 6)];
        if (section == 0 || section == 6) {
            if (section == 0) {
                [line setImage:[UIImage imageNamed:@"1"]];
            }
        }else{
            if ([_stateArray[section] isEqualToString:@"0"]) {
                _imgView.image = [UIImage imageNamed:@"3"];
            }else if ([_stateArray[section] isEqualToString:@"1"]) {
                _imgView.image = [UIImage imageNamed:@"2"];
            }
            [line setImage:[UIImage imageNamed:@"1"]];
        }
        [btn addSubview:_imgView];
        [btn addSubview:sectionLabel];
        [btn addSubview:line];
        [btn setTag:section];
        [btn addTarget:self action:@selector(sectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        return btn;
    }else{
        UIView * viewBack = [[UIView alloc]init];
        [viewBack setFrame:CGRectMake(0, 0, Width, self.tableView.frame.size.height - 270)];
        [viewBack setUserInteractionEnabled:YES];
        [viewBack setBackgroundColor:[UIColor whiteColor]];
        UIView * eaView = [[UIView alloc]init];
        [eaView setFrame:CGRectMake(13, 13, 5, 19)];
        [eaView setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
        [viewBack addSubview:eaView];
        UILabel * moreLabel = [[UILabel alloc]init];
        [moreLabel setFrame:CGRectMake(20, 0, Width, 45)];
        [moreLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [moreLabel setText:@"更多问题"];
        [viewBack addSubview:moreLabel];
        
        [self sectionView:viewBack andViewHeight:viewBack.frame.size.height];
        return viewBack;
    }
}
- (void)sectionBtn:(UIButton *)btn{
    if (btn.tag == 0 || btn.tag == 6) {
        [_stateArray replaceObjectAtIndex:btn.tag withObject:@"0"];
    }else{
        if ([_stateArray[btn.tag] isEqualToString:@"1"]){
            //修改
            [_stateArray replaceObjectAtIndex:btn.tag withObject:@"0"];
        }else{
            [_stateArray replaceObjectAtIndex:btn.tag withObject:@"1"];
        }
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section!=6) {
        return 45;
    }
    return self.tableView.frame.size.height - 270;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)sectionView:(UIView *)view andViewHeight:(CGFloat)height{
    CGFloat BtnHe = (height - 45)/2;
    CGFloat Btnf = 1;
    NSInteger btnh = 0;
    labelArr = @[@"",@"订单相关",@"支付与费用",@"客户端使用",@"服务相关",@"优惠卷与活动"];
    for (NSInteger i = 0; i < 3; i++) {
        for (NSInteger y = 0; y < 2; y++) {
            // UIButton * btn = [[UIButton alloc]init];
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(i*Width/3, y*BtnHe+45, Width/3, BtnHe)];
            [btn addTarget:self action:@selector(sixBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:Btnf++];
            
            CGFloat imageF = (Width/3-50)/2;
            //更多问题按钮上面的图片
            UIImageView * imageVIew = [[UIImageView alloc]init];
            if (btn.tag != 6) {
                [imageVIew setFrame:CGRectMake(imageF, 20, 50, 50)];
            }
            [imageVIew setImage:[UIImage imageNamed:@"one"]];
            [btn addSubview:imageVIew];
            UILabel * label = [[UILabel alloc]init];
            [label setFrame:CGRectMake(0, imageVIew.frame.size.height+20, btn.frame.size.width, 35)];
            btnh++;
            if (btnh >= 6) {
                btnh = 0;
            }
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:15]];
            [label setText:labelArr[btnh]];
            [btn addSubview:label];
            [btn.layer setBorderWidth:1];
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.3 });
            [btn.layer setBorderColor:colorref];
            [view addSubview:btn];
        }
    }
}
- (void)sixBtn:(UIButton *)btn{
    CellTableViewController * cell = [[CellTableViewController alloc]init];
    NSLog(@"%ld",(long)btn.tag);
    if (btn.tag <= 3) {
        cell.sectionArr = @[@"1",@"2",@"3",@"4"];
        cell.titleArr = @[@"1",@"2",@"3",@"4"];
    }else{
        cell.sectionArr = @[@"1",@"2",@"3",@"4"];
        cell.titleArr = @[@"1",@"2",@"3",@"4"];
    }
    [self presentViewController:cell animated:YES completion:^{
    }];
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
