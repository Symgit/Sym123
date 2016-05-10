//
//  MyPostRequest.m
//  AF数据网络请求
//
//  Created by corepass on 15/9/17.
//  Copyright (c) 2015年 corepass. All rights reserved.
//

#import "MyPostRequest.h"
#import "AFNetworking.h"
@implementation MyPostRequest
{
    DownloadFinishedBlock _finishedBlock;
    DownloadFailedBlock _failedBlock;
}

- (void)afPostRequestWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed{
    if (_finishedBlock!=finished) {
        _finishedBlock = nil;
        _finishedBlock = finished;
    }
    if (_failedBlock!=failed) {
        _failedBlock = nil;
        _failedBlock = failed;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        _failedBlock(error.localizedDescription);
    }];
}

//get请求（无参申请）
- (void)afGetRequestWithUrlString:(NSString *)urlString finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed
{
    if (_finishedBlock!=finished) {
        _finishedBlock = nil;
        _finishedBlock = finished;
    }
    if (_failedBlock!=failed) {
        _failedBlock = nil;
        _failedBlock = failed;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failedBlock(error.localizedDescription);
    }];
}

//图片上传
- (void)afUploadImageWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic  imageData:(NSData *)data imageKey:(NSString *)key finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed{
    if (_finishedBlock!=finished) {
        _finishedBlock = nil;
        _finishedBlock = finished;
    }
    if (_failedBlock!=failed) {
        _failedBlock = nil;
        _failedBlock = failed;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //上传图片的post方法
    [manager POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //利用formData 实现图片上传(可以类比ASI的setData......方法)
        //FileData 图片转换成的NSData
        //name 服务端规定的参数 pis
        //fileName  临时名称
        //mimeType data的文件类型
        [formData appendPartWithFileData:data name:key fileName:@"kkk.png" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failedBlock(error.localizedDescription);
    }];
}

- (void)afUploadImageWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic  imageData:(NSData *)data imageKey:(NSString *)key imageData:(NSData *)data1 imageKey:(NSString *)key1 finishedBlock:(DownloadFinishedBlock)finished failedBlock:(DownloadFailedBlock)failed{
    if (_finishedBlock!=finished) {
        _finishedBlock = nil;
        _finishedBlock = finished;
    }
    if (_failedBlock!=failed) {
        _failedBlock = nil;
        _failedBlock = failed;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    //上传图片的post方法
    [manager POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //利用formData 实现图片上传(可以类比ASI的setData......方法)
        //FileData 图片转换成的NSData
        //name 服务端规定的参数 pis
        //fileName  临时名称
        //mimeType data的文件类型
        [formData appendPartWithFileData:data name:key fileName:@"kkk.png" mimeType:@"image/png"];
        [formData appendPartWithFileData:data1 name:key1 fileName:@"mmm.png" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failedBlock(error.localizedDescription);
    }];
}
@end

