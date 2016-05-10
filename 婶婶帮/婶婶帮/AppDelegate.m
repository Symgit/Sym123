//
//  AppDelegate.m
//  婶婶帮
//
//  Created by 孙月明 on 16/5/10.
//  Copyright © 2016年 Sym. All rights reserved.
//

#import "AppDelegate.h"
#import "rootViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MAMapServices sharedServices].apiKey = @"44fd27cd9783509b615dede053f0d22a";
    [AMapLocationServices sharedServices].apiKey = @"44fd27cd9783509b615dede053f0d22a";
    //Share
    [ShareSDK registerApp:@"94dfdb5d5124" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"3461476928"
                                          appSecret:@"30f46ab1910b0e2078497b45e458d21d"
                                        redirectUri:@"http://www.sina.com"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx760df62fd7a54330"
                                      appSecret:@"55d49a95191a3bbd0afd014cbc03d774"];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"101216688"
                                     appKey:@"6448f42615372734e06637459806e2b5"
                                   authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
    }];
    rootViewController * root = [[rootViewController alloc]init];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
