//
//  CollerTime.h
//  e家洁1
//
//  Created by 孙月明 on 16/4/28.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollerTime : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSInteger i;
    NSInteger sum;
    NSInteger timeTwo;
    NSInteger timeTwend;
    CGFloat BtnSum;
    UIView * view;
    NSInteger e;
}
@property (nonatomic,assign) CGFloat BtnNum;
@property (nonatomic,assign) CGFloat cellNum;
- (void)AddBtn:(CGRect)rect UIView:(UIView *)viewa;
@end
