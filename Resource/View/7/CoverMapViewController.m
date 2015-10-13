//
//  CoverMapViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/13.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "CoverMapViewController.h"

@interface CoverMapViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet BMKMapView *map;
@property (nonatomic, strong) BMKCircle *circle;//圆形覆盖物
@property (nonatomic, strong) BMKPolygon * polygon1;//多边形
@property (nonatomic, strong) BMKPolygon * polygon2;//多边形
@property (nonatomic, strong) BMKArcline * arcLine;//圆弧
@property (nonatomic, strong) BMKGroundOverlay * groundOverlay;//图片图层
@property (nonatomic, strong) BMKPointAnnotation * point1;//大头针
@property (nonatomic, strong) BMKPointAnnotation * animationPoint;//大头针
@end

@implementation CoverMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_map setZoomLevel:17];
    [_segment setSelectedSegmentIndex:0];
    [self addOverLay];
}
-(void)viewWillAppear:(BOOL)animated{
    [_map viewWillAppear];
    [_map setDelegate:self];
}
-(void)viewWillDisappear:(BOOL)animated{
    [_map viewWillDisappear];
    [_map setDelegate:nil];
}
- (IBAction)valueChange:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:{
            [_map removeOverlays:_map.overlays];
            [_map removeAnnotations:_map.annotations];
            [self addOverLay];
        }
            break;
        case 1:{
            [_map removeOverlays:_map.overlays];
        }
            break;
        case 2:{
            [_map removeOverlays:_map.overlays];
            [_map removeAnnotations:_map.annotations];
        }
            break;
        default:
            break;
    }
}
-(void)addOverLay{
    if (!_circle) {
        KHLog(@"常青园：%f   %f  ",changQY.latitude,changQY.longitude);
        _circle = [BMKCircle circleWithCenterCoordinate:changQY radius:50];
    }
    [_map addOverlay:_circle];
    // 添加多边形覆盖物
    if (!_polygon1) {
        CLLocationCoordinate2D coords[4] = {0};
//        39.9200960000,116.4045000000
        coords[0].latitude = 39.9200960000;
        coords[0].longitude = 116.4045000000;
        coords[1].latitude = 39.9188230000;
        coords[1].longitude = 116.4045000000;
        coords[2].latitude = 39.9188230000;
        coords[2].longitude = 116.4080570000;
        coords[3].latitude = 39.9200960000;
        coords[3].longitude = 116.4080570000;
        _polygon1 = [BMKPolygon polygonWithCoordinates:coords count:4];
    }
    [_map addOverlay:_polygon1];
    if(!_polygon2){
        CLLocationCoordinate2D coords[5] = {0};
//        39.9170070000,116.4058250000
        coords[0].latitude = 39.9170070000;
        coords[0].longitude = 116.4058250000;
        coords[1].latitude = 39.9165510000;//39.9165510000,116.4054070000
        coords[1].longitude = 116.4054070000;
        coords[2].latitude = 39.9163400000;
        coords[2].longitude = 116.4057310000;
        coords[3].latitude = 39.9164850000;
        coords[3].longitude = 116.4063910000;
        coords[4].latitude = 39.9168590000;
        coords[4].longitude = 116.4064720000;
    }
    [_map addOverlay:_polygon2];
}
#pragma mark    覆盖物代理方法如不实现将无法绘制
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKCircle class]]) {
        BMKCircleView *circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [UIColor colorWithRed:1.000 green:1.000 blue:0.000 alpha:0.332];
        circleView.strokeColor = [UIColor redColor];
        circleView.lineWidth = 2.0;
        return circleView;
    }
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 20.0;
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"texture_arrow.png"]];
        
        return polylineView;
    }
    
    if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =2.0;
//        polygonView.lineDash = (overlay == _polygon2)?YES:NO;
        return polygonView;
    }
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
        return groundView;
    }
    if ([overlay isKindOfClass:[BMKArcline class]]) {
        BMKArclineView *arclineView = [[BMKArclineView alloc] initWithArcline:overlay];
        arclineView.strokeColor = [UIColor blueColor];
        arclineView.lineDash = YES;
        arclineView.lineWidth = 6.0;
        return arclineView;
    }
    return nil;
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
