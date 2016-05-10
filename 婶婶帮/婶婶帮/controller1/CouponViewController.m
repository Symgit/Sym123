//
//  CouponViewController.m
//  e家洁
//
//  Created by 孙月明 on 16/4/5.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "CouponViewController.h"
#import "EnderViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Header.h"
#import "MyPostRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD+HL.h"

@interface CouponViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray * dataSource;
    BOOL isyer;//判断点击的是第几个单元格
    UIButton * btn;
    NSDictionary * dic;//参数拼接
    NSString * name;//真实姓名
    NSString * car;//身份证号
    NSString * url;//地址
    NSString * longitude;//经纬度
    NSInteger num;
    BOOL textBool;//判断textField里面是否写过文字
    UIImage * carImage;//身份证正面照片
    UIImage * tvImage;//身份证反面照片
    BOOL BtnBool;//判断身份证按钮图片
    MyPostRequest * my;
}
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"商户"];
    num = 0;
    BtnBool = NO;
    [self tableV];
    // Do any additional setup after loading the view.
}
- (void)tableV{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    //去掉单元格黑线
    [tableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableFooterView = [UIView new];
    UILabel * labr = [[UILabel alloc]init];
    [labr setFrame:CGRectMake(0, 0, 90, 35)];
    [labr setText:@"商户验证"];
    self.tableView.tableHeaderView = labr;
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [self cellSoncent:cell.contentView andIndexPath:indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==3 || indexPath.section == 4) {
        return 350;
    }
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     NSArray * headerArr = @[@"身份证号:",@"真实姓名:",@"商家地址:",@"身份证正面:",@"身份证反面:",@"",@""];
    UIView * view1 = [[UIView alloc]init];
    [view1 setFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 350)];
    UILabel * label = [[UILabel alloc]init];
    [label setFrame: CGRectMake(15, 4, 150, 35)];
    [label setText:headerArr[section]];
    [view1 addSubview:label];
    [view1 setBackgroundColor:[UIColor whiteColor]];
    return view1;
}
- (void)cellSoncent:(UIView *)view andIndexPath:(NSInteger)index{
    NSArray * textArr = @[@"请输入身份证号",@"请输入真实姓名",@"请输入办公地址"];
    if (index == 0 || index == 1 || index == 2) {
        view.alpha = 1;
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-30, 45)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = textArr[index];
        textField.delegate = self;
        textField.tag = index + 1;
        if (textBool == YES) {
            NSArray * arr = @[name,car,url];
            textField.text = arr[index];
        }
        [view addSubview:textField];
    }else if(index>= 3 && index<5){
        UIView * view1 = [[UIView alloc]init];
        [view1 setFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 350)];
        [view1 setBackgroundColor:[UIColor whiteColor]];
       UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1 setFrame:CGRectMake(15, 0, CGRectGetWidth([UIScreen mainScreen].bounds)-30, CGRectGetWidth([UIScreen mainScreen].bounds)-30)];
        //btn.tag = index+1;
//        if (carImage != nil  && tvImage != nil) {
//            NSArray * imagearr = @[carImage,tvImage];
//            [btn setImage:imagearr[index] forState:UIControlStateNormal];
//        }
        [btn1 setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
        [btn1 setTag:index+1];
        [btn1 addTarget:self action:@selector(BtnAddImage:)  forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn1];
        [view addSubview:view1];
    }else if(index == 5){
        UIView * view1 = [[UIView alloc]init];
        [view1 setFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 45)];
        [view1 setBackgroundColor:[UIColor whiteColor]];
        UIButton * endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [endBtn setFrame:CGRectMake(16, 2, 85, 35)];
        [endBtn setTitle:@"确定绑定" forState:UIControlStateNormal];
        [endBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [endBtn.layer setMasksToBounds:YES];
        [endBtn.layer setCornerRadius:2];
        [endBtn.layer setShadowColor:[UIColor blackColor].CGColor];//设置阴影颜色
        [endBtn.layer setShadowOpacity:0.8];//设置阴影透明度
        [endBtn setBackgroundColor:[UIColor colorWithRed:12/255.0 green:92/255.0 blue:160/255.0 alpha:1]];
        [endBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:endBtn];
        [view addSubview:view1];
    }else if (index == 6){
        view.alpha = 0;
    }
}
- (void)BtnAddImage:(UIButton *)sender{
    if (sender.tag == 4) {
        isyer = YES;
    }else{
        isyer = NO;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)addBtn:(UIButton *)btn{
    //NSArray * nameArr = @[@"真实姓名不能为空",@"身份证号不能为空",@"地址不能为空"];
    NSData *data;
    if (UIImagePNGRepresentation(carImage) == nil) {
        
        data = UIImageJPEGRepresentation(carImage, 0.7);
    } else {
        
        data = UIImagePNGRepresentation(carImage);
    }
    NSData *data1;
    if (UIImagePNGRepresentation(tvImage) == nil) {
        data1 = UIImageJPEGRepresentation(tvImage, 0.7);
    } else {
        data1 = UIImagePNGRepresentation(tvImage);
    }
//判断信息是否填写完全
    if ([self isBlankString:name] || [self isBlankString:car] || [self isBlankString:url] || [self isBlankString:longitude] || data == nil || data1 == nil) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查信息是否填加完全" preferredStyle:  UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //点击按钮的响应事件；
            //[self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }else{
        dic = @{@"openid ":@"5898306469",@"username":name,@"card":car,@"dizhi":url,@"jingwei":longitude};
        
        NSLog(@"data= %@",data);
        my = [[MyPostRequest alloc]init];
        [my afUploadImageWithUrlString:header_image parms:dic imageData:data imageKey:@"oppositeimage" imageData:data1 imageKey:@"positiveimage" finishedBlock:^(id responseObj) {
            NSLog(@"success:%@",responseObj);
        } failedBlock:^(NSString *errorMsg) {
            NSLog(@"error:%@",errorMsg);
        }];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIButton * btn2 = (UIButton *)[self.view viewWithTag:4];
    UIButton * btn1 = (UIButton *)[self.view viewWithTag:5];
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    btn.selected = YES;
    //NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if (isyer == YES) {
        carImage = [[UIImage alloc]init];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        carImage = image;
        
        //NSData *da = UIImageJPEGRepresentation(image, 0.5f);
        //NSString *encodingStr = [da base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        //[self upLoad:da];
        //[user setObject:image forKey:@"headerImage"];
        [btn2 setImage:image forState:UIControlStateNormal];
        isyer |= isyer;
    }else{
        tvImage = image;
        //[user setObject:image forKey:@"footerImage"];
        [btn1 setImage:image forState:UIControlStateNormal];
        isyer |= isyer;
        BtnBool = YES;
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //CGFloat latitude = 0.00;
    
    if (textField.tag == 2) {
        num += 1;
        NSLog(@"textField= %@",textField.text);
        name = textField.text;
        //dic = @{@"username":textField.text};
    }else if (textField.tag  == 3){
        url = textField.text;
        num += 1;
        NSString *oreillyAddress = @"天津市和平区津门公寓B座";
        CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
        [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0 && error == nil) {
                NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
                CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
                NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
//                dic = [NSDictionary dictionaryWithObjectsAndKeys:@"jingwei",@"dizhi",textField.text, nil];
               longitude = [NSString stringWithFormat:@"%f,%f",firstPlacemark.location.coordinate.longitude,firstPlacemark.location.coordinate.latitude];
                //dic = @{@"jingwei":[NSString stringWithFormat:@"%f,%f",firstPlacemark.location.coordinate.longitude,firstPlacemark.location.coordinate.latitude],@"dizhi":textField.text};
            }
            else if ([placemarks count] == 0 && error == nil) {
                NSLog(@"Found no placemarks.");
            } else if (error != nil) {
                NSLog(@"An error occurred = %@", error);
            }
        }];
    }else{
        num += 1;
        car = textField.text;
        //dic = [NSDictionary dictionaryWithObjectsAndKeys:@"car",[NSString stringWithFormat:@"%@",textField.text], nil];
    }
    if (num != 3) {
        if (![name isEqualToString:@""]) {
            NSLog(@"we= %@",name);
            if (![car isEqualToString:@""]) {
                if (![url isEqualToString:@""]) {
                    textBool = YES;
                }else{
                    textBool = NO;
                }
            }else{
                textBool = NO;
            }
        }else{
            textBool = NO;
        }
    }else{
        NSLog(@"dic= %@",dic);
       
    }
    // NSLog(@"%@%@%@",name,car,url);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
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
