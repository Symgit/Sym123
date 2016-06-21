//
//  ViewController.m
//  3DAnimationEffects
//
//  Created by 孙月明 on 16/5/31.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "ViewController.h"

#define time 0.7f
@interface ViewController ()
{
    UIView * view;
    NSInteger subTypeIndex;
    UIImageView * imageView;
}
@property (strong, nonatomic)NSArray * animationArr;
@end

@implementation ViewController
- (NSArray *)animationArr{
    if (_animationArr == nil) {
        _animationArr = [[NSArray alloc]initWithObjects:
                         @"淡入淡出",
                         @"推挤",
                         @"揭开",
                         @"覆盖",
                         @"立方体",
                         @"吮吸",
                         @"翻转",
                         @"波纹",
                         @"翻页",
                         @"反翻页",
                         @"开镜头",
                         @"关镜头",nil];
    }
    return _animationArr;
}
//按钮的点击事件
- (void)animationBtn:(UIButton *)btn{
    subTypeIndex = arc4random() % 4;
    NSString * strSubType;
    switch (subTypeIndex) {
        case 0:
            strSubType = kCATransitionFromLeft;
            break;
        case 1:
            strSubType = kCATransitionFromBottom;
            break;
        case 2:
            strSubType = kCATransitionFromRight;
            break;
        case 3:
            strSubType = kCATransitionFromTop;
            break;
        default:
            break;
    }
    
    switch (btn.tag) {
        case 1:
            [self transitionWithType:kCATransitionFade WithSubtype:strSubType ForView:self.view];
            break;
        case 2:
            [self transitionWithType:kCATransitionPush WithSubtype:strSubType ForView:self.view];
            break;
        case 3:
            [self transitionWithType:kCATransitionReveal WithSubtype:strSubType ForView:self.view];
            break;
        case 4:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:strSubType ForView:self.view];
            break;
        case 5:
            [self transitionWithType:@"cube" WithSubtype:strSubType ForView:self.view];
            break;
        case 6:
            [self transitionWithType:@"suckEffect" WithSubtype:strSubType ForView:self.view];
            break;
        case 7:
            [self transitionWithType:@"oglFlip" WithSubtype:strSubType ForView:self.view];
            break;
        case 8:
            [self transitionWithType:@"rippleEffect" WithSubtype:strSubType ForView:self.view];
            break;
        case 9:
            [self transitionWithType:@"pageCurl" WithSubtype:strSubType ForView:self.view];
            break;
        case 10:
            [self transitionWithType:@"pageUnCurl" WithSubtype:strSubType ForView:self.view];
            break;
        case 11:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:strSubType ForView:self.view];
            break;
        case 12:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:strSubType ForView:self.view];
            break;
            
        default:
            break;
    }
    NSInteger num = arc4random() % 5 + 1;
    [self addImageIsSelfBackImage:[NSString stringWithFormat:@"%ld",num]];
}
#pragma PATH 封装的按钮
- (void)Btn{
    NSInteger sum = [self animationArr].count;
    CGFloat height = ([UIScreen mainScreen].bounds.size.height)/sum;
    for (NSInteger i = 0; i < [self animationArr].count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, i*(height - 15) + i*15, 74, height - 5)];
        [btn setTitle:[self animationArr][i] forState:UIControlStateNormal];
        [btn setTag:i + 1];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:37/255.0 green:195/255.0 blue:167/255.0 alpha:1]];
        [btn addTarget:self action:@selector(animationBtn:) forControlEvents:UIControlEventTouchUpInside];
        //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"2"]]];
        [imageView addSubview:btn];
    }
}
#pragma PATH 添加动画
- (void) transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = time;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [imageView.layer addAnimation:animation forKey:@"animation"];
}
#pragma PATH 添加背景
- (void)addImageIsSelfBackImage:(NSString *)str{
    [imageView setImage:[UIImage imageNamed:str]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    subTypeIndex = 0;
    [self.view setBackgroundColor:[UIColor yellowColor]];
    imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [imageView setImage:[UIImage imageNamed:@"1"]];
    [imageView setUserInteractionEnabled:YES];
    [self.view addSubview:imageView];
    [self Btn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
