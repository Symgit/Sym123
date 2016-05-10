//
//  alertView.h
//  自定义Btn
//
//  Created by corepass on 15/9/23.
//  Copyright (c) 2015年 corepass. All rights reserved.
//

#define w_width [UIScreen mainScreen].bounds.size.width
#define h_height [UIScreen mainScreen].bounds.size.height
#define kBCAlertViewPresentNotify   @"kBCAlertViewPresentNotify"
#import <UIKit/UIKit.h>

@class alertView;
@protocol CustomAlertViewDelegate <NSObject>
@optional
-(void)alertView:(alertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)alertViewClosed:(alertView *)alertView;
-(void)willPresentCustomAlertView:(UIView *)alertView;
- (void)hideCurrentKeyBoard;
@end

@interface alertView : UIView
@property(nonatomic,assign) id <CustomAlertViewDelegate> delegate;
@property(nonatomic,assign)BOOL isNeedLabel;
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * message;
@property(nonatomic,strong) NSString * cancelButtonTitle;
@property(nonatomic,retain) NSMutableArray * otherButtonTitles;
@property(nonatomic,strong) UIView * aview;
@property(nonatomic,copy) NSMutableArray * dataSource;
- (id)initWithTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)show;
+ (void)exChangeOut:(UIView *)changeOutView TimeInterval:(CFTimeInterval)terval;
- (void)addSubviews:(UIView *)view;
+ (alertView *)defaultAlert;
@end
