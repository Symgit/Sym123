//
//  ViewController.m
//  3D动画效果
//
//  Created by 孙月明 on 16/6/3.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, play3D){
    play3DTypeIsScale = 0,
    play3DTypeIsRotate,
    play3DTypeIsTranslation,
    play3DTypeIsTogether,
    play3DTypeIsEsc
};

@interface ViewController ()
@property (assign, nonatomic)play3D play3dType;
@property (strong, nonatomic)UIImageView * imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sum"]];
    [_imageView setFrame:CGRectMake(0, 0, 200, 150)];
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    [self CATransform3DBtn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)CATransform3DBtn{
    NSArray * formArr = @[@"3D旋转",@"3D平移",@"3D缩放",@"三个合集",@"回复原样"];
    for (NSInteger i = 0; i < 5; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 4*75)/4;
        [btn setTag:i+1];
        if (btn.tag == 5) {
            [btn setFrame:CGRectMake(self.view.center.x - 38, _imageView.frame.origin.y + _imageView.frame.size.height + 100, 75, 35)];
        }else{
            [btn setFrame:CGRectMake(i*width + i * 75, 64, 75, 35)];
        }
        [btn setTitle:formArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:43/255.0f green:168/255.0f blue:62/255.0f alpha:1]];
        [btn addTarget:self action:@selector(Transform3DBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)Transform3DBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
            _play3dType = play3DTypeIsRotate;
            [self CATransform3DView];
            break;
        case 2:
            _play3dType = play3DTypeIsTranslation;
            [self CATransform3DView];
            break;
        case 3:
            _play3dType = play3DTypeIsScale;
            [self CATransform3DView];
            break;
        case 4:
            _play3dType = play3DTypeIsTogether;
            [self CATransform3DView];
            break;
        case 5:
            _play3dType = play3DTypeIsEsc;
            [self CATransform3DView];
            break;
            
        default:
            break;
    }
}
- (void)CATransform3DView{
    CABasicAnimation * theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    if (_play3dType == play3DTypeIsRotate) {
        CATransform3D transform = CATransform3DMakeRotation(M_PI, 1, 1, 1);//旋转
         NSValue *value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setToValue:value];
    }else if(_play3dType == play3DTypeIsTranslation){
        CATransform3D transform = CATransform3DMakeTranslation(20, 20, 150);//3D平移，在平移的时候z轴平移的距离是无效的
        NSValue *value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setToValue:value];
    }else if (_play3dType == play3DTypeIsScale){
        CATransform3D transform = CATransform3DMakeScale(0.2, 0.2, 0.2);//缩进
        NSValue *value = [NSValue valueWithCATransform3D:transform];
        [theAnimation setToValue:value];
    }else if (_play3dType == play3DTypeIsTogether){
        CATransform3D rotateTransform = CATransform3DMakeRotation(M_PI, 1, 1, -1);
        CATransform3D scaleTransform = CATransform3DMakeScale(0.2, 0.2, 0.2);
        CATransform3D positionTransform = CATransform3DMakeTranslation(0, 0, 0); //位置移动
        CATransform3D combinedTransform =CATransform3DConcat(rotateTransform, scaleTransform); //Concat就是combine的意思
        combinedTransform = CATransform3DConcat(combinedTransform, positionTransform);
        
        [_imageView.layer setTransform:combinedTransform];//如果没有这句，layer执行完动画又会返回最初的state
        //-------------------------------//
        
    }else{
        CATransform3D rotateTransform1 = CATransform3DMakeRotation(0, 1, 1, 1);
        CATransform3D scaleTransform1 = CATransform3DMakeScale(1, 1, 1);
        CATransform3D positionTransform1 = CATransform3DMakeTranslation(0, 0, 0); //位置移动
        CATransform3D combinedTransform1 =CATransform3DConcat(rotateTransform1, scaleTransform1); //Concat就是combine的意思
        combinedTransform1 = CATransform3DConcat(combinedTransform1, positionTransform1);
        NSValue *value = [NSValue valueWithCATransform3D:combinedTransform1];
        [theAnimation setFromValue:value];
        [_imageView.layer setTransform:combinedTransform1];//如果没有这句，layer执行完动画又会返回最初的state
    }
    [theAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];//放在3D坐标系中最正的位置
    [theAnimation setAutoreverses:YES];  //原路返回的动画一遍
    [theAnimation setDuration:1.0];
    [theAnimation setRepeatCount:3];
    [_imageView.layer addAnimation:theAnimation forKey:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
