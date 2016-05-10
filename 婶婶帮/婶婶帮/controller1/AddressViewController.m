//
//  AddressViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/21.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "AddressViewController.h"
#import "MAMapViewController.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MAMapViewController * ma;
    NSString * address;
    UILabel * cellLabel;
}
@property (nonatomic,strong) UITableView * tableView;
@end
@implementation AddressViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    ma = [[MAMapViewController alloc]init];
    // Do any additional setup after loading the view.
    [self tableV];
}
- (void)tableV{
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [table setBackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]];
    [self.view addSubview:table];
    self.tableView = table;
    self.tableView.tableFooterView = [UIView new];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (address == nil) {
        [self cellSentent:cell.contentView AndIndexPath:indexPath.item sention:indexPath.section];
        
    }else{
        
    }
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"常用地址";
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 45;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
           // MAMapViewController * ma = [[MAMapViewController alloc]init];
            [self.navigationController pushViewController:ma animated:YES];
        }
    }
}
- (void)cellSentent:(UIView *)view AndIndexPath:(NSInteger)index sention:(NSInteger)sention{
//单元格头的图片
    UIImageView * imageview = [[UIImageView alloc]init];
    [imageview setFrame:CGRectMake(15, 5, 35, 35)];
    NSArray * imageArr = @[@"weizhi",@"time"];
    
    [view addSubview:imageview];
//单元格尾部的图片
    UIImageView * footImage = [[UIImageView alloc]init];
    [footImage setFrame:CGRectMake(CGRectGetWidth(self.view.bounds)-40, 5, 25, 25)];
    if (sention == 0) {
        if (index == 0) {
            [footImage setImage:[UIImage imageNamed:@"right"]];
        }
        [imageview setImage:[UIImage imageNamed:imageArr[index]]];
        
    }
    CGFloat textX = imageview.frame.origin.x + imageview.frame.size.width+ 15;
    CGFloat textW = textX+60;
    [view addSubview:footImage];
    [view addSubview:imageview];

    if (sention == 0 && index == 0) {
        cellLabel = [[UILabel alloc]init];
        [cellLabel setFrame:CGRectMake(textX, 5, CGRectGetWidth(self.view.bounds) - textW, 45)];
        [cellLabel setText:@"请填写服务地址"];
        [cellLabel setAlpha:0.3];
        [view addSubview:cellLabel];
    }
//单元格文字
    _textField = [[UITextField alloc]init];
    
    [_textField setFrame:CGRectMake(textX, 0, CGRectGetWidth(self.view.bounds)-textW, 45)];
    NSArray * textArr = @[@"请填写服务地址",@"请填写详细楼栋门牌号"];
    if (_cellStr) {
        _textField.text =  self.cellStr;
        NSLog(@"%@",self.cellStr);
    }
    
    
    if (sention == 0) {
        if (index == 1) {
            _textField.tag = index;
            _textField.placeholder = textArr[index];
            [view addSubview:_textField];
            _textField.userInteractionEnabled = YES;
        }else{
            _textField.userInteractionEnabled = NO;
        }
        
    }else{
        _textField.userInteractionEnabled = NO;
        _textField.placeholder = @"无可用地址";
        [view addSubview:_textField];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
     //self.cellStr;
   static NSString * s = nil;
    [ma setCityBlock:^(NSString *CityStr){
        NSLog(@"city%@",CityStr);
        s = CityStr;
    }];
    if (cellLabel.text != nil) {
        cellLabel.text = s;
        [cellLabel setAlpha:1];
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
