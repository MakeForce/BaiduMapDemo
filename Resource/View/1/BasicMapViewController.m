//
//  BasicMapViewController.m
//  BaiduMapDemo
//
//  Created by iOS01 on 15-2-6.
//  Copyright (c) 2015年 OliverTheFerry. All rights reserved.
//
//    34.2778000000,108.9530980000   数据来源http://www.gpsspg.com/maps.htm
#define xian            CLLocationCoordinate2DMake(34.2239390000,108.9807190000);
#import "KHPaoPaoView.h"
#import "KHPointAnnotation.h"
#import "BasicMapViewController.h"

@interface BasicMapViewController ()
{
    BMKMapView *_mapView;
    NSBundle *bundle;
    NSArray *pointArr;
}
@end

@implementation BasicMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat navH = 64;
    if (__IPHONE_OS_VERSION < 7.0)
    {
        navH = 44;
    }
    _mapView  = [[BMKMapView alloc] initWithFrame:CGRectMake(0, navH+60, __SCREEN_SIZE.width, __SCREEN_SIZE.height-navH-60)];
    //    _mapView.showMapScaleBar = NO;
    //    _mapView.overlooking = 0;
    bundle = [NSBundle mainBundle];
    
    [self.view addSubview:_mapView];
    
    KHPointAnnotation *point = [[KHPointAnnotation alloc] init];
    point.title = @"西安市";
    point.subtitle = @"我在这";
    point.title1 = @"自定义泡泡测试";
    point.title2 = @"自定义测试";
    point.coordinate = xian;
    
    BMKPointAnnotation *point1 = [[BMKPointAnnotation alloc] init];
    point1.title = @"北京市";
    point1.subtitle = @"0000000000000";
    point1.coordinate = CLLocationCoordinate2DMake(39.905206, 116.390356);
    
    pointArr = @[point,point1];

}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;// 不用时，置nil
}
- (IBAction)switchAction:(UISwitch *)sender
{
    if (sender.tag ==1)
    {
        if (sender.on)
        {
            [_mapView setMapType:BMKMapTypeStandard];
            
        }
        else
        {
            [_mapView setMapType:BMKMapTypeSatellite];
        }
    }
    if (sender.tag == 2)
    {
        //第一参数地图中心位置，第二参数一中心点显示周围的经纬度差值
        if (sender.on)
        {
            [_mapView setRegion:BMKCoordinateRegionMake(CLLocationCoordinate2DMake(34.2778000000,108.9530980000), BMKCoordinateSpanMake(0.5,0.5)) animated:YES];
        }
        else
        {
            [_mapView setRegion:BMKCoordinateRegionMake(CLLocationCoordinate2DMake(39.905206, 116.390356), BMKCoordinateSpanMake(0.5,0.5)) animated:YES];
        }
    }
    if (sender.tag == 3)
    {
        [_mapView setTrafficEnabled:sender.on];
    }
}
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    KHLog(@"地图加载完成");//回调事件请自行参考使用
    [_mapView setCompassPosition:CGPointMake(100,100)];//指南针位置可能看不见，这个和官方的交流吧！不清楚是什么原因
    [_mapView addAnnotations:pointArr];
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    KHLog(@"地图区域改变完成");
}

#pragma mark 设置大头针
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    else
    {
        //        这里使用自定义大头针
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"local@2x" ofType:@"png"]];
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        KHPaoPaoView *paopao = [[KHPaoPaoView alloc] init];
        [paopao setAnnotationWith:((KHPointAnnotation *)annotation)];
        newAnnotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopao];
        return newAnnotationView;
    }
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
