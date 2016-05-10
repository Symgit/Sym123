//
// LocationBase.hh
// LocationLibrary
//
// Created by Macro on 3/7/15.
// Copyright (c) 2015 MacroGroup. All rights reserved.
//
#ifndef __INDOOR_LOCATION_LOCATION_UTILS_LOCATION_BASE_HH__
#define __INDOOR_LOCATION_LOCATION_UTILS_LOCATION_BASE_HH__


#import <Foundation/Foundation.h>

// 信号类型
#define SCAN_BLE 2	// 蓝牙信号

// 定位方法
#define ONLINE 1	// 在线定位(不下载指纹，扫描信息发送到服务器)
#define OFFLINE 2	// 离线定位(下载指纹，下载完成后不再访问服务器)
#define OFFLINE_ONLINE 3	// 离线在线混合定位(离线定位不可用时用在线定位)

// 定位错误码
#define INDOOR_ERROR_CODE - 1	// 定位错误
#define SCAN_ERROR_BLE_UNSUPPORTED - 100	// 设备不支持蓝牙定位
#define SCAN_ERROR_BLE_NOTOPEN - 101	// 蓝牙没有打开
#define SCAN_ERROR_BLE_NOTALLOW	- 102	// 定位权限被禁止
#define SCAN_ERROR_BLE_NORESULT	- 103	// 蓝牙扫描没有结果
#define LOCATION_ERROR_IDNOTSUPPORT	- 200	// 建筑物不支持定位
#define LOCATION_ERROR_NOFINGER	- 201	// 没有指纹
#define LOCATION_ERROR_FEWFINGERS - 202	// 指纹太少
#define LOCATION_ERROR_FEWMATCHES - 203	// 指纹匹配度太低
#define LOCATION_ERROR_FEWSCANINFOS	- 204	// 扫描到的指纹太少
#define LOCATION_ERROR_OFFLINE - 205	// 离线定位失败
#define LOCATION_ERROR_ONLINE - 206	// 在线定位失败
#define NETWORK_ERROR_DISCONNECT - 300	// 网络连接失败
#define NETWORK_ERROR_MISMATCH - 301	// 网络类型不匹配
#define NETWORK_ERROR_CONNECTERROR - 302	// 网络连接路由错误
#define NETWORK_ERROR_TIMEOUT - 303	// 网络连接超时
#define LBS_ERROR_REQUEST - 400	// LBS请求错误
#define LBS_ERROR_KEY - 401	// LBS的KEY错误


// 定位结果
@interface LocationResult : NSObject

@property(nonatomic) int type;	// 结果类型(ONLINE/OFFLINE)
@property(nonatomic, strong) NSString* buildingId;	// 定位建筑物
@property(nonatomic) double longitude;	// 经度([-180,180])
@property(nonatomic) double latitude;	// 纬度([-90,90])
@property(nonatomic) int floorId;	// 楼层([-100,-1]U[1,100])
@property(nonatomic) float accuracy;	// 精度(米)
@property(nonatomic) float orientation;	// 方向([0,360))

@property(nonatomic) float stepLength;	// 步长
@property(nonatomic) float zeroAngle;	// 角度
@property(nonatomic) float otherLeft;	// 其它
@property(nonatomic) int64_t timestamp;	// 时间

-(BOOL)isValid;	// 定位结果是否有效
-(BOOL)isEqualToResult:(LocationResult*)result;	// 两个定位结果是否近似相等
-(instancetype)initWithValue:(int)floorId longitude:(double)longitude latitude:(double)latitude;	// 根据经纬度创建结果
-(instancetype)initWithValue:(double)longitude latitude:(double)latitude;	// 根据经纬度创建结果
-(instancetype)initWithValue:(LocationResult*)result;	// 根据一个结果来创建

@end

@protocol IndoorLocationDelegate;

// 定位基类
@interface LocationBase : NSObject

+(NSString*)getVersion;	// 获取版本号
+(NSString*)getSubVersion;	// 获取子版本号

-(instancetype)initWithDelegate:(id<IndoorLocationDelegate>)delegate;	// 初始化定位类

@property(nonatomic, weak)id<IndoorLocationDelegate>delegate;	// Delegate
@property(nonatomic, strong) NSString* buildingId;	// 建筑物
@property(nonatomic, strong) NSString* serverUrl;	// .服务器地址
@property(nonatomic, strong) NSString* cachePath;	// 缓存路径
@property(nonatomic, strong) NSMutableSet* beacons;	// 蓝牙UUID集合
@property(nonatomic) int method;	// 定位方式(在线离线)
@property(nonatomic) float orientation;	// 手机方向([0,360))
@property(nonatomic) float updateInterval;	// 最小更新间隔(0.1-1秒，暂不支持比0.1更快比1更慢的更新)
@property(nonatomic, strong) NSString* key;	// 鉴权用

-(int)startLocation;	// 开始定位
-(int)stopLocation;	// 停止定位

@end

@protocol IndoorLocationDelegate<NSObject>

-(void)indoorLocation:(LocationBase*)indoorLocation
    didLocationResult:(LocationResult*)result;	// 定位结果

-(void)indoorLocation:(LocationBase*)indoorLocation
    didLocationError:(NSString*)buildingId	// 建筑物
    error:(NSError*)error;	// 定位失败


@end


#endif
