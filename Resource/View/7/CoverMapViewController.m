//
//  CoverMapViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/13.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "CoverMapViewController.h"
#import "KHPaoPaoView.h"
#import "KHPointAnnotation.h"
@interface CoverMapViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet BMKMapView *map;
@property (nonatomic, strong) BMKCircle *circle;//圆形覆盖物
@property (nonatomic, strong) BMKPolygon * polygon1;//多边形
@property (nonatomic, strong) BMKPolygon * polygon2;//多边形
@property (nonatomic, strong) BMKPolyline *polyLine;//折线
@property (nonatomic, strong) BMKArcline * arcLine;//圆弧
@property (nonatomic, strong) BMKGroundOverlay * groundOverlay;//图片图层
@property (nonatomic, strong) BMKPointAnnotation * point1;//大头针
@property (nonatomic, strong) KHPointAnnotation * khannotation;//大头针
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
            [self addPointAnimation];
        }
            break;
        case 2:{
            [_map removeOverlays:_map.overlays];
            [_map removeAnnotations:_map.annotations];
            [self addGroundOverlay];
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
    //第二个多边形
    if(!_polygon2){
        CLLocationCoordinate2D coords[5] = {0};
        coords[0].latitude = 39.9169560000;
        coords[0].longitude = 116.4060560000;
        coords[1].latitude = 39.9163820000;
        coords[1].longitude = 116.4050590000;
        coords[2].latitude = 39.9154930000;
        coords[2].longitude = 116.4054410000;
        coords[3].latitude = 39.9154930000;
        coords[3].longitude = 116.4066980000;
        coords[4].latitude = 39.9163820000;
        coords[4].longitude = 116.4071050000;
        _polygon2 = [BMKPolygon polygonWithCoordinates:coords count:5];
    }
    [_map addOverlay:_polygon2];
    //折线
    if(!_polyLine){
        CLLocationCoordinate2D coord[3]={0};
        coord[0].latitude = 39.9200720000;
        coord[0].longitude = 116.4037160000;
        coord[1].latitude = 39.9141400000;
        coord[1].longitude = 116.4034910000;
        coord[2].latitude = 39.9213270000;
        coord[2].longitude = 116.3968980000;
        _polyLine = [BMKPolyline polylineWithCoordinates:coord count:3];
    }
    [_map addOverlay:_polyLine];
    if (!_groundOverlay) {
        CLLocationCoordinate2D coords[3] = {0};
        coords[0].latitude = 39.9096260000;
        coords[0].longitude = 116.4017650000;
        coords[1].latitude = 39.9109130000;
        coords[1].longitude = 116.4044060000;
        coords[2].latitude = 39.9097230000;
        coords[2].longitude = 116.4071370000;
        _arcLine = [BMKArcline arclineWithCoordinates:coords];
    }
    [_map addOverlay:_arcLine];
}
-(void)addPointAnimation{
    if (!_point1) {
        _point1 = [[BMKPointAnnotation alloc] init];
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.405;
        _point1.coordinate = coor;
        _point1.title = @"第一个标注";
        _point1.subtitle = @"长按大头针后才可以拖拽";
    }
    [_map addAnnotation:_point1];
    if (!_khannotation) {
        _khannotation = [[KHPointAnnotation alloc] init];
        _khannotation.title = @"天安门";
        _khannotation.subtitle = @"自定义的PaoPaoView";
        _khannotation.title1 = @"支持拖拽";
        _khannotation.title2 = @"自定义测试";
        _khannotation.coordinate = TianAnM;
    }
    [_map addAnnotation:_khannotation];
}
- (void)addGroundOverlay {
    //添加图片图层覆盖物
    if (_groundOverlay == nil) {
        CLLocationCoordinate2D coords[2] = {0};
        coords[0].latitude = 39.910;
        coords[0].longitude = 116.370;
        coords[1].latitude = 39.950;
        coords[1].longitude = 116.430;
        
        BMKCoordinateBounds bound;
        bound.southWest = coords[0];
        bound.northEast = coords[1];
        _groundOverlay = [BMKGroundOverlay groundOverlayWithBounds:bound icon:[UIImage imageNamed:@"test.png"]];
        _groundOverlay.alpha = 0.8;
    }
    [_map addOverlay:_groundOverlay];
//    _mapView.zoomLevel = 14;
//    _map.centerCoordinate = CLLocationCoordinate2DMake(39.9255, 116.3995);
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
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"line"]];
        
        return polylineView;
    }
    
    if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =2.0;
        polygonView.lineDash = (overlay == _polygon2)?YES:NO;//虚线
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
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if (annotation == _point1) {
        NSString *annotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[_map dequeueReusableAnnotationViewWithIdentifier:annotationViewID];
        if (!annotationView) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewID];
            annotationView.pinColor = BMKPinAnnotationColorGreen;
            annotationView.animatesDrop = YES;//掉落动画
            annotationView.draggable = YES;//可拖拽属性
            return annotationView;
        }
        return annotationView;
    }
    BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"KHAnnotationID"];
    newAnnotationView.image = [UIImage imageNamed:@"local"];
    newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
    newAnnotationView.draggable = YES;//移动
    KHPaoPaoView *paopao = [[KHPaoPaoView alloc] init];
    [paopao setAnnotationWith:((KHPointAnnotation *)annotation)];
    newAnnotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopao];
    return newAnnotationView;
}
-(void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    KHLog(@"点击了自定义的泡泡");
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
