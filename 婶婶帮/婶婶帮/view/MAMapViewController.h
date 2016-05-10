//
//  MAMapViewController.h
//  e家洁1
//
//  Created by 孙月明 on 16/4/21.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CustomCity)(NSString * CityStr);
@interface MAMapViewController : UIViewController
@property (nonatomic,strong)CustomCity cityBlock;
- (void)setLoctionIsCity:(CustomCity)city;
@end
