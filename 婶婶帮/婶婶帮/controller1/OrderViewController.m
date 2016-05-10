//
//  OrderViewController.m
//  e家洁
//
//  Created by 孙月明 on 16/4/5.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "OrderViewController.h"
#import "EnderViewController.h"
#import "YasinCustomTabBar.h"

#define Bound_Width  [[UIScreen mainScreen] bounds].size.width
#define Bound_Height [[UIScreen mainScreen] bounds].size.height

@interface OrderViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UILabel * backLabel;//无订单的时候背景显示的文字
    //BOOL isCycle;//判断是否是周期订单
    NSMutableArray * dataSource;//订单的数据源
}
@property (nonatomic,assign) BOOL isCycle;//判断是否是周期订单
@property (nonatomic,assign) BOOL isRemove;//判断书否取消了订单
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation OrderViewController
- (void)viewWillAppear:(BOOL)animated{
    EnderViewController * ender = [[EnderViewController alloc]init];
    //[self.navigationController pushViewController:ender animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]];
    backLabel = [[UILabel alloc]init];
    [backLabel setFrame:CGRectMake(0, 0, 200, 35)];
    [backLabel setTextColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]];
    [backLabel setText:@"你还没有订单"];
    [backLabel setTextAlignment:NSTextAlignmentCenter];
    backLabel.center = self.view.center;
    [self.view addSubview:backLabel];
    [self setTitle:@"订单"];
    
    NSArray *array = @[@"全部订单",@"待付款",@"待服务"];
    YasinCustomTabBar *customView = [YasinCustomTabBar setTabBarPoint:CGPointMake(0, 64)];
    customView.lineColor = [UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1];
    customView.numberArr = @[@"1",@"2",@"3"];
    [customView setData:array NormalColor
                       :[UIColor blackColor] SelectColor
                       :[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1] Font
                       :[UIFont systemFontOfSize:15]];
    [self.view addSubview:customView];
    
    [customView getViewIndex:^(NSString *title, NSInteger index) {
        NSLog(@"title:%@ - index:%li",title,index);
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentOffset = CGPointMake(index * Bound_Width, 0);
            if (index == 0) {
                [backLabel setText:@"你还没有订单"];
            }else{
                [backLabel setText:[NSString stringWithFormat:@"你还没有%@订单",array[index]]];
            }
            //[YasinCustomTabBar setViewIndex:index];
        }];
    }];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+40, Bound_Width, Bound_Height - 40 - 64)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.contentSize = CGSizeMake(array.count*Bound_Width, 0);
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<array.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*Bound_Width, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        view.tag = i + 1;
        [self backTableView:view];
        //view.backgroundColor = [self randomColor];
        [self.scrollView addSubview:view];
    }
    // Do any additional setup after loading the view.
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / Bound_Width;
    //设置TabBar的移动位置
    [YasinCustomTabBar setViewIndex:index];
}
- (void)backTableView:(UIView *)view{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)- 155) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [UIView new];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self cellSingle:cell.contentView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (void)cellSingle:(UIView *)view{
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(15, 10, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"btnImage1"]];
    [view addSubview:imageView];
    UILabel * nameLabel = [[UILabel alloc]init];
    CGFloat name_x = 15 + imageView.frame.size.width + 15;
    [nameLabel setText:@"家庭保洁"];
    [nameLabel setFrame:CGRectMake(name_x, 3, 95, 35)];
    [view addSubview:nameLabel];

    UILabel * paymentStyleLabel = [[UILabel alloc]init];
    [paymentStyleLabel setFrame:CGRectMake(Bound_Width-80, nameLabel.frame.origin.y, 60, 35)];
    [paymentStyleLabel setText:@"待支付"];
    [view addSubview:paymentStyleLabel];
    UIImageView * rightImage = [[UIImageView alloc]init];
    CGFloat rightImage_x = paymentStyleLabel.frame.origin.x + paymentStyleLabel.frame.size.width;
    [rightImage setFrame:CGRectMake(rightImage_x, imageView.frame.origin.y, 20, 20)];
    [rightImage setImage:[UIImage imageNamed:@"right"]];
    [view addSubview:rightImage];
    UIImageView * image1 = [[UIImageView alloc]init];
    [image1 setFrame:CGRectMake(15, 45, CGRectGetWidth([UIScreen mainScreen].bounds)-15, 1)];
    [image1 setImage:[UIImage imageNamed:@"1"]];
    [view addSubview:image1];
    
    CGFloat image_y = image1.frame.origin.y;
    CGFloat orderLabel_x = nameLabel.frame.origin.x;
    CGFloat orderLabel_w = Bound_Width - orderLabel_x - 20;
    NSArray * imageArr = @[@"time",@"weizhi"];
    NSArray * arr = @[@"2016-05-10 17:00-19:00",@"天津，天津市，和平区，津门公寓b座1单元3302"];
    for (NSInteger i = 0; i < 2; i++) {
        UIImageView * image = [[UIImageView alloc]init];
        [image setFrame:CGRectMake(15, image_y + i * 20+ (i * 8) + 13, 20, 20)];
        [image setImage:[UIImage imageNamed:imageArr[i]]];
        [view addSubview:image];
        
        UILabel * orderLabel = [[UILabel alloc]init];
        [orderLabel setFont:[UIFont systemFontOfSize:12]];
        [orderLabel setFrame:CGRectMake(orderLabel_x, image_y + i * 20+ (i * 8) + 5, orderLabel_w, 35)];
        [orderLabel setText:arr[i]];
        [orderLabel setTextColor:[UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1]];
        [view addSubview:orderLabel];
    }
    
    UIImageView * rightImage1 = [[UIImageView alloc]init];
    
    [rightImage1 setFrame:CGRectMake(15, 113, Bound_Width-15, 1)];
    [rightImage1 setImage:[UIImage imageNamed:@"1"]];
    [view addSubview:rightImage1];
    
    NSArray * removeArr = @[@"取消订单",@"支付订单",@"删除订单"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake((paymentStyleLabel.frame.origin.x-75) + i * 65 + (i * 10), rightImage1.frame.origin.y + 10, 65, 30)];
        [btn setTitle:removeArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTag:i+1];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setBorderWidth:1.5];
        [btn.layer setCornerRadius:3];
        [btn.layer setBorderColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor];
        [btn addTarget:self action:@selector(paymentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8.0;
}
- (void)paymentBtn:(UIButton *)btn{
    UIButton * button = (UIButton *)[self.view viewWithTag:2];
    if (btn.tag == 1) {
        btn.hidden = YES;
        [button setTitle:@"删除订单" forState:UIControlStateNormal];
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
