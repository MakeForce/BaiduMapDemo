//
//  CustomOverlayViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/14.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "CustomOverlayViewController.h"
#import "KHCustomOverlay.h"
#import "KHCustomOverlayView.h"
@interface CustomOverlayViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *map;

@end

@implementation CustomOverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    _map.delegate = self;
    
    CLLocationCoordinate2D coor1;
    coor1.latitude = 39.915;
    coor1.longitude = 116.404;
    BMKMapPoint pt1 = BMKMapPointForCoordinate(coor1);
    CLLocationCoordinate2D coor2;
    coor2.latitude = 40.015;
    coor2.longitude = 116.404;
    BMKMapPoint pt2 = BMKMapPointForCoordinate(coor2);
    BMKMapPoint * temppoints = new BMKMapPoint[2];
    temppoints[0].x = pt2.x;
    temppoints[0].y = pt2.y;
    temppoints[1].x = pt1.x;
    temppoints[1].y = pt1.y;
    KHCustomOverlay * custom = [[KHCustomOverlay alloc] initWithPoints:temppoints count:2];
    [_map addOverlay:custom];
    delete temppoints;
    
    CLLocationCoordinate2D coor3;
    coor3.latitude = 39.915;
    coor3.longitude = 116.504;
    BMKMapPoint pt3 = BMKMapPointForCoordinate(coor3);
    CLLocationCoordinate2D coor4;
    coor4.latitude = 40.015;
    coor4.longitude = 116.504;
    BMKMapPoint pt4 = BMKMapPointForCoordinate(coor4);
    CLLocationCoordinate2D coor5;
    coor5.latitude = 39.965;
    coor5.longitude = 116.604;
    BMKMapPoint pt5 = BMKMapPointForCoordinate(coor5);
    BMKMapPoint * temppoints2 = new BMKMapPoint[3];
    temppoints2[0].x = pt3.x;
    temppoints2[0].y = pt3.y;
    temppoints2[1].x = pt4.x;
    temppoints2[1].y = pt4.y;
    temppoints2[2].x = pt5.x;
    temppoints2[2].y = pt5.y;
    KHCustomOverlay* custom2 = [[KHCustomOverlay alloc] initWithPoints:temppoints2 count:3];
    [_map addOverlay:custom2];
    delete temppoints2;
}
-(void)viewWillAppear:(BOOL)animated {
    [_map viewWillAppear];
    _map.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[KHCustomOverlay class]])
    {
        KHCustomOverlayView* cutomView = [[KHCustomOverlayView alloc] initWithOverlay:overlay];
        cutomView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        cutomView.fillColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
        cutomView.lineWidth = 5.0;
        return cutomView;
        
    }
    return nil;
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [_map viewWillDisappear];
    _map.delegate = nil; // 不用时，置nil
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
