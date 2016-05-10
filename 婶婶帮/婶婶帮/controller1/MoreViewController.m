//
//  MoreViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/8.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "MoreViewController.h"
#define scwidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define scHeight CGRectGetHeight([UIScreen mainScreen].bounds))
@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"更多"];
    [self.view setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
    [self tableV];
    // Do any additional setup after loading the view.
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, scwidth, CGRectGetHeight([UIScreen mainScreen].bounds)-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //NSMutableArray * test_array = [NSMutableArray array];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        [self cellContent:cell.contentView cellIndex:indexPath.item cellSection:indexPath.section];
    }else{
        [self cellContent:cell.contentView cellIndex:indexPath.item cellSection:indexPath.section];
    }
    //cell.textLabel.text = self.data_array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
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
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView * view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [view setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]];
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, scwidth, 1)];
        [label1 setBackgroundColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:0.5]];
        [view addSubview:label1];
        return view;
    }else{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setBackgroundColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:0.5]];
        return button;
    }
}
- (void)cellContent:(UIView *)view cellIndex:(NSInteger)index cellSection:(NSInteger)teger{
    NSArray * arr = @[@"服务承诺",@"关于e家洁",@"赏e家洁一个好评"];
    UILabel * cellLabel = [[UILabel alloc]init];
    [cellLabel setFrame:CGRectMake(15, 0, scwidth-40, 35)];
    [cellLabel setFont:[UIFont systemFontOfSize:17]];
    if (teger == 0) {
        [cellLabel setText:arr[index]];
    }else{
        [cellLabel setText:@"联系我们"];
    }
    [view addSubview:cellLabel];
    UIImageView * imageView = [[UIImageView alloc]init];
    CGFloat imX = cellLabel.frame.size.width + cellLabel.frame.origin.x;
    [imageView setFrame:CGRectMake(imX, 6, 20, 20)];
    [imageView setImage:[UIImage imageNamed:@"right"]];
    [view addSubview:imageView];
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
