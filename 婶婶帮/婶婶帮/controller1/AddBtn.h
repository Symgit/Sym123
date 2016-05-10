//
//  AddBtn.h
//  e家洁1
//
//  Created by 孙月明 on 16/4/27.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollerTime.h"
@interface AddBtn : UIView
{
    CollerTime * coll;
    CGFloat sum;
}
@property (nonatomic,assign) CGFloat BtnNum;
-(CGFloat)addBtn;
@end
