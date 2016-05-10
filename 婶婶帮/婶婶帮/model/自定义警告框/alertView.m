//
//  alertView.m
//  自定义Btn
//
//  Created by corepass on 15/9/23.
//  Copyright (c) 2015年 corepass. All rights reserved.
//

#import "alertView.h"

@implementation alertView
{
    BOOL _isShow;
}
- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, w_width, h_height + 20)];
    if (self)
    {
        _isShow = NO;
    }
    return self;
}
//单例
+ (alertView *)defaultAlert
{
    static alertView *shareCenter = nil;
    if (!shareCenter) {
        shareCenter = [[alertView alloc]init];
    }
    return shareCenter;
}
- (id)initWithTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super initWithFrame:CGRectMake(0, 0, w_width, h_height + 20)];
    if(self){
        if(self.isNeedLabel == YES){
            title = self.title;
            message = self.message;
        }
        delegate = self.delegate;
        cancelButtonTitle = self.cancelButtonTitle;
        if(!otherButtonTitles){
            va_list lest;
            if(otherButtonTitles){
                self.otherButtonTitles = [NSMutableArray array];
                [self.otherButtonTitles addObject:otherButtonTitles];
            }
            va_start(lest, otherButtonTitles);
            id str;
            while ((str = va_arg(lest, id))){
                [self.otherButtonTitles addObject:str];
            }
        }
    }
    return self;
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (void)show
{
    [self layoutSubviews];
    if (!_isShow)
        [[[UIApplication sharedApplication].delegate window]  addSubview:self];
    _isShow = YES;
    
}
//添加自定义控件
- (void)addSubviews:(UIView *)view
{
    [self.dataSource addObject:view];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    if (self.isNeedLabel == NO) {
     }
        //警告框的背景
    UIView * view = [[UIView alloc]initWithFrame:self.frame];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.alpha = 0.5;
    [self addSubview:view];
    self.aview = [[UIView alloc]init];
    //模拟警告框
    _aview.layer.frame = CGRectMake(0, 0, 280, 200);
    _aview.opaque = NO;
    _aview.backgroundColor = [UIColor whiteColor];
    _aview.layer.shadowOffset = CGSizeMake(1, 1);
    _aview.layer.shadowRadius = 2.0;
    _aview.layer.shadowColor = [UIColor whiteColor].CGColor;
    _aview.layer.shadowOpacity = 0.8;
    [_aview.layer setMasksToBounds:NO];
    //_aview.frame = CGRectMake(0, 0, 300, 200);
    //_aview.backgroundColor = [UIColor redColor];
    //头标题
    UIView *HeadView = [[UIView alloc] init];
    HeadView.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]init];
    //label.frame = CGRectMake(0, 0, 100, 45);
    label.textAlignment = NSTextAlignmentCenter;
    //label.center = HeadView.center;
    label.font = [UIFont systemFontOfSize:20.0f weight:0.5f];
    label.textColor = [UIColor blackColor];
    //头部的副标题
    UILabel * label1 = [[UILabel alloc]init];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:14.0f];
    label1.textColor = [UIColor blackColor];
    //label.text = self.title;
    if (_title != nil && _message != nil) {
        HeadView.frame = CGRectMake(0, 0, 280, 70);
        label.frame = CGRectMake(0, 0, 280, 35);
        label1.frame = CGRectMake(0, 40, 280, 24);
        label.text = self.title;
        label1.text = self.message;
    }else if (_title != nil && _message == nil){
        HeadView.frame = CGRectMake(0, 0, 280, 40);
        label.frame = CGRectMake(0, 0, 280, 35);
        label.text = self.title;
    }else if(_title == nil && _message != nil){
        HeadView.frame = CGRectMake(0, 0, 280, 70);
        label1.frame = CGRectMake(0, 40, 280, 24);
        label1.text = self.message;
    }else{
        NSLog(@"没有添加提示");
    }
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, HeadView.frame.size.height - 1, 280, 1)];
    //label3.backgroundColor = [UIColor blackColor];
    [HeadView addSubview:label3];
    [HeadView addSubview:label];
    [HeadView addSubview:label1];
    [_aview addSubview:HeadView];
    //添加自定义控件
    UIView * mView = [[UIView alloc]init];
    if (self.dataSource && [self.dataSource count] > 0)
    {
        CGFloat startY = 0;
        for (UIView * subview in self.dataSource) {
            CGRect rect = subview.frame;
            rect.origin.y = startY;
            subview.frame = rect;
            [mView addSubview:subview];
            startY += rect.size.height;
        }
         mView.frame = CGRectMake(0, HeadView.frame.size.height, 280, startY);
    }else if ([self.dataSource count] <= 0){
        mView.frame = CGRectMake(0, 0, 0, 0);
    }
    [_aview addSubview:mView];
    
    //警告框的按钮
    UIButton * btn = [[UIButton alloc]init];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //btn和btn1的背景View的View：将每一个btn都添加到一个view上面并且将这些个view添加在backView上面
    UIView * backView = [[UIView alloc]init];
    //btn和btn1的背景View
    UIView * view1 = [[UIView alloc]init];
    UIView * view2 = [[UIView alloc]init];
    //backView.backgroundColor = [UIColor redColor];
    CGFloat msg_h = mView.frame.size.height;
    CGFloat Head_h = HeadView.frame.size.height;
    if (_cancelButtonTitle && _otherButtonTitles.count!= 0) {
        [btn setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        if (_otherButtonTitles.count>1) {
            CGFloat rectF = (_otherButtonTitles.count + 1)*35 + Head_h + msg_h;
            
            _aview.frame = CGRectMake(0, 0, 280, rectF);
            backView.frame = CGRectMake(0, Head_h+ msg_h, 280, _aview.frame.size.height - Head_h- msg_h);
            view1.frame = CGRectMake(0, backView.frame.size.height - 35, 280, 35);
            view1.backgroundColor = [UIColor blackColor];
            btn.frame = CGRectMake(0, 1, 280, 34);
            btn.backgroundColor = [UIColor whiteColor];
            view2.frame = CGRectMake(0, 0, 280, _otherButtonTitles.count * 35);
            for (NSInteger i = 0; i < _otherButtonTitles.count; i++) {
               UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                btn1.frame = CGRectMake( 0, i*35, 280, 34);
                NSString * string = self.otherButtonTitles[i];
                [btn1 setTitle:string forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, btn1.frame.size.height, 280, 1)];
                label.backgroundColor = [UIColor blackColor];
                [view2 addSubview:label];
                [view2 addSubview:btn1];
                
            }
        }else if (_otherButtonTitles.count == 1){
            UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            //_aview = [[UIView alloc]init];
            _aview.frame = CGRectMake(0, 0, 280, Head_h + msg_h + 35);
            backView.frame = CGRectMake(0, Head_h + msg_h, 280, 35);
            //backView.backgroundColor = [UIColor redColor];
            view1.frame = CGRectMake(0, 0, 140, 35);
            view1.backgroundColor = [UIColor blackColor];
            view2.frame = CGRectMake(140, 0, 140, 35);
            btn.frame = CGRectMake(0, 1, 139, 34);
            btn.backgroundColor = [UIColor whiteColor];
            btn2.frame = CGRectMake(0.5f, 1, 140, 35);
            btn2.backgroundColor = [UIColor whiteColor];
            [btn2 setTitle:self.otherButtonTitles[0] forState:UIControlStateNormal];
            UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width, 0, 1, 35)];
            [btn2 addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            //label.backgroundColor = [UIColor blackColor];
            [view1 addSubview:label2];
            view2.backgroundColor = [UIColor blackColor];
            
            [view2 addSubview:btn2];
        }
    }else if (_cancelButtonTitle && _otherButtonTitles.count== 0){
        _aview.frame = CGRectMake(0, 0, 280, Head_h + msg_h + 45);
        backView.frame = CGRectMake(0, Head_h + msg_h, 280, 45);
        view1.frame = CGRectMake(0, 0, 280, 45);
        btn.frame = CGRectMake(0, 0.5f, 280, 44.5f);
        btn.backgroundColor = [UIColor whiteColor];
        
        view1.backgroundColor = [UIColor blackColor];
        view1.userInteractionEnabled = YES;
        [btn setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        NSLog(@"dsfsd");
    }
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn];
    [backView addSubview:view1];
    [backView addSubview:view2];
    [_aview addSubview:backView];
    UIControl *touchView = [[UIControl alloc] initWithFrame:self.frame];
    [touchView addTarget:self action:@selector(touchViewClickDown) forControlEvents:UIControlEventTouchDown];
    touchView.frame = self.frame;
    
    [self addSubview:touchView];
    [alertView exChangeOut:_aview TimeInterval:0.5];
    [self addSubview:_aview];
    _aview.center = self.center;
    if (!_isShow)
    
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(willPresentCustomAlertView:)])
        {
            [self.delegate willPresentCustomAlertView:self];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:kBCAlertViewPresentNotify object:nil userInfo:nil];
    }
}
- (void)touchViewClickDown
{
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(hideCurrentKeyBoard)])
        {
            [self.delegate hideCurrentKeyBoard];
        }
    }
}
- (void)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    _isShow = NO;
    if (btn)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
        {
            [self.delegate alertView:self clickedButtonAtIndex:btn.tag];
        }
        [self removeFromSuperview];
    }
}
- (void)closeBtnClicked:(id)sender
{
    _isShow = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewClosed:)])
    {
        [self.delegate alertViewClosed:self];
    }
    [self removeFromSuperview];
}
+ (void)exChangeOut:(UIView *)changeOutView TimeInterval:(CFTimeInterval)terval
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = terval;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 2.0)]];
    
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
}
@end
