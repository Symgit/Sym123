//
//  TransitionPlay.h
//  界面跳转动画
//
//  Created by 孙月明 on 16/6/1.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//添加一个枚举判断是push要执行的动画还是pop执行的动画
typedef NS_ENUM(NSUInteger, TransitionPlayType) {
    TransitionPlayTypePush = 0,
    TransitionPlayTypePop
};
//想要使用转场动画要继承<UIViewControllerAnimatedTransitioning>
@interface TransitionPlay : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic)TransitionPlayType type;

+ (instancetype)transitionWithType:(TransitionPlayType )type;
- (instancetype)initWithTransitionType:(TransitionPlayType )type;

@end
