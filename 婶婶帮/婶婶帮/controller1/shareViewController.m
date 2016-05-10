//
//  shareViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/13.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "shareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface shareViewController ()

@end

@implementation shareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"分享"];
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"QQ"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:  UIAlertControllerStyleAlert];
                               
                               [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                   //点击按钮的响应事件；
                                   [self.navigationController popViewControllerAnimated:YES];
                               }]];
                               
                               //弹出提示框；
                               [self presentViewController:alert animated:true completion:nil];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享失败" message:nil preferredStyle:  UIAlertControllerStyleAlert];
                               
                               [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                   //点击按钮的响应事件
                                   [self.navigationController popViewControllerAnimated:YES];
                               }]];
                               
                               //弹出提示框
                               [self presentViewController:alert animated:true completion:nil];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    // Do any additional setup after loading the view.
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
