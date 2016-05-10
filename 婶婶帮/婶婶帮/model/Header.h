//
//  Header.h
//  e家洁1
//
//  Created by 孙月明 on 16/4/28.
//  Copyright © 2016年 Sym. All rights reserved.
//

#ifndef Header_h
#define Header_h
//登录申请
#define header_ender @"http://wx.shenshenbang.com/index.php?g=portal&m=Iosjk&a=login"

//商户申请
#define header_image @"http://wx.shenshenbang.com/index.php?g=portal&m=Iosjk&a=shang_add"

//屏幕的宽高
#define W_with CGRectGetWidth([UIScreen mainScreen].bounds)
#define H_height CGRectGetHeight([UIScreen mainScreen].bounds)

/*
 自定义导航条的位置
 **/
#define navItemRect CGRectMake(0, 0, W_with, 64)
//颜色
#define RGBColol(a ,b ,c ,d) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:(d)]
//shang_add
#endif /* Header_h */
