//
//  PerfectInformationViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/4.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "MerchantCenterViewController.h"
#import "UIImageView+WebCache.h"
#import "EnderViewController.h"
#import "navBarView.h"
#import "StrBool.h"
#import "Header.h"

#define cellHeight 65
#define headerSectionHeight 110
#define footerSectionHeight 150

@interface PerfectInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    StrBool * strBool;
    UITextField * textFiel;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation PerfectInformationViewController
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        [_dataSource addObjectsFromArray:[user objectForKey:@"user"]];
    }
    return _dataSource;
}
- (void)viewWillAppear:(BOOL)animated{
    NSInteger index = _firstBool;
    NSLog(@"index= %ld",index);
    if (_firstBool == YES) {
        navBarView *barView = [[navBarView alloc]initWithFrame:navItemRect];
        barView.delegate = self;
        [self.view addSubview:barView];
    }else{
        _firstBool = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    strBool = [[StrBool alloc]init];
    [self setTitle:@"完善信息"];
    [self tableV];
    // Do any additional setup after loading the view.
}
- (void)navges{
    UIView * naView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W_with, 64)];
    [self.view addSubview:naView];
    UIImageView * imageView1 = [[UIImageView alloc]init];
    [imageView1 setImage:[UIImage imageNamed:@"1"]];
    [imageView1 setFrame:CGRectMake(0, 63, W_with, 64)];
    [naView addSubview:imageView1];
}
- (void)tableV{
    CGFloat table_Y = 0;
    if (_firstBool == YES) {
        table_Y = 64;
    }else{
        table_Y = 0;
    }
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, table_Y, W_with, H_height) style:UITableViewStylePlain];
    //去掉单元格黑线
    [tableView setSeparatorColor:[UIColor clearColor]];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self cellAndSection:cell.contentView indexPath:indexPath.item];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W_with, headerSectionHeight)];
    UIImageView * headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
    //[headerImage setImage:[UIImage imageNamed:@"4"]];
    [headerImage sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"4"]];
    headerImage.center = headerView.center;
    [headerImage.layer setCornerRadius:45.0];
    [headerView addSubview:headerImage];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W_with, footerSectionHeight)];
    UIButton * footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBtn setFrame:CGRectMake(0, 0, W_with/4*3, 40)];
    if (_firstBool == YES) {//判断是否交互
        [footerBtn setAlpha:0];
    }else{
        [footerBtn setAlpha:1];
    }
    footerBtn.center = footerView.center;
    [footerBtn setTitle:@"完成" forState:UIControlStateNormal];
    [footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(completeBtn) forControlEvents:UIControlEventTouchUpInside];
    [footerBtn setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
    [footerBtn.layer setCornerRadius:20];
    [footerView addSubview:footerBtn];
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerSectionHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return footerSectionHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}
- (void)cellAndSection:(UIView *)view indexPath:(NSInteger)index{
    
    [view setUserInteractionEnabled:YES];
    NSArray * arr = @[@"昵称:",@"姓名:",@"手机号:",@"身份证号:",@"地址:"];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 85, 35)];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label setAlpha:0.6];
    [label setText:arr[index]];
    [view addSubview:label];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, cellHeight-1, W_with, 1)];
    [imageView setAlpha:0.6];
    [imageView setImage:[UIImage imageNamed:@"1"]];
    [view addSubview:imageView];
    
    CGFloat textX = label.frame.origin.x + label.frame.size.width + 25;
    CGFloat textW = W_with - textX;
    textFiel = [[UITextField alloc]initWithFrame:CGRectMake(textX, 0, textW, cellHeight)];
    textFiel.delegate = self;
    textFiel.tag = index + 1;
    if (_firstBool == YES) {
        textFiel.userInteractionEnabled = NO;
    }else{
        textFiel.userInteractionEnabled = YES;
    }
    if (![strBool isBlankString:self.nameStr]) {
        if (textFiel.tag == 1) {
            textFiel.text = self.nameStr;
        }
    }
    if (_firstBool == YES) {
        [textFiel setPlaceholder:@"待完善"];
    }else{
        if (index == 3) {
            [textFiel setPlaceholder:@"请完善个人信息(选填)"];
        }else{
            [textFiel setPlaceholder:@"请完善个人信息"];
        }
    }
    [view addSubview:textFiel];
}
//完成信息填写的按钮
- (void)completeBtn{
    MerchantCenterViewController * mer = [[MerchantCenterViewController alloc]init];
    mer.imageUrl = self.imageUrl;
    mer.nameStr = self.nameStr;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textFiel resignFirstResponder];
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
