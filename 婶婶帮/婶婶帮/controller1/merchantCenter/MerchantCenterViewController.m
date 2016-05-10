//
//  MerchantCenterViewController.m
//  e家洁1
//
//  Created by 孙月明 on 16/5/4.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "MerchantCenterViewController.h"
#import "MerchantCenterCell.h"
#import "MerchantCenterReusableView.h"
#import "UIImageView+WebCache.h"
#import "EnderViewController.h"
#import <CoreText/CoreText.h>
#import "CLPopViewController.h"
#import "SSBDaytimeViewController.h"
#import "SSBFamilyViewController.h"
#import "SSBLandReclamationViewController.h"
#import "SSBWipeGlassViewController.h"
#import "SSBLatestViewController.h"
#import "LZPageViewController.h"
#import "Header.h"

#define cellSpacing 20
#define Coll_width (W_with -60)/2
#define MySectionHeight H_height - 3 *cellSpacing - 2* Coll_width - 68

@interface MerchantCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIPopoverPresentationControllerDelegate>
{
    NSArray * imageArr;
}
@property (nonatomic,strong) CLPopViewController *itemPopVC;//商户中心的下拉菜单
@property (nonatomic,strong)UICollectionView * collectionView;
@end

@implementation MerchantCenterViewController

static NSString * const reuseIdentifier = @"Cell";
- (NSArray *)fontSamples{
    if (_fontSamples == nil) {
        _fontSamples = [[NSArray alloc] initWithObjects:
                            @"最新订单",
                            @"获取客户订单",
                            @"未获取客户订单",
                            @"已完成订单",
                            nil];
    }
    return _fontSamples;
}
- (void)viewWillAppear:(BOOL)animated{
//    self.fontNames = [[NSArray alloc] initWithObjects:
//                      @"STXingkai-SC-Light",
//                      @"DFWaWaSC-W5",
//                      @"FZLTXHK--GBK1-0",
//                      @"STLibian-SC-Regular",
//                      nil];//@"LiHeiPro", @"HiraginoSansGB-W3",
    
    imageArr = @[@"one",
                 @"one1",
                 @"shenghuo",
                 @"btnImage1"];
    NSUserDefaults * usr = [NSUserDefaults standardUserDefaults];
    if (![usr objectForKey:@"openid"]) {
        EnderViewController * ender = [[EnderViewController alloc]init];
        [self.navigationController pushViewController:ender animated:YES];
    }else{
        NSDictionary * dic = [usr objectForKey:@"dic"];
        NSLog(@"%@",dic);
        self.imageUrl = [dic objectForKey:@"headimgurl"];
        self.nameStr = [dic objectForKey:@"user_login"];
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"商户中心"];
    [self collectionV];
    [self nav];
    // Do any additional setup after loading the view.
}
- (void)nav{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"setUp"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightBar];
    
}
- (void)navBtn{
    self.itemPopVC = [[CLPopViewController alloc] initWithNibName:@"CLPopViewController" bundle:nil];
    self.itemPopVC.modalPresentationStyle = UIModalPresentationPopover;
    self.itemPopVC.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    self.itemPopVC.preferredContentSize=CGSizeMake(150, 44*4);
    //箭头方向
    self.itemPopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //代理
    self.itemPopVC.popoverPresentationController.delegate = self;
    [self presentViewController:self.itemPopVC animated:YES completion:nil];
}
- (void)collectionV{//导航条设置按钮的点击事件
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = cellSpacing;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, W_with, H_height - 64) collectionViewLayout:flow];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [collectionView registerClass:[MerchantCenterCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [collectionView registerClass:[MerchantCenterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    NSLog(@"%@",controller);
    return  UIModalPresentationNone;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MerchantCenterCell * coll = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self asynchronouslySetFontName:@"DFWaWaSC-W5" merChant:coll indexPath:indexPath.item];
    [coll.imageView setImage:[UIImage imageNamed:imageArr[indexPath.item]]];
    //coll.label.text = self.fontSamples[indexPath.item];
    return coll;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        LZPageViewController *pageVc = [[LZPageViewController alloc] initWithTitles:@[@"日间陪护",@"家庭保洁",@"开荒保洁",@"擦玻璃",] controllersClass:@[[SSBDaytimeViewController class],[SSBFamilyViewController class],[SSBLandReclamationViewController class],[SSBWipeGlassViewController class]]];
        [self.navigationController pushViewController:pageVc animated:YES];
    }else{
        SSBLatestViewController *pageVc = [[SSBLatestViewController alloc]initWithTitle:[self fontSamples][indexPath.item]];
        [self.navigationController pushViewController:pageVc animated:YES];
    }
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, cellSpacing, cellSpacing, cellSpacing);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Coll_width, Coll_width);
}
//单元格的section
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    MerchantCenterReusableView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        sectionView.backgroundColor = [UIColor purpleColor];
        
        [self createTap:sectionView.imageView];
        [UIView animateWithDuration:4 animations:^{
            [sectionView.imageView setAlpha:1];
        [sectionView.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"4"]];
            sectionView.label.frame = CGRectMake(sectionView.center.x-120, sectionView.center.y+50, 240, 35);
            [sectionView.label setAlpha:1];
            [sectionView.label setText:[NSString stringWithFormat:@"昵称：%@",self.nameStr]];
        }];
        
    }
    
    return sectionView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(W_with,MySectionHeight);
}

//改变字体样式
- (void)asynchronouslySetFontName:(NSString *)fontName merChant:(MerchantCenterCell *)coll indexPath:(NSInteger)index
{
    UIFont* aFont = [UIFont fontWithName:fontName size:12.];
    // If the font is already downloaded
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        // Go ahead and display the sample text.
        NSUInteger sampleIndex = [_fontNames indexOfObject:fontName];
        coll.label.text = [_fontSamples objectAtIndex:sampleIndex];
        coll.label.font = [UIFont fontWithName:fontName size:20.];
        return;
    }
    
    // Create a dictionary with the font's PostScript name.
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    // Create a new font descriptor reference from the attributes dictionary.
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    
    // Start processing the font descriptor..
    // This function returns immediately, but can potentially take long time to process.
    // The progress is notified via the callback block of CTFontDescriptorProgressHandler type.
    // See CTFontDescriptor.h for the list of progress states and keys for progressParameter dictionary.
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show an activity indicator
               coll.label.text = [self fontSamples][index];
                coll.label.font = [UIFont fontWithName:fontName size:20.];
                
                // Show something in the text view to indicate that we are downloading
                
                
                NSLog(@"Begin Matching");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the activity indicator
                
                
                // Display the sample text for the newly downloaded font
                //NSUInteger sampleIndex = [_fontNames indexOfObject:fontName];
                coll.label.text = [self fontSamples][index];
                coll.label.font = [UIFont fontWithName:fontName size:20.];
                // Log the font URL in the console
                CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, 0., NULL);
                CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
                NSLog(@"%@", (__bridge NSURL*)(fontURL));
                CFRelease(fontURL);
                CFRelease(fontRef);
                
                if (!errorDuringDownload) {
                    NSLog(@"%@ downloaded", fontName);
                }
            });
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show a progress bar
                
                NSLog(@"Begin Downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the progress bar
                
                NSLog(@"Finish downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Use the progress bar to indicate the progress of the downloading
                
                NSLog(@"Downloading %.0f%% complete", progressValue);
            });
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            // An error has occurred.
            // Get the error message
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                _errorMessage = [error description];
            } else {
                _errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // Set our flag
            errorDuringDownload = YES;
            
            dispatch_async( dispatch_get_main_queue(), ^ {
                NSLog(@"Download error: %@", _errorMessage);
            });
        }
        return (bool)YES;
    });
    
}
//点击手势
-(void)createTap:(UIImageView *)imageView{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tap];
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
