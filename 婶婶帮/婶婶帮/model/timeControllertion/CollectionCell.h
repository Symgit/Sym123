//
//  CollectionCell.h
//  日期滚动
//
//  Created by 孙月明 on 16/4/22.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *starTime;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@end
