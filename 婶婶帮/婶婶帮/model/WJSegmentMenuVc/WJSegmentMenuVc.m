//
//  WJSegmentMenuVc.m
//  WJSegmentMeunVc
//
//  Created by 吴计强 on 16/4/5.
//  Copyright © 2016年 com.firsttruck. All rights reserved.
//


#define WJSegmentMenuVcDefaultSpace             1
#define WJSegmentMenuVcDefaulTag                960
#define WJSegmentMenuVcDefaulButtonW            CGRectGetWidth([UIScreen mainScreen].bounds)/self.integer
#define WJSegmentMenuVcDefaultButtonFont        [UIFont systemFontOfSize:12]
#define WJSegmentMenuVcDefaultUnselectedColor   [UIColor darkGrayColor]
#define WJSegmentMenuVcDefaultSelectedColor     [UIColor greenColor]
#define WJSegmentMenuVcDefaultSlideColor        [UIColor greenColor]

#import "WJSegmentMenuVc.h"

@interface WJSegmentMenuVc ()<UIScrollViewDelegate>
{
    UIScrollView *scrollViewContent;
    UIScrollView *scrollView1;
}
@property (nonatomic,weak)   UIView         *view;
@property (nonatomic,weak)   UIScrollView   *contentScrollView;
@property (nonatomic,strong) NSMutableArray *vcArray;
@property (nonatomic,strong) NSMutableArray *titlesArray;
@property (nonatomic,weak)   UIScrollView   *titleScrollView;


@property (nonatomic,assign) NSInteger      lastSelected;


@end

@implementation WJSegmentMenuVc
// 导入数据
- (void)addSubVc:(NSArray *)vc subTitles:(NSArray *)titles{
    self.lastSelected = -1;
    self.vcArray = [[NSMutableArray alloc]init];
    [self.vcArray addObjectsFromArray:vc];
    self.titlesArray = [NSMutableArray array];
    [self.titlesArray addObjectsFromArray:titles];
    [self initContentScrollview];
    [self initScrollviewWithTitles:titles];
}

// 初始化ContentScrollview
- (void)initContentScrollview{
    
    scrollViewContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), self.superview.frame.size.width, self.superview.frame.size.height - CGRectGetMaxY(self.frame))];
    scrollViewContent.delegate = self;
    scrollViewContent.bounces = NO;
    scrollViewContent.contentSize = CGSizeMake(self.superview.frame.size.width * self.vcArray.count,  self.superview.frame.size.height - CGRectGetMaxY(self.frame));
    scrollViewContent.showsHorizontalScrollIndicator = NO;
    scrollViewContent.showsVerticalScrollIndicator = NO;
    scrollViewContent.pagingEnabled = YES;
    [self.superview addSubview:scrollViewContent];
    self.contentScrollView = scrollViewContent;
}

// 初始化titleScrollView
- (void)initScrollviewWithTitles:(NSArray *)titles{
    scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //CGRectGetWidth([UIScreen mainScreen].bounds)/3
    scrollView1.contentSize = CGSizeMake((WJSegmentMenuVcDefaulButtonW) * titles.count , self.frame.size.height);
    scrollView1.showsHorizontalScrollIndicator = NO;
    scrollView1.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView1];
    self.titleScrollView = scrollView1;

    for (int i = 0; i < titles.count; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(WJSegmentMenuVcDefaultSpace + (WJSegmentMenuVcDefaulButtonW + WJSegmentMenuVcDefaultSpace) * i, WJSegmentMenuVcDefaultSpace, WJSegmentMenuVcDefaulButtonW, self.frame.size.height - WJSegmentMenuVcDefaultSpace * 2)];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        UIColor *color = self.unlSelectedColor ? self.unlSelectedColor : WJSegmentMenuVcDefaultUnselectedColor;
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.titleLabel.font = self.titleFont ? self.titleFont : WJSegmentMenuVcDefaultButtonFont;
        NSInteger tag = self.MenuButtontag ? self.MenuButtontag : WJSegmentMenuVcDefaulTag;
        btn.tag = tag + i;
        [btn addTarget:self action:@selector(segmentMenuTitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addChildViewController:self.vcArray[i] title:titles[i]];
        UIColor *slideColor = self.SlideColor ? self.SlideColor : WJSegmentMenuVcDefaultSlideColor;
        if (i == 0) {
            if (self.MenuVcSlideType == WJSegmentMenuVcSlideTypeCaver) {
                UIView *view = [[UIView alloc]initWithFrame:btn.frame];
                view.backgroundColor = slideColor;
                view.layer.cornerRadius = 10;
                view.layer.masksToBounds = YES;
                [scrollView1 addSubview:view];
                self.view = view;
            }
            if (self.MenuVcSlideType == WJSegmentMenuVcSlideTypeSlide) {
                CGRect TempFrame = btn.frame;
                TempFrame.size.height = 1;
                if (self.vcInteger != 0) {
                    TempFrame.origin.x = WJSegmentMenuVcDefaultSpace + (WJSegmentMenuVcDefaulButtonW + WJSegmentMenuVcDefaultSpace) * self.vcInteger;
                }
                TempFrame.origin.y = CGRectGetMaxY(btn.frame);
                UIView *view = [[UIView alloc]initWithFrame:TempFrame];
                view.backgroundColor = slideColor;
                view.layer.cornerRadius = 10;
                view.layer.masksToBounds = YES;
                [scrollView1 addSubview:view];
                self.view = view;
            }
            [self addChildView:i];
        }
        if (i == 1 && self.advanceLoadNextVc) {
            [self addChildView:i];
        }
        [scrollView1 addSubview:btn];
        if (i == 2 && self.advanceLoadNextVc) {
            [self addChildView:i];
            [self changeBtnTitleColorWithTag:self.vcInteger];
            [self.contentScrollView setContentOffset:CGPointMake((self.vcInteger)*self.contentScrollView.frame.size.width, 0) animated:YES];
        }
    }
    
}

// 视图控制器
- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

// 添加子子控制器
-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle{
    UIViewController *superVC = [self findViewController:self];
    childVC.title = vcTitle;
    [superVC addChildViewController:childVC];
}

// 添加子控制器视图
- (void)addChildView:(NSInteger)index{
    
    UIViewController *superVC = [self findViewController:self];
    UIViewController *vc = superVC.childViewControllers[index];
    CGRect frame = self.contentScrollView.bounds;
    frame.origin.x = self.superview.frame.size.width * index;
    vc.view.frame = frame;
    [self.contentScrollView addSubview:vc.view];
}

// 按钮点击事件
- (void)segmentMenuTitleClick:(UIButton *)btn{
    NSInteger tag = self.MenuButtontag ? self.MenuButtontag : WJSegmentMenuVcDefaulTag;
    [self changeBtnTitleColorWithTag:btn.tag-tag];
    [self buttonMoveWithIndex:btn.tag - tag];
    [self viewFrameAutoWith:self.view.frame];
    [self addChildView:btn.tag - tag];
    self.contentScrollView.contentOffset = CGPointMake(self.superview.frame.size.width * (btn.tag - tag), 0);
}

// titleScrollView frame自适应
- (void)viewFrameAutoWith:(CGRect)frame{
    CGRect tempFrame = frame;
    CGFloat MaxX = CGRectGetMaxX(tempFrame);
    CGFloat conteentOffX = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
    CGFloat MinX = CGRectGetMinX(tempFrame);
    if (MaxX >= self.superview.frame.size.width - WJSegmentMenuVcDefaultSpace * 2) {
        [self.titleScrollView setContentOffset:CGPointMake(conteentOffX, 0) animated:YES];
    }
    if (MinX - WJSegmentMenuVcDefaultSpace *2 <= conteentOffX) {
        [self.titleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

// 改变菜单按钮字体颜色
- (void)changeBtnTitleColorWithTag:(NSInteger)tag{
    UIColor *color = self.unlSelectedColor ? self.unlSelectedColor : WJSegmentMenuVcDefaultUnselectedColor;
    UIColor *selectedColor = self.selectedColor ? self.selectedColor : WJSegmentMenuVcDefaultSelectedColor;
    NSInteger Temptag = self.MenuButtontag ? self.MenuButtontag : WJSegmentMenuVcDefaulTag;
    if (self.lastSelected >= 0) {
        UIButton *lastBtn = (UIButton *)[self viewWithTag:self.lastSelected + Temptag];
        [lastBtn setTitleColor:color forState:UIControlStateNormal];
    }
    UIButton *btn = (UIButton *)[self viewWithTag:tag + Temptag];
    [btn setTitleColor:selectedColor forState:UIControlStateNormal];
    self.lastSelected = tag;
}

// scrollView滚动监听
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i  = self.contentScrollView.contentOffset.x / self.superview.frame.size.width;
    NSLog(@"sc= %ld",i);
    [self changeBtnTitleColorWithTag:i];
    [self addChildView:i];
    [self buttonMoveWithIndex:i];
    [self viewFrameAutoWith:self.view.frame];
    if (i < self.vcArray.count - 1 && self.advanceLoadNextVc) {
    [self addChildView:i+1];
    }
}

// 滑块移动动画
- (void)buttonMoveWithIndex:(NSInteger)clickIndex{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect tempFrame = self.view.frame;
        tempFrame.origin.x = WJSegmentMenuVcDefaultSpace + (WJSegmentMenuVcDefaulButtonW + WJSegmentMenuVcDefaultSpace) * clickIndex;
        self.view.frame = tempFrame;
    }];
    
}
@end
