//
//  KHPointAnnotation.h
//  BaiduMapDemo
//
//  Created by iOS01 on 15-2-6.
//  Copyright (c) 2015年 OliverTheFerry. All rights reserved.
//

@interface KHPointAnnotation : BMKShape{
    @package
    CLLocationCoordinate2D _coordinate;
}
///该点的坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (strong) NSString *title1;
@property (strong) NSString *title2;
@end
