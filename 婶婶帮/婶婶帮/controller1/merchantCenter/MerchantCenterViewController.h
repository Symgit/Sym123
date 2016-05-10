//
//  MerchantCenterViewController.h
//  e家洁1
//
//  Created by 孙月明 on 16/5/4.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantCenterViewController : UIViewController

@property (strong, nonatomic) NSArray *fontNames;//存储字体的样式
@property (strong, nonatomic) NSArray *fontSamples;//单元格的名称
@property (strong, nonatomic) NSString *errorMessage;//错误信息
@property (nonatomic, strong) NSString * imageUrl;//头像
@property (nonatomic, strong) NSString * nameStr;//暂时存储昵称  以后正式改为地址
@end
