//
//  CLPopViewController.m
//  CLPopoerView
//
//  Created by nil on 16/3/16.
//  Copyright © 2016年 CenLei. All rights reserved.
//

#import "CLPopViewController.h"
#import "PerfectInformationViewController.h"
@interface CLPopViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftCell;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *addArray;
@property (nonatomic,strong) PerfectInformationViewController * per;
@end

@implementation CLPopViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 155, 245)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    //self.tableView.backgroundColor = [UIColor yellowColor];
    //self.tableView.tableFooterView = [UIView new];
    self.addArray = [[NSMutableArray alloc] initWithObjects:@"个人信息",@"提现", @"查看提现记录",@"修改商家地址", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *identifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.addArray[indexPath.row]];
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        _per = [[PerfectInformationViewController alloc]init];
        _per.firstBool = YES;
        [self presentViewController:_per animated:YES completion:^{
        }];
    }
}
//重写preferredContentSize，返回popover的大小
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;
        CGSize size = [self.tableView sizeThatFits:tempSize];  //sizeThatFits返回的是最合适的尺寸，但不会改变控件的大小
        return size;
    }else {
        return [super preferredContentSize];
    }
}

@end
