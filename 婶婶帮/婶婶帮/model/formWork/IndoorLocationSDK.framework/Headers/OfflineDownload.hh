//
// OfflineLocation.h
// IndoorLocationDemo
//
// Created by Macro on 14/12/24.
// Copyright (c) 2014年 Macro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationBase.hh"

// Network type
#define NETWORK_NONE 0	// 没有网络
#define NETWORK_WIFI 1	// WIFI网络
#define NETWORK_4G 2	// 4G网络
#define NETWORK_3G 4	// 3G网络
#define NETWORK_2G 8	// 2G网络
#define NETWORK_ALL 15	// 所有网络
#define NETWORK_NOTWIFI 14	// 非WIFI网络

// Download flag
#define DOWNLOAD_STATUS 1	// .下载状态
#define DOWNLOAD_UPDATE 2	// .下载更新
#define DOWNLOAD_PROGRESS 3	// .下载进行中
#define DOWNLOAD_COMPLETE 4	// .下载完成

@protocol DownloadDelegate;

@interface OfflineDownload : LocationBase

-(instancetype)initWithDelegate:(id<DownloadDelegate>)delegate;	// 初始化下载实例
-(int)downloadFinger:(NSString*)buildingId networkType:(int)networkType;	// 在特定网络类型下载建筑物指纹数据
-(int)downloadCancel:(NSString*)buildingId;	// 取消下载建筑物的指纹数据
-(int)clearFinger:(NSString*)buildingId;	// 清除建筑物的指纹数据

@end

@protocol DownloadDelegate<NSObject>

-(void)download:(LocationBase*)download
    didDownloadFinger:(NSString*)buildingId	// 建筑物
    scanType:(int)scanType	// 指纹类型(WIFI/BLE)
    flag:(int)flag	// .下载标志(PROGRESS/COMPLETE)
    downloaded:(int)downloaded	// 已经下载的指纹数量
    total:(int)total;	// 建筑物指纹总数量

-(void)download:(LocationBase*)download
    didDownloadError:(NSString*)buildingId	// 建筑物
    scanType:(int)scanType	// 指纹类型(WIFI/BLE)
    error:(NSError*)error;	// 错误信息

@end
