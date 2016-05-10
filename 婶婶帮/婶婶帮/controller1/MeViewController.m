//
//  MeViewController.m
//  e家洁
//
//  Created by 孙月明 on 16/4/5.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "MeViewController.h"
#import "OpinionViewController.h"
#import "MoreViewController.h"
#import "UseHelpViewController.h"
#import "HeaderThreeViewController.h"
#import "shareViewController.h"
#define Width CGRectGetWidth([UIScreen mainScreen].bounds)
@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    shareViewController * share;
    OpinionViewController * opinion;
    MoreViewController * more;
    UIImageView * imageView;
    UILabel * label;
    UILabel * numLabel;
}
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    opinion  = [[OpinionViewController alloc]init];
    [self setTitle:@"个人中心"];
    [self tableV];
    // Do any additional setup after loading the view.
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, CGRectGetHeight([UIScreen mainScreen].bounds)-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    //去掉单元格黑线
    //[tableView setSeparatorColor:[UIColor clearColor]];
    //[tableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
    [tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView = tableView;
    
    //NSMutableArray * test_array = [NSMutableArray array];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
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
        [self cellOneSectionUI:cell.contentView];
    }else{
        [self cellOrderSection:cell.contentView indexAndSection:indexPath.section cellIndex:indexPath.item];
    }
    //cell.textLabel.text = self.data_array[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 230;
    }
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.item == 1) {
            [self.navigationController pushViewController:opinion animated:YES];
        }else if (indexPath.item == 2){
            more = [[MoreViewController alloc]init];
            [self.navigationController pushViewController:more animated:YES];
        }else{
            UseHelpViewController * userHelp = [[UseHelpViewController alloc]init];
            [self presentViewController:userHelp animated:YES completion:^{
            }];
        }
    }else if (indexPath.section == 0){
        HeaderThreeViewController * header = [[HeaderThreeViewController alloc]init];
        [self presentViewController:header animated:YES completion:^{
        }];
    }else{
        if (indexPath.item == 1) {
            share = [[shareViewController alloc]init];
            [self.navigationController pushViewController:share animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 2) {
        //[tableView.tableFooterView addSubview:view];
       return @" ";
    }
    return @" ";
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView * view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [view setBackgroundColor:[UIColor whiteColor]];
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 1)];
        [label1 setBackgroundColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:0.5]];
        [view addSubview:label1];
        return view;
    }else{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setBackgroundColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:0.5]];
        return button;
    }
}
- (void)cellOneSectionUI:(UIView *)view{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 250-65)];
    [image setImage:[UIImage imageNamed:@"5"]];
    [image setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
    [view addSubview:image];
//头像
    CGFloat imX = 40;
    CGFloat imH = 100;
    CGFloat loat = imH/2;
    CGFloat imY = image.center.y-loat + 10;
    imageView = [[UIImageView alloc]init];
    [imageView setFrame:CGRectMake(imX, imY, imH, imH)];
    //imageView.center = image.center;
    //[imageView setBackgroundColor:[UIColor redColor]];
    [imageView setImage:[UIImage imageNamed:@"4"]];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = loat;
    [image addSubview:imageView];

//显示账户余额优惠券
    NSArray * arr = @[@"积分:",@"金币:"];
    CGFloat zW = Width/4;
    CGFloat zH1 = 250 - image.frame.size.height;
    CGFloat zH =zH1/2;
    CGFloat xY = 160 + zH;
    //NSLog(@"%f",zH);
    for (NSInteger i = 0; i < 4; i++) {
        numLabel = [[UILabel alloc]init];
        UILabel * xLabel = [[UILabel alloc]init];
        [numLabel setFrame:CGRectMake(i * zW, 165, zW, zH)];
        [xLabel setTextAlignment:NSTextAlignmentCenter];
        [xLabel setFrame:CGRectMake(i * zW, xY, zW, zH)];
        
        [xLabel setFont:[UIFont systemFontOfSize:15.0]];
        if (i == 0 || i == 2) {
            if (i == 2) {
                [xLabel setText:arr[1]];
            }else{
                [xLabel setText:arr[i]];
            }
            xLabel.alpha = 0.8;
            [xLabel setTextAlignment:NSTextAlignmentRight];
        }else{
            [xLabel setText:@"10"];
            [xLabel setTextAlignment:NSTextAlignmentLeft];
            xLabel.alpha = 0.5;
        }
        [view addSubview:xLabel];
    }
    for (NSInteger i = 0; i < 1; i++) {
        UILabel * labe = [[UILabel alloc]init];
        CGFloat lx = i * zW;
        [labe setFrame:CGRectMake(Width/2+lx - 3, 188, 1, 39)];
        [labe setBackgroundColor:[UIColor blackColor]];
        [labe setAlpha:0.1];
        [view addSubview:labe];
    }
//用户名称
    UILabel * nameLabel = [[UILabel alloc]init];
    CGFloat nameLabel_x = self.view.center.x - 35;
    [nameLabel setFrame:CGRectMake(nameLabel_x, view.center.y + 35, 85, 45)];
    [nameLabel setText:@"天地"];
    [nameLabel setFont: [UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
    [view addSubview:nameLabel];

//真实姓名
    CGFloat ma_y = nameLabel.frame.origin.y + nameLabel.frame.size.height-10;
    UILabel * maLabel = [[UILabel alloc]init];
    [maLabel setFrame:CGRectMake(nameLabel_x, ma_y, 115, 35)];
    NSString * str = @"先生";
    [maLabel setText:[NSString stringWithFormat:@"%@  %@",@"孙月明",str]];
    [maLabel setFont:[UIFont systemFontOfSize:15]];
    maLabel.alpha = 0.8;
    [view addSubview:maLabel];
    
//手机号
    CGFloat labH = 60;
    CGFloat labW = Width;
    CGFloat labY = maLabel.frame.origin.y + 7;
    label = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel_x, labY, labW, labH)];
    [label setTextAlignment:NSTextAlignmentLeft];
    NSString * phoneStr = @"手机号:";
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setText:[NSString stringWithFormat:@"%@%@",phoneStr,@"13612179590"]];
    label.alpha = 0.8;
    [image addSubview:label];
}
- (void)cellOrderSection:(UIView *)view indexAndSection:(CGFloat)fl cellIndex:(NSInteger)index{
    NSArray * arr = @[@"常用地址",@"分享给好友"];
    NSArray * imageArr = @[@"right",@"right"];
    NSArray * arra = @[@"使用帮助",@"意见反馈",@"更多"];
    NSArray * imageArra = @[@"right",@"right",@"right"];
    UIImageView * imageLabel = [[UIImageView alloc]init];
    UILabel * cellLabel = [[UILabel alloc]init];
    [imageLabel setFrame:CGRectMake(0, 5, 25, 25)];
    CGFloat cellH = Width-imageLabel.frame.size.width;
    [cellLabel setFrame:CGRectMake(imageLabel.frame.size.width, 0, cellH, 35)];
    if (fl == 1) {
        [imageLabel setImage:[UIImage imageNamed:imageArr[index]]];
        [cellLabel setText:arr[index]];
    }else{
        [imageLabel setImage:[UIImage imageNamed:imageArra[index]]];
        [cellLabel setText:arra[index]];
    }
    [view addSubview:imageLabel];
    [view addSubview:cellLabel];

    
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
