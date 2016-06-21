//
//  ScollectionView.m
//  table
//
//  Created by 孙月明 on 16/6/18.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "ScollectionView.h"

@implementation ScollectionView
- (instancetype)initWithFrame:(CGRect)frame andImageArr:(NSArray *)ImageArr rollingTimeMode:(rollingTimeMode)mode imageIsBlock:(imageIsBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.rollingTimeMode = mode;
        self.dataSource = [[NSMutableArray alloc]init];
        [self.dataSource addObjectsFromArray:ImageArr];
        self.imageBlock = block;
        self.imageView = [[UIImageView alloc]init];
        self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.imageView setImage:[UIImage imageNamed:@"1"]];
        [self.imageView setUserInteractionEnabled:YES];
        [self addSubview:self.imageView];
        [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
    }
    return self;
}
#pragma mark 每张图片停留的时间
- (void)setCurrtionTime:(CGFloat)currtionTime{
    _currtionTime = currtionTime;
}

- (void)setTime:(NSTimeInterval)time{
    _time = time;
    [self startAnimation];
}
#pragma mark 开启滚动
-(void)startAnimation{
    if (self.rollingTimeMode == rollingTimeModeIsOne) {
        [self opertionQueue];
    }else{
        [self rollingTimeMode];
    }
}
- (void)rollTimeindex{//方法二
    if (self.dataSource.count <= 1) return;
    if (self.timer) [self stopAnimation];
    self.timer = [NSTimer timerWithTimeInterval:self.currtionTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
#pragma mark 第二种滚动方法的
- (void)stopAnimation{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)opertionQueue{//方法一
    __block NSInteger timeout= self.dataSource.count * self.currtionTime ; //倒计时时间
    //_bbbbb.
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer1 = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer1,dispatch_walltime(NULL, 0),self.currtionTime * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer1, ^{
        if(timeout<0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer1);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self imageViewString:[NSString stringWithFormat:@"%f",timeout/self.currtionTime ]];
                self.currtionIndex = timeout/self.currtionTime ;
                [self transitionWithType:kCATransitionFade WithSubtype:kCATransitionFromLeft ForView:self];
            });
            timeout-= self.currtionTime ;
        }
        if (timeout < 1) {
            timeout = self.dataSource.count * self.currtionTime;
        }
    });
    dispatch_resume(_timer1);
}
- (void)nextPage{
    static NSInteger sum = 0;
    if (sum < self.dataSource.count) {
        //NSLog(@"%ld",sum);
        [self imageViewString:[NSString stringWithFormat:@"%ld",sum+1]];
        self.currtionIndex = sum;
        sum++;
    }else{
        sum = 0;
    }
    [self transitionWithType:kCATransitionFade WithSubtype:kCATransitionFromLeft ForView:self];
}
- (void)imageViewString:(NSString *)imageStr{
    if ([self isBlankString:imageStr]) {
        [self.imageView setImage:[UIImage imageNamed:@"im"]];
    }else{
        [self.imageView setImage:[UIImage imageNamed:imageStr]];
    }
}

- (void) transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.5f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [self.imageView.layer addAnimation:animation forKey:@"animation"];
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#pragma mark 图片点击事件
- (void)imageClick {
    !self.imageBlock?:self.imageBlock(self.currtionIndex);
}
@end
