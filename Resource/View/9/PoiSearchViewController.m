//
//  PoiSearchViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/14.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "PoiSearchViewController.h"

@interface PoiSearchViewController ()<BMKMapViewDelegate, BMKPoiSearchDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *map;
@property (weak, nonatomic) IBOutlet UITextField *cityText;
@property (weak, nonatomic) IBOutlet UITextField *keyText;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) BMKPoiSearch *poiSearch;
@property (assign, nonatomic) NSInteger curPage;
@end

@implementation PoiSearchViewController
@synthesize curPage = curPage;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _poiSearch = [[BMKPoiSearch alloc] init];
    _cityText.text = @"西安";
    _keyText.text = @"小吃,车站";//百度这里的设计我个人觉得不太好，我查了一下他们的API中没有关于多关键字搜索的设计，目前这个接口shezhe
    curPage = 0;
    [_map setRegion:BMKCoordinateRegionMake(xian, BMKCoordinateSpanMake(0.5,0.5)) animated:YES];
    [_map setIsSelectedAnnotationViewFront:YES];//设定是否总让选中的annotaion置于最前面
}
-(IBAction)startAction:(UIButton *)sender{
    curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityText.text;
    citySearchOption.keyword = _keyText.text;
    BOOL flag = [_poiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        _nextBtn.enabled = true;
        KHLog(@"城市内检索发送成功");
    }
    else
    {
        _nextBtn.enabled = false;
        KHLog(@"城市内检索发送失败");
    }
}
- (IBAction)editEnd:(UITextField *)sender {
    [sender resignFirstResponder];
}

-(IBAction)nextPageAction:(id)sender{
    curPage++;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= _cityText.text;
    citySearchOption.keyword = _keyText.text;
    BOOL flag = [_poiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        _nextBtn.enabled = true;
        KHLog(@"城市内检索发送成功");
    }
    else
    {
        _nextBtn.enabled = false;
        KHLog(@"城市内检索发送失败");
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [_map viewWillAppear];
    _map.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poiSearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_map viewWillDisappear];
    _map.delegate = nil; // 不用时，置nil
    _poiSearch.delegate = nil; // 不用时，置nil
}
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    KHLog(@"didAddAnnotationViews");
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_map.annotations];
    [_map removeAnnotations:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_map addAnnotations:annotations];
        [_map showAnnotations:annotations animated:YES];
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        KHLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
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
