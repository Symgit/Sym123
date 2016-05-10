//
//  cleanBtn.m
//  创建一个圆的按钮UIButton
//
//  Created by corepass on 15/11/13.
//  Copyright © 2015年 corepass. All rights reserved.
//

#import "cleanBtn.h"

@implementation cleanBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat width = 40;
    CGFloat height = 47;
    
    // 这里一定要用contentRect来取得按钮的尺寸，不能使用self.frame
    CGFloat x = (contentRect.size.width - width)/2;
    
    CGFloat y = 30;
    return CGRectMake(x, y, width, height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
