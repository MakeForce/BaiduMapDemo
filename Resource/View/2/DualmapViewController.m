//
//  DualmapViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/12.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "DualmapViewController.h"

@interface DualmapViewController ()<BMKMapViewDelegate>
@property (strong , nonatomic) BMKMapView *map1;
@property (strong , nonatomic) BMKMapView *map2;
@end

@implementation DualmapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat navH = 64;
    if (__IPHONE_OS_VERSION < 7.0)
    {
        navH = 44;
    }
    CGFloat height = (__SCREEN_SIZE.height-navH-4)/2;
    _map1 = [[BMKMapView alloc] initWithFrame:CGRectMake(0, navH, __SCREEN_SIZE.width, height-2)];
    _map1.mapType = BMKMapTypeStandard;//地图类型 标准地图
    _map1.zoomLevel = 14;//缩放级别
    [self.view addSubview:_map1];
    _map2 = [[BMKMapView alloc] initWithFrame:CGRectMake(0, __SCREEN_SIZE.height-height, __SCREEN_SIZE.width, height-2)];
    _map2.mapType = BMKMapTypeSatellite;//地图类型 卫星地图
    _map2.zoomLevel = 14;//缩放级别
    [self.view addSubview:_map2];
}
-(void)viewWillAppear:(BOOL)animated{
    [_map1 viewWillAppear];
    _map1.delegate = self;
    [_map2 viewWillAppear];
    _map2.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_map1 viewWillDisappear];
    _map1.delegate = nil;
    [_map2 viewWillDisappear];
    _map2.delegate = nil;
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
