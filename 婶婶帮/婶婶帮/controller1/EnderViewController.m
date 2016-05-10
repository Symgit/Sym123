//
//  EnderViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/7.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "EnderViewController.h"
#import "HomePageViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "MyPostRequest.h"
#import "Header.h"
#import "PerfectInformationViewController.h"
#define Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define Height CGRectGetHeight([UIScreen mainScreen].bounds))
@interface EnderViewController ()<UITextFieldDelegate>
{
    UITextField * _phoneText;
    UITextField * _verificationText;
    UIButton * btn1;
    PerfectInformationViewController * perfect;
}
@end

@implementation EnderViewController
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //[self.view setBackgroundColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:0.2]];
    [self leftItemBtn];
    [self viewBtn];
    // Do any additional setup after loading the view.
}
- (void)leftItemBtn{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 25, 25)];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    [btn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)leftBtn:(UIButton *)btn{
    
}
- (void)viewBtn{
//登录背景
    UIView * view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [view setUserInteractionEnabled:YES];
    [view setBackgroundColor:[UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:0.5]];
    [self.view addSubview:view];
    
    UIView * enderVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 84, Width, 90)];
    [enderVeiw setUserInteractionEnabled:YES];
    [enderVeiw setBackgroundColor:[UIColor whiteColor]];
    UILabel * label = [[UILabel alloc]init];
    [label setBackgroundColor:[UIColor blackColor]];
    label.alpha = 0.4;
    CGFloat laY = enderVeiw.frame.size.height/2;
    [label setFrame:CGRectMake(0, laY, Width, 1)];
    //label.center = enderVeiw.center;
    [enderVeiw addSubview:label];
    [view addSubview:enderVeiw];
//手机号
    CGFloat teH = enderVeiw.frame.size.height/2;
    _phoneText = [[UITextField alloc]init];
    _phoneText.placeholder = @"请您输入手机号";
    //编译时出现输入框出现叉
    //[textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_phoneText setClearsOnBeginEditing:YES];
    [_phoneText setFrame:CGRectMake(0, 0, Width-110, teH)];
    [_phoneText setKeyboardType:UIKeyboardTypeNumberPad];
    _phoneText.delegate = self;
    [enderVeiw addSubview:_phoneText];
//验证码
    CGFloat verW = _phoneText.frame.size.width;
    CGFloat verH = _phoneText.frame.size.height;
    CGFloat verY = label.frame.origin.y+1;
    _verificationText = [[UITextField alloc]init];
    [_verificationText setFrame:CGRectMake(0, verY, verW, verH)];
    _verificationText.placeholder = @"请你输入验证码";
    [_verificationText setClearsOnBeginEditing:YES];
    [_verificationText setKeyboardType:UIKeyboardTypeNumberPad];
    _verificationText.delegate = self;
    [enderVeiw addSubview:_verificationText];
//获取验证码
    CGFloat btX = _phoneText.frame.size.width;
    CGFloat btH = _phoneText.frame.size.height-10;
    CGFloat btW = Width-btX-10;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
    [btn setFrame:CGRectMake(btX, 5, btW, btH)];
    [btn addTarget:self action:@selector(verBtn:) forControlEvents:UIControlEventTouchUpInside];
    [enderVeiw addSubview:btn];
//没有收到？
    CGFloat notX = _verificationText.frame.size.width;
    CGFloat notY = _verificationText.frame.origin.y;
    CGFloat notW = btn.frame.size.width;
    CGFloat notH = btn.frame.size.height;
    UIButton * notBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [notBtn setTitle:@"没有想到?" forState:UIControlStateNormal];
    [notBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [notBtn setFrame:CGRectMake(notX, notY, notW, notH)];
    [notBtn addTarget:self action:@selector(verBtn:) forControlEvents:UIControlEventTouchUpInside];
    [enderVeiw addSubview:notBtn];
//登录
    CGFloat endX = 30;
    CGFloat endY = enderVeiw.frame.size.height + 30;
    CGFloat endW = Width - 60;
    CGFloat endH = 50;
    UIButton * enderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enderBtn.layer.masksToBounds = YES;
    enderBtn.layer.cornerRadius = 5;
    [enderBtn setTitle:@"登录" forState:UIControlStateNormal];
    [enderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enderBtn setBackgroundColor:[UIColor colorWithRed:253/255.0 green:209/255.0 blue:62/255.0 alpha:1]];
    [enderBtn setFrame:CGRectMake(endX, endY, endW, endH)];
    [enderBtn addTarget:self action:@selector(enderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [enderVeiw addSubview:enderBtn];

//第三方登录
    CGFloat Sfy = endY + endH + btH + verY + 60;
    CGFloat Sfx = (self.view.bounds.size.width-(3* 45))/4;
    NSLog(@"%f",Sfx);
    NSArray * imageArr = @[@"weibo",@"QQ",@"xin"];
    for (NSInteger i = 0; i < 3; i++) {
        btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn1 setFrame:CGRectMake(Sfx+(i*45)+(i*40+20), Sfy, 45, 70)];
        [btn1 setTag:i+1];
        if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ] == NO) {
            if (btn.tag == 2) {
                [btn setAlpha:0];
            }
        }else if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat] == NO){
            if (btn.tag == 3) {
                [btn setAlpha:0];
            }
        }
        [btn1 addTarget:self action:@selector(thirdPartyLogin:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
- (void)verBtn:(UIButton *)btn{
    
}
- (void)enderBtn:(UIButton * )btn{
   
}
- (void)thirdPartyLogin:(UIButton *)btn{
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ] == YES) {
        
    }else if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat] == YES){
        if (btn.tag == 3) {
            [btn setAlpha:0];
        }
    }
    if (btn.tag == 1) {
        [self sina];
    }else if (btn.tag == 2){
        [self QQ];
    }else{
        [self weixin];
    }
}
//新浪微博登录
- (void)sina{
    NSUserDefaults * usr = [NSUserDefaults standardUserDefaults];
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             MyPostRequest * my = [[MyPostRequest alloc]init];
             NSDictionary * dic = @{@"openid":user.uid,@"nickname":user.nickname,@"headimgurl":user.icon};
             [my afPostRequestWithUrlString:header_ender parms:dic finishedBlock:^(id responseObj) {
                 NSLog(@"success= %@",responseObj);
                 NSDictionary * dic = [NSDictionary dictionaryWithDictionary:responseObj];
//存储openid
                 
                 [usr setObject:user.uid forKey:@"openid"];
                 [usr setObject:dic forKey:@"dic"];
             } failedBlock:^(NSString *errorMsg) {
                 NSLog(@"error= %@",errorMsg);
             }];
             perfect = [[PerfectInformationViewController alloc]init];
             perfect.imageUrl = [NSString stringWithFormat:@"%@",user.icon];
             perfect.nameStr = [NSString stringWithFormat:@"%@",user.nickname];
             perfect.firstBool = NO;
             [self.navigationController pushViewController:perfect animated:YES];
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSLog(@"头像= %@",user.icon);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

//微信登录
- (void)weixin{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

//QQ登录
- (void)QQ{
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
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
