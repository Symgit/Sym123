//
//  ViewController.m
//  导航条下拉菜单
//
//  Created by 孙月明 on 16/6/16.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "ViewController.h"
#import "RightBarViewController.h"
@interface ViewController ()<UIPopoverPresentationControllerDelegate>
{
   
}
@property (nonatomic, strong)RightBarViewController * right;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 45, 45)];
    [btn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(RightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = bar;
}
- (void)RightBtn:(UIButton *)btn{
    self.right = [[RightBarViewController alloc]initWithNibName:@"RightBarViewController" bundle:nil];
    self.right.modalPresentationStyle = UIModalPresentationPopover;
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.right.popoverPresentationController.barButtonItem = bar;
    self.right.preferredContentSize=CGSizeMake(145, 294);
    //箭头方向
    self.right.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    self.right.popoverPresentationController.delegate = self;
    [self presentViewController:self.right animated:YES completion:^{
    }];
}
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style{
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller.presentedViewController];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"" style:@"" target:self action:@selector(dismiss)];
    nav.topViewController.navigationItem.rightBarButtonItem = item;
    return nav;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
