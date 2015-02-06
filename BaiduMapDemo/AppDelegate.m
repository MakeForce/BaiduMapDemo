//
//  AppDelegate.m
//  BaiduMapDemo
//
//  Created by iOS01 on 15-2-6.
//  Copyright (c) 2015年 OliverTheFerry. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _mapManager = [[BMKMapManager alloc] init];
    //    BaiduMapKey  你申请的百度地图AK（宏定义）
    if (![_mapManager start:BaiduMapKey generalDelegate:self])
    {
        KHLog(@"启动失败");//KHLog 相当于NSLog
    }

    return YES;
}
-(void)onGetNetworkState:(int)iError
{
    if (iError == 0)
    {
        KHLog(@"网络状态正常");
    }
    else
    {
        KHLog(@"网络错误:%d",iError);
    }
}
-(void)onGetPermissionState:(int)iError
{
    if (iError == 0)
    {
        KHLog(@"授权正常");
    }
    else
    {
        KHLog(@"授权错误:%d",iError);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作

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
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
