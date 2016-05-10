//
//  HomePageViewController.m
//  e家洁
//
//  Created by 孙月明 on 16/4/5.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "HomePageViewController.h"
#import "XRCarouselView.h"
#import "OpinionViewController.h"
#import "TapGesture.h"
#import "TimeCleaningViewController.h"
#import "tableViewController.h"
#import "MAMapViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>

#define scHeightOne 180
#define oneCellSectionHeight 280
#define twoCellSectionHeight 70
#define scwidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define scHeight CGRectGetHeight([UIScreen mainScreen].bounds))
#define _carouselView_heighta scHeightOne
#define btnHeight oneCellSectionHeight - _carouselView_heighta

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,AMapLocationManagerDelegate>{
    NSMutableArray * numArr;
    BOOL isYer;
    tableViewController* tablea;
    MAMapViewController * ma;
    UIButton * leftBtn;
}
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UITableViewCell * tabcell;
@property (nonatomic,strong)AMapLocationManager * locationManager;
@end

@implementation HomePageViewController
- (NSMutableArray *)numArr{
    if (numArr == nil) {
        
    }
    return numArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"婶婶帮"];
    //NSLog(@"width= %f,height= %@",self.view.bounds.size.width,[[UIDevice currentDevice] name]);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    tablea = [[tableViewController alloc]init];
    ma = [[MAMapViewController alloc]init];
    [self NavigationItem];
    //[self.navigationItem setRightBarButtonItem:rightBtnItem];
    [self tishi];
    //[self scrollView];
    [self tableV];
    // Do any additional setup after loading the view.
}
//获取当前所在城市
- (void)tishi{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"已定位到当前城市" message:nil preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，可修改，最小2s
        self.locationManager.locationTimeout = 3;
        //   逆地理请求超时时间，可修改，最小2s
        self.locationManager.reGeocodeTimeout = 3;
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            
            NSLog(@"location:%@", location);
            
            if (regeocode)
            {
                NSLog(@"reGeocode:%@", regeocode);
                [leftBtn setTitle:regeocode.province forState:UIControlStateNormal];
            }
        }];
    }]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}
//为导航条添加按钮
- (void)NavigationItem{
//右
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [btn1 setFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem * rightBtnItem1 = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    [btn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:1];
    [btn1 setTag:2];
    [btn1 addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItems:@[rightBtnItem,rightBtnItem1]];
//左
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[leftBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"太原市" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //leftBtn.backgroundColor = [UIColor yellowColor];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn setFrame:CGRectMake(0, 0, 75, 45)];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 30, 10)];
    [leftBtn setContentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft];
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:leftBtnItem];
}
- (void)right:(UIButton *)btn{
    if (btn.tag == 2) {
        OpinionViewController * opinion = [[OpinionViewController alloc]init];
        [self.navigationController pushViewController:opinion animated:YES];
    }else{
        //拨打电话
        NSString *allString = [NSString stringWithFormat:@"tel:4006767636"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
        //MAMapViewController * ma = [[MAMapViewController alloc]init];
        //[self.navigationController pushViewController:ma animated:YES];
    }
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, scwidth, CGRectGetHeight([UIScreen mainScreen].bounds)-49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    //去掉单元格黑线
    [tableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //NSMutableArray * test_array = [NSMutableArray array];
}
-(void)scrollView:(UIView *)view{
    isYer = YES;
    NSArray *arr2 = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", @"http://file27.mafengwo.net/M00/52/F2/wKgB6lO_PTyAKKPBACID2dURuk410.jpeg", @"http://file27.mafengwo.net/M00/B2/12/wKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg"];
    self.carouselView = [[XRCarouselView alloc] initWithImageArray:arr2 imageClickBlock:^(NSInteger index) {
        NSLog(@"第%ld张图片被点击", index);
    }];
    self.carouselView.frame = CGRectMake(0, 0, scwidth, scHeightOne);
    //设置每张图片的停留时间
    //    _carouselView.time = 1.5;
    //设置分页控件的图片
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    //设置分页控件的frame
    CGFloat width = arr2.count * 30;
    CGFloat height = 20;
    CGFloat x = _carouselView.frame.size.width - width - 10;
    CGFloat y = _carouselView.frame.size.height - height - 20;
    _carouselView.pageControl.frame = CGRectMake(x, y, width, height);
    //隐藏分页控件
    //    _carouselView.pageControl.hidden = YES;
    //CGFloat _carouselView_heighta = _carouselView.frame.size.height;
    
    UIView * btnView = [[UIView alloc]initWithFrame:CGRectMake(0, _carouselView_heighta, scwidth, btnHeight)];
    [btnView setUserInteractionEnabled:YES];
//日常与按钮UI
    UIView * oneview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, scwidth/2, btnHeight)];
    [oneview setUserInteractionEnabled:YES];
    oneview.tag = 0;
    [self tapGesturerecognizer:oneview andTag:oneview.tag];
    [self cellBtnContentReuse:oneview andNsinteger:0];
//周期
    UIView * twoView = [[UIView alloc]initWithFrame:CGRectMake(scwidth/2, 0, scwidth/2, btnHeight)];
    [twoView setUserInteractionEnabled:YES];
    twoView.tag = 2;
    [self tapGesturerecognizer:twoView andTag:twoView.tag];
    [self cellBtnContentReuse:twoView andNsinteger:1];
    //[twoView setBackgroundColor:[UIColor yellowColor]];
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.8;
    [label setFrame:CGRectMake(btnView.center.x, 5, 1, btnHeight-10)];
    //label.center = btnView.center;
    [btnView addSubview:oneview];
    [btnView addSubview:twoView];
    [btnView addSubview:label];
    [view addSubview:btnView];
    [view addSubview:_carouselView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        [self scrollView:cell.contentView];
    }else{
        isYer = NO;
        [self cellContentReuse:cell.contentView];
        [self cellBtnContentReuse:cell.contentView andNsinteger:indexPath.item];
    }
    //cell.textLabel.text = self.data_array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return oneCellSectionHeight;
    }
    return twoCellSectionHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"";
    }
    return @"  ";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (void)cellContentReuse:(UIView * )view{
    CGFloat width = twoCellSectionHeight-25;
    CGFloat imageY = width/2;
    CGFloat imageX = CGRectGetWidth([UIScreen mainScreen].bounds)-40;
    UIImageView * cellImage = [[UIImageView alloc]init];
    [cellImage setFrame:CGRectMake(imageX, imageY, 25, 25)];
    [cellImage setImage:[UIImage imageNamed:@"right"]];
    [view addSubview:cellImage];
}
- (void)cellBtnContentReuse:(UIView * )view andNsinteger:(NSInteger)integer{
    UIImageView * imageView = [[UIImageView alloc]init];
    UILabel * label1 = [[UILabel alloc]init];
    UILabel * label2 = [[UILabel alloc]init];
    NSArray * imageArr = [NSArray array];
    NSArray * labelArr = [NSArray array];
    NSArray * labArr = [NSArray array];
    CGFloat imH = 0;
    if (isYer == YES) {
        imageArr = @[@"one",@"btnImage1"];
        labelArr = @[@"日常保洁",@"周期保洁"];
        labArr = @[@"家庭保洁 预约随心",@"一次下单 清洁无忧"];
        imH = 0;
    }else{
        imageArr = @[@"one1",@"btnImage1",@"shenghuo"];
        labelArr = @[@"专业保洁",@"家电养护",@"生活急救箱"];
        labArr = @[@"深度清洁，让你的家焕然一新",@"专业工具手法，翻新你的家居",@"拆洗杀菌去污，延长家电寿命"];
        imH = 10;
    }
    
    CGFloat fl = scwidth/2;
    NSUInteger ter = integer;
    //NSLog(@"terter = %ld",ter);
    [imageView setFrame:CGRectMake(10, 30-imH*2, 50, 50)];
    CGFloat fl2 = fl-imageView.frame.size.width;
    CGFloat labelH = imageView.frame.size.height/2;
    CGFloat imageY = imageView.frame.origin.y;
    CGFloat imageW = imageView.frame.size.width;
    CGFloat imageH = imageView.frame.size.height;
    [label1 setFrame:CGRectMake(imageW+15, imageY+5, fl2, labelH)];
    [label1 setText:labelArr[ter]];
    [label1 setTextColor:[UIColor blackColor]];
    
    [label2 setFrame:CGRectMake(imageH+15, labelH+imageY+5, fl2, labelH-10+imH)];
   // NSLog(@"%@",labelArr[integer]);
    [label2 setText:labArr[integer]];
    [label2 setTextColor:[UIColor blackColor]];
    [label2 setFont:[UIFont systemFontOfSize:10]];
    label2.alpha = 0.6;
    //imageView.backgroundColor = [UIColor blackColor];
    imageView.image = [UIImage imageNamed:imageArr[ter]];
    [view addSubview:imageView];
    [view addSubview:label1];
    [view addSubview:label2];
}
//添加点击事件
- (void)tapGesturerecognizer:(UIView * )view andTag:(NSInteger)integer{
    TapGesture * tap = [[TapGesture alloc] initWithTarget:self action:@selector(tapgest:)];
    tap.tag = integer;
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tap];
}
- (void)tapgest:(TapGesture *)tap{
    TimeCleaningViewController * time = [[TimeCleaningViewController alloc]init];
    time.intager = tap.tag;
    [self.navigationController pushViewController:time animated:YES];
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
