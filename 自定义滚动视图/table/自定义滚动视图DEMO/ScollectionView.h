//
//  ScollectionView.h
//  table
//
//  Created by 孙月明 on 16/6/18.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, rollingTimeMode){
    rollingTimeModeIsOne = 0,
    rollingTimeModeIsTwo
};

typedef void(^imageIsBlock)(NSInteger index);

@interface ScollectionView : UIView

@property (nonatomic, strong)NSMutableArray *dataSource;//存储图片的数组
@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, copy)imageIsBlock imageBlock;
@property (nonatomic, assign)NSInteger currtionIndex;//第几张图片
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign)rollingTimeMode rollingTimeMode;
@property (nonatomic, assign)CGFloat currtionTime;//每张图片停留的时间

- (instancetype)initWithFrame:(CGRect)frame andImageArr:(NSArray *)ImageArr rollingTimeMode:(rollingTimeMode)mode imageIsBlock:(imageIsBlock)block;
//- (void)startScroll;
- (void)startAnimation;//开始循环
- (void)stopAnimation;//停止循环
@end
