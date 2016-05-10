//
//  timeScViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/27.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "timeScViewController.h"
#import "TimeScrollerViewController.h"
#import "AddBtn.h"
#import "CollerTime.h"
#define Bound_Width  [[UIScreen mainScreen] bounds].size.width
#define Bound_Height [[UIScreen mainScreen] bounds].size.height

@interface timeScViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * dataSource;
    TimeScrollerViewController * time;
    UILabel * loopLabel;
    CollerTime * cor;
}
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation timeScViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    cor = [[CollerTime alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 280)];
    [self tableV];
}
- (void)Btn{//确认订单
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[btn setFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-45, CGRectGetWidth([UIScreen mainScreen].bounds), <#CGFloat height#>)];
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Bound_Width, Bound_Height-45) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [UIView new];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [self cellScenton:cell.contentView andIndexPath:indexPath.item];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 2) {
        return 280;
    }
    return 60;
}
- (void)cellScenton:(UIView *)view andIndexPath:(NSInteger)index{
    if (index == 0) {//第一个单元格的UI
        UIImageView * timeImage = [[UIImageView alloc]init];
        [timeImage setFrame:CGRectMake(15, 15, 30, 30)];
        [timeImage setImage:[UIImage imageNamed:@"time"]];
        [view addSubview:timeImage];
        
        UILabel * label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(15 + timeImage.frame.size.width + 15, 10, 90, 40)];
        [label setText:@"服务时长"];
        [view addSubview:label];
//        AddBtn * add = [[AddBtn alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)-150, 5, 150, 150)];
//         NSLog(@"add.BtnNum= %f",add.BtnNum);
        //NSLog(@"addBtn= %f",[add addBtn]);
        //[view addSubview:add];
        //cor = [[CollerTime alloc]init];
        [view setUserInteractionEnabled:YES];
        [cor AddBtn:CGRectMake(CGRectGetWidth(self.view.bounds)-150, 5, 150, 150) UIView:view];
    }else if (index == 1){//第二个单元格的UI
        time  = [[TimeScrollerViewController alloc]init];
        [time UIScrollView:view];
        
    }else if (index == 2){//第三个单元格的UI
        
        [view addSubview:cor];
    }else{//第四个单元格的UI
        UIImageView * timeImage = [[UIImageView alloc]init];
        [timeImage setFrame:CGRectMake(15, 15, 30, 30)];
        [timeImage setImage:[UIImage imageNamed:@"time"]];
        [view addSubview:timeImage];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15 + timeImage.frame.size.width + 15, 10, 90, 40)];
        [label setText:@"服务频次"];
        [view addSubview:label];
        
        loopLabel = [[UILabel alloc]init];
        [loopLabel setFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 110, 10, 90, 40)];
        [loopLabel setTextColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
        [loopLabel setText:@"仅此一次"];
        [view addSubview:loopLabel];
        
        CGFloat imageView_x = loopLabel.frame.origin.x + loopLabel.frame.size.width;
        UIImageView * imageView = [[UIImageView alloc]init];
        [imageView setFrame:CGRectMake(imageView_x, 17, 25, 25)];
        [imageView setImage:[UIImage imageNamed:@"right"]];
        [view addSubview:imageView];
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
