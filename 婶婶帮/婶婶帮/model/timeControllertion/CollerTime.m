//
//  CollerTime.m
//  e家洁1
//
//  Created by 孙月明 on 16/4/28.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "CollerTime.h"
#import "CollectionCell.h"
#import "FoveSCollectionViewCell.h"

#define iPhoneWidth [UIScreen mainScreen].bounds.size.width
#define iPhone6splus 414
#define iPhone6s 375
#define iPhone5s 320

@implementation CollerTime
static NSString * const reuseIdentifier = @"Cell";
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        e = 0;
        i = 0;
        sum = 0;
        timeTwo = 0;
        timeTwend = 0;
        [self ConfigUI];
        
    }
    return self;
}
- (void)AddBtn:(CGRect)rect UIView:(UIView *)viewa{
    view = [[UIView alloc]initWithFrame:rect];
    [view setUserInteractionEnabled:YES];
    [viewa addSubview:view];
    BtnSum = 2.0;
    NSArray * arr = @[@"-",@"2",@"+"];
    for (NSInteger y = 0; y < 3; y++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(y * 44, 3, 44, 44)];
        [btn setTitle:arr[y] forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setBorderWidth:1];
        [btn.layer setBorderColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor];
        [btn setTag:y+1];
        if (btn.tag != 2) {
            btn.titleLabel.font = [UIFont systemFontOfSize:44];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(1, 5, 5, 5)];
        }else{
            [btn setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
        }
        [btn setTitleColor:[UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
}
- (void)addBtn:(UIButton *)btn{
    UIButton * button2 = (UIButton *)[view viewWithTag:2];
    if (BtnSum < 2) {
        BtnSum = 2;
    }
    if (BtnSum > 6) {
        BtnSum = 6;
    }
    if (btn.tag == 3) {
        BtnSum+= 0.5;
        if (BtnSum <= 6) {
            [button2 setTitle:[NSString stringWithFormat:@"%.1f",BtnSum] forState:UIControlStateNormal];
            self.BtnNum = BtnSum;
        }
    }
    if(btn.tag == 1){
        BtnSum -= 0.5;
        if (BtnSum>=2) {
            [button2 setTitle:[NSString stringWithFormat:@"%.1f",BtnSum] forState:UIControlStateNormal];
            self.BtnNum = BtnSum;
        }
    }
    [_collectionView reloadData];
    NSLog(@"self.BtnNum= %f",self.BtnNum);
}
- (void)ConfigUI{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow.minimumLineSpacing = 5;
    flow.minimumInteritemSpacing = 5;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,280) collectionViewLayout:flow];
    [_collectionView setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]];
    if (iPhoneWidth == iPhone6s) {
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }else if(iPhoneWidth == iPhone6splus){
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }else{
        [_collectionView registerNib:[UINib nibWithNibName:@"FoveSCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    
    
    //[_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:<#(nonnull NSString *)#>];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个section有多少个cell(item)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger a = (BtnSum-2)/0.5;
    if (BtnSum == 2) {
        return 21;
    }else{
       return 21-a;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
    if (iPhoneWidth == iPhone6s) {
        CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [self UICollectionCell:cell indexPath:indexPath.item];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 5;
        return cell;
    }else if(iPhoneWidth == iPhone6splus){
        CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [self UICollectionCell:cell indexPath:indexPath.item];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 5;
        return cell;
    }else{
        FoveSCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [self CollectionCell:cell indexPath:indexPath.item];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 5;
        return cell;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (iPhoneWidth == iPhone6s) {
        return CGSizeMake(80,30);
    }else if (iPhoneWidth == iPhone5s){
        return CGSizeMake(70,30);
    }
    return CGSizeMake(95,30);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5,7, 5,7);
}
- (void)UICollectionCell:(CollectionCell *)cell indexPath:(NSInteger)index{
    CGFloat c = self.BtnNum/2;
    NSInteger d = self.BtnNum/2;
    CGFloat f = c-d;//判断是否是30分钟 如果f=0.25  或者等于0.75 则endTime是30分钟
    NSInteger ban = 0;
    NSString * str = @"";
    if (e != 0 && e < self.BtnNum) {
        ban = 30;
    }else{
        ban = 0;
        str = @"00";
    }
    e = self.BtnNum;
    NSInteger b = (index-1)/2;//判断单元格为单数的时候
    
    if (index%2 == 0) {
        if (index == 0) {
            if (e == 0) {
                cell.starLabel.text = [NSString stringWithFormat:@"%d",8];
                //NSLog(@"index= %ld",(long)index);
                cell.endLabel.text = [NSString stringWithFormat:@"%d",10];
            }else{
                cell.endLabel.text = [NSString stringWithFormat:@"%ld",8+e];
            }
            cell.starLabel.text = [NSString stringWithFormat:@"%d",8];
            cell.starTime.text = [NSString stringWithFormat:@"%@",@"00"];
            if (f == 0.25 || f == 0.75) {
                cell.endTime.text = [NSString stringWithFormat:@"%d",30];
            }else{
                cell.endTime.text = [NSString stringWithFormat:@"%@",@"00"];
            }
            
           // NSLog(@"index= %ld",(long)index);
            
        }else{
            if (e == 0) {
                cell.endLabel.text = [NSString stringWithFormat:@"%ld",10+(index/2)];
            }else{
                cell.endLabel.text = [NSString stringWithFormat:@"%ld",8+e+(index/2)];
            }
            cell.starLabel.text = [NSString stringWithFormat:@"%ld",8+(index/2)];
            cell.starTime.text = [NSString stringWithFormat:@"%@",@"00"];
            if (f == 0.25 || f == 0.75) {
                cell.endTime.text = [NSString stringWithFormat:@"%d",30];
            }else{
                cell.endTime.text = [NSString stringWithFormat:@"%@",@"00"];
            }
           // NSLog(@"index= %ld",(long)index);
        }
    }
    else{
        if (b == 0) {
            cell.starLabel.text = [NSString stringWithFormat:@"%d",8];
            cell.starTime.text = [NSString stringWithFormat:@"%d",30];
            if (e == 0) {
                cell.endLabel.text = [NSString stringWithFormat:@"%d",10];
                cell.endTime.text = [NSString stringWithFormat:@"%d",30];
            }else{
                if (f == 0.25 || f == 0.75) {
                    cell.endTime.text = [NSString stringWithFormat:@"%@",@"00"];
                    cell.endLabel.text = [NSString stringWithFormat:@"%ld",8+e+1];
                }else{
                    cell.endTime.text = [NSString stringWithFormat:@"%d",30];
                    cell.endLabel.text = [NSString stringWithFormat:@"%ld",8+e];
                }
            }
            NSLog(@"ddddd= %ld",d);
            NSLog(@"ccccc= %f",c);
        }else{
            
            cell.starLabel.text = [NSString stringWithFormat:@"%ld",8+(b)];
            cell.starTime.text = [NSString stringWithFormat:@"%d",30];
            if (e == 0) {
                cell.endLabel.text = [NSString stringWithFormat:@"%ld",10+(index/2)];
            }else{
                cell.endLabel.text = [NSString stringWithFormat:@"%ld",8+e+(index/2)];
            }
            cell.endTime.text = [NSString stringWithFormat:@"%@",@"30"];
            if (f == 0.25 || f == 0.75) {
                cell.endTime.text = [NSString stringWithFormat:@"%@",@"00"];
                cell.endLabel.text = [NSString stringWithFormat:@"%ld",8+e+(index/2)+1];
            }else{
                cell.endTime.text = [NSString stringWithFormat:@"%d",30];
            }
        }
    }
}
- (void)CollectionCell:(FoveSCollectionViewCell *)cell indexPath:(NSInteger)index{
    if (index%2 == 0 || index == 0) {
        
        cell.starLabel.text = [NSString stringWithFormat:@"%ld",8+(i++)];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
