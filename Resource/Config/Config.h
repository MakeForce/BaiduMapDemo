//
//  Config.h
//  BaiduMapDemo
//
//  Created by iOS01 on 15-2-6.
//  Copyright (c) 2015年 OliverTheFerry. All rights reserved.
//

#ifndef BaiduMapDemo_Config_h
#define BaiduMapDemo_Config_h

#define BaiduMapKey             @"QDL46OgPUN3KzZ5KIbcjoG1Y"

/*!
 *  当前屏幕尺寸
 */
#define __SCREEN_SIZE [[UIScreen mainScreen] bounds].size
/*!
 *  系统版本号
 */
#define __IPHONE_OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/*!
 *  先的坐标
 */
#define xian            CLLocationCoordinate2DMake(34.2239390000,108.9807190000)//数据来源http://www.gpsspg.com/maps.htm
#define changQY         CLLocationCoordinate2DMake(39.9183390000,116.4026860000)//39.9183390000,116.4026860000

#ifdef DEBUG
#define KHLog(...) NSLog(__VA_ARGS__)
#else
#define KHLog(...)
#endif

#endif
