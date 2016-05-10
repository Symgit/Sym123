//
//  rootViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/6.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "rootViewController.h"
#import "CouponViewController.h"
#import "MerchantCenterViewController.h"
#import "HomePageViewController.h"
#import "MeViewController.h"
#import "OrderViewController.h"

#define KWIDTH ([UIScreen mainScreen].bounds.size.width)
#define KHEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define Font(num) [UIFont systemFontOfSize:num]

@interface rootViewController (){
    NSArray     *normalImageArray;
    NSArray     *highlightedImageArray;
    NSArray     *titleArray;
    
    UIImageView *tempImageView;//临时图片
    UILabel     *tempLabel;//临时标签
    UIButton    *tempButton;//临时按钮
    
    NSInteger   index;//记录上次点击的按钮
}
@property (nonatomic,strong)UIView *tabBarBgView;

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;//初始化
    
    normalImageArray = [[NSArray alloc]initWithObjects:@"onepng",@"me",@"other",@"coupon", nil];
    highlightedImageArray = [[NSArray alloc]initWithObjects:@"one2png",@"me1",@"other1",@"coupon1", nil];
    titleArray = [[NSArray alloc]initWithObjects:@"首页",@"我的",@"订单",@"商户", nil];
    
    [self configerVC];//配置底部tabbar
    
    [self configerUI];//配置UI界面
    //[self setTitle:@"e家洁"];
    // Do any additional setup after loading the view.
}
- (void)configerVC{
    HomePageViewController * home = [[HomePageViewController alloc]init];
    UINavigationController *FirstNav = [[UINavigationController alloc]initWithRootViewController:home];
    OrderViewController * order = [[OrderViewController alloc]init];
    UINavigationController *TwoNav = [[UINavigationController alloc]initWithRootViewController:order];
    //CouponViewController * coupon = [[CouponViewController alloc]init];
    MerchantCenterViewController * mer = [[MerchantCenterViewController alloc]init];
    UINavigationController *ThourNav = [[UINavigationController alloc]initWithRootViewController:mer];
    
    MeViewController * me = [[MeViewController alloc]init];
    UINavigationController *FoveNav = [[UINavigationController alloc]initWithRootViewController:me];
    self.viewControllers = @[FirstNav, FoveNav, TwoNav, ThourNav];
}
#pragma mark
#pragma mark---配置UI界面
- (void)configerUI{
    
    //背景
    self.tabBarBgView = [[UIView alloc]initWithFrame:CGRectMake(0, KHEIGHT-49, KWIDTH, 49)];
    self.tabBarBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabBarBgView];
    
    float interValX = KWIDTH/4-20;
    
    //创建5个按钮
    for (int i = 0; i<4; i++) {
        
        //图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((KWIDTH/4-30)/2+(20+interValX)*i, 2, 30, 30)];
        imageView.image = [UIImage imageNamed:normalImageArray[i]];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = i+200;
        [self.tabBarBgView addSubview:imageView];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake((KWIDTH/4)*i, CGRectGetMinY(imageView.frame)+30, KWIDTH/4, 15);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = Font(12);
        titleLabel.textColor = RGBA(100, 100, 100, 1);
        titleLabel.text = titleArray[i];
        titleLabel.tag = i+300;
        [self.tabBarBgView addSubview:titleLabel];
        
        //按钮
        UIButton *tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tabBtn.frame = CGRectMake((KWIDTH/4)*i, 0, KWIDTH/4, 49);
        [tabBtn addTarget:self action:@selector(tabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        tabBtn.tag = i+100;
        tabBtn.selected = NO;
        [self.tabBarBgView addSubview:tabBtn];
        
        //第一个默认被选中
        if (i == 0) {
            
            imageView.image = [UIImage imageNamed:highlightedImageArray[0]];
            titleLabel.textColor = [UIColor colorWithRed:245/255.0 green:169/255.0 blue:44/255.0 alpha:1];
            tabBtn.selected = YES;
        }
    }
}

#pragma mark
#pragma mark---tabBar 按钮点击
- (void)tabBtnClick:(UIButton *)btn{
    
    //第一个不被选中
    UIImageView *img0    = (UIImageView *)[self.view viewWithTag:200];
    UILabel     *lab0    = (UILabel *)[self.view viewWithTag:300];
    UIButton    *button0 = (UIButton *)[self.view viewWithTag:100];
    img0.image = [UIImage imageNamed:normalImageArray[0]];
    lab0.textColor = RGBA(100, 100, 100, 1);
    button0.selected = NO;
    
    //切换VC
    self.selectedIndex = btn.tag-100;
    
    //取反
    btn.selected = !btn.selected;
    
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:btn.tag+100];
    UILabel *label = (UILabel *)[self.view viewWithTag:btn.tag+200];
    
    if (btn.selected == YES) {
        
        //临时图片转换
        tempImageView.image = [UIImage imageNamed:normalImageArray[index]];
        imageView.image = [UIImage imageNamed:highlightedImageArray[btn.tag-100]];
        tempImageView = imageView;
        
        //临时标签转换
        tempLabel.textColor = RGBA(100, 100, 100, 1);
        label.textColor = [UIColor colorWithRed:245/255.0 green:169/255.0 blue:44/255.0 alpha:1];
        tempLabel = label;
        
        //临时按钮转换
        tempButton.selected = NO;
        btn.selected = YES;
        tempButton = btn;
    }
    
    //记录上次按钮
    index  = self.selectedIndex;
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
