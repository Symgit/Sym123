//
//  MyPostRequest.h
//  Diamonds
//
//  Created by corepass on 15/8/4.
//  Copyright (c) 2015年 corepass. All rights reserved.
//

#import <Foundation/Foundation.h>
//封装AFNetWorking的post请求
typedef void(^DownloadFinishedBlock)(id responseObj);
typedef void(^DownloadFailedBlock)(NSString *errorMsg);

@interface MyPostRequest : NSObject
{
    
}
//基本的post请求
- (void)afPostRequestWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed;

//基本的get请求
- (void)afGetRequestWithUrlString:(NSString *)urlString finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed;

//上传文件(图片)的方法
//dic 中放除图片以外的其他参数, data 图片转换的NSData key 为图片对应的key：pis
- (void)afUploadImageWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic  imageData:(NSData *)data imageKey:(NSString *)key finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed;

- (void)afUploadImageWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic  imageData:(NSData *)data imageKey:(NSString *)key imageData:(NSData *)data1 imageKey:(NSString *)key1 finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed;
@end