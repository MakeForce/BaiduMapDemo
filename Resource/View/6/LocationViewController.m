//
//  LocationViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/13.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (weak, nonatomic) IBOutlet UIButton *satrtBtn;
@property (weak, nonatomic) IBOutlet UIButton *followingBtn;
@property (weak, nonatomic) IBOutlet UIButton *followHeadBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet BMKMapView *map;
@property (nonatomic , strong) BMKLocationService *locationService;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationService = [[BMKLocationService alloc] init];
    [_followingBtn setEnabled:NO];
    [_followHeadBtn setEnabled:NO];
    [_stopBtn setEnabled:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [_map viewWillAppear];
    [_map setDelegate:self];
    [_locationService setDelegate:self];
}
-(void)viewWillDisappear:(BOOL)animated{
    [_map viewWillDisappear];
    [_locationService setDelegate:nil];
    [_map setDelegate:nil];
}
- (IBAction)startLocationAction:(UIButton *)sender {
    KHLog(@"普通定位");
    [_locationService startUserLocationService];
    [_map setShowsUserLocation:NO];
    [_map setUserTrackingMode:BMKUserTrackingModeNone];//普通定位模式
    [_map setShowsUserLocation:YES];
    [_satrtBtn setEnabled:NO];
    [_followHeadBtn setEnabled:YES];
    [_followingBtn setEnabled:YES];
    [_stopBtn setEnabled:YES];
}
- (IBAction)stopLocationAction:(UIButton *)sender {
    KHLog(@"停止定位");
    [_locationService stopUserLocationService];
    [_map setShowsUserLocation:NO];
    [_stopBtn setEnabled:NO];
    [_followingBtn setEnabled:NO];
    [_followHeadBtn setEnabled:NO];
    [_satrtBtn setEnabled:YES];
}
- (IBAction)followingAction:(UIButton *)sender {
    KHLog(@"跟随模式");
    [_map setShowsUserLocation:NO];
    [_map setUserTrackingMode:BMKUserTrackingModeFollow];
    [_map setShowsUserLocation:YES];
}

- (IBAction)followHeadAction:(UIButton *)sender {
    KHLog(@"罗盘模式");
    [_map setShowsUserLocation:NO];
    [_map setUserTrackingMode:BMKUserTrackingModeFollowWithHeading];
    [_map setShowsUserLocation:YES];
}
#pragma marks   代理
-(void)willStartLocatingUser{
    KHLog(@"开始定位");
}
//用户位置更新后，会调用此函数
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [_map updateLocationData:userLocation];
}
//用户方向更新后，会调用此函数
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    [_map updateLocationData:userLocation];
    KHLog(@"heading is %@",userLocation.heading);
}
-(void)didStopLocatingUser{
    KHLog(@"停止定位");
}
-(void)didFailToLocateUserWithError:(NSError *)error{
    KHLog(@"定位失败:%@",error);
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
