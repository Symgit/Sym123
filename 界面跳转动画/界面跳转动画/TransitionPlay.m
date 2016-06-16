//
//  TransitionPlay.m
//  界面跳转动画
//
//  Created by 孙月明 on 16/6/1.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "TransitionPlay.h"

@implementation TransitionPlay

+ (instancetype)transitionWithType:(TransitionPlayType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TransitionPlayType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

//如何执行过渡动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case TransitionPlayTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case TransitionPlayTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}
//动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
//执行push过渡动画
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //数组中存储的是CATransition对象type效果
    NSArray * typeArr = @[kCATransitionFade,
                      kCATransitionPush,
                      kCATransitionReveal,
                      kCATransitionMoveIn,
                      @"cube",
                      @"suckEffect",
                      @"oglFlip",
                      @"rippleEffect",
                      @"pageCurl",
                      @"pageUnCurl",
                      @"cameraIrisHollowOpen",
                      @"cameraIrisHollowClose"];
    NSInteger num = arc4random() % 12;
    
    //数组中存储的是CATransition对象subtype效果
    NSArray * subtypeArr = @[kCATransitionFromLeft,
                             kCATransitionFromBottom,
                             kCATransitionFromRight,
                             kCATransitionFromTop];
    NSInteger sum = arc4random() % 4;
    
//转场动画的核心代码
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是viewController
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //对tempView做动画，避免bug;
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对viewController做动画
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //因为对截图做动画，viewController就可以隐藏了
    fromVC.view.hidden = YES;
    //*****重点的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图*****
    [containerView insertSubview:toVC.view atIndex:0];
    //调用要执行的动画 并将执行的动画效果添加到containerView
    [self transitionWithType:typeArr[num] WithSubtype:subtypeArr[sum] ForView:containerView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //成功以后将viewController的截图tempView隐藏
        tempView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [tempView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
}
//执行pop过渡动画
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //数组中存储的是CATransition对象type效果
    NSArray * typeArr = @[kCATransitionFade,
                          kCATransitionPush,
                          kCATransitionReveal,
                          kCATransitionMoveIn,
                          @"cube",
                          @"suckEffect",
                          @"oglFlip",
                          @"rippleEffect",
                          @"pageCurl",
                          @"pageUnCurl",
                          @"cameraIrisHollowOpen",
                          @"cameraIrisHollowClose"];
    NSInteger num = arc4random() % 12;
    
    //数组中存储的是CATransition对象subtype效果
    NSArray * subtypeArr = @[kCATransitionFromLeft,
                             kCATransitionFromBottom,
                             kCATransitionFromRight,
                             kCATransitionFromTop];
    NSInteger sum = arc4random() % 4;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //拿到push时候的
    UIView *tempView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    [self transitionWithType:typeArr[num] WithSubtype:subtypeArr[sum] ForView:containerView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //tempView.layer.transform = CATransform3DIdentity;
        tempView.alpha = 1;
        fromVC.view.subviews.lastObject.alpha = 1.0;
        //tempView.subviews.lastObject.alpha = 0.0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [tempView removeFromSuperview];
            toVC.view.hidden = NO;
        }
    }];
}

//执行的是什么动画
- (void) transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}
@end
