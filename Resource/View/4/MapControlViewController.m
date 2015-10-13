//
//  MapControlViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/12.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "MapControlViewController.h"

@interface MapControlViewController ()<BMKMapViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *zoomlevel;
@property (weak, nonatomic) IBOutlet UITextField *rotationDegree;
@property (weak, nonatomic) IBOutlet UITextField *overlookDegree;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIButton *sub;
@property (assign , nonatomic) NSInteger zoomL;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MapControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _map.zoomLevel = 14;
    _zoomL = 14;
    UIBarButtonItem * customRightBar = [[UIBarButtonItem alloc] initWithTitle:@"截图" style:UIBarButtonItemStyleBordered target:self action:@selector(screensHot)];
    customRightBar.title = @"截图";
    self.navigationItem.rightBarButtonItem = customRightBar;
}
-(void)viewWillAppear:(BOOL)animated{
    [_map viewWillAppear];
    _map.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_map viewWillDisappear];
    _map.delegate = nil;
}
//截取当前地图可视区域
-(void)screensHot{
    [_hiddenView setHidden:NO];
    [self.view bringSubviewToFront:_hiddenView];
    _imageView.image = [_map takeSnapshot];//可视区域
//    _map takeSnapshot:<#(CGRect)#>  获得地图指定区域截图
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
}
-(IBAction)valueChange:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
            if (!_map.rotateEnabled) {
                _map.rotateEnabled = YES;
            }
            _map.rotation = [_rotationDegree.text floatValue];//地图旋转角度，在手机上当前可使用的范围为－180～180度
        }
            break;
        case 1:{
            if (!_map.overlookEnabled) {
                _map.overlookEnabled = YES;
            }
            _map.overlooking = -[_rotationDegree.text floatValue];//地图俯视角度，在手机上当前可使用的范围为－45～0度
        }
            break;
        default:
            break;
    }
}
//地图缩放操作
-(IBAction)zoomLevelAction:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{//++
            if (_zoomL<19) {
                _zoomL++;
                _map.zoomLevel = _zoomL;
                sender.enabled = (_zoomL<19)?YES:NO;
                if (_zoomL>3) {
                    _sub.enabled = YES;
                }
            }else{
                sender.enabled = NO;
            }
        }
            break;
        case 1:{//--
            if (_zoomL>3) {
                _zoomL--;
                _map.zoomLevel = _zoomL;
                sender.enabled = (_zoomL>3)?YES:NO;
                if (_zoomL<19) {
                    _add.enabled = YES;
                }
            }else{
                sender.enabled = NO;
            }
        }
            break;
        default:
            break;
    }
    _zoomlevel.text = [@(_zoomL) stringValue];
}
//关闭截图展示
- (IBAction)closeScreenHot:(UIButton *)sender {
    [_hiddenView setHidden:YES];
    [self.view sendSubviewToBack:_hiddenView];
    _imageView.image = nil;
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}
#pragma mark 底图手势操作
/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    KHLog(@"onClickedMapPoi-%@",mapPoi.text);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了底图标注:%@,\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", mapPoi.text,mapPoi.pt.longitude,mapPoi.pt.latitude, (int)_map.zoomLevel,_map.rotation,_map.overlooking];
    _info.text = showmeg;
    [self updateZoomle];
}
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    KHLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_map.zoomLevel,_map.rotation,_map.overlooking];
    _info.text = showmeg;
    [self updateZoomle];
}

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
{
    KHLog(@"onDoubleClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您双击了地图(double click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_map.zoomLevel,_map.rotation,_map.overlooking];
    _info.text = showmeg;
    [self updateZoomle];
}

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    KHLog(@"onLongClick-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您长按了地图(long pressed).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_map.zoomLevel,_map.rotation,_map.overlooking];
    _info.text = showmeg;
    [self updateZoomle];
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSString* showmeg = [NSString stringWithFormat:@"地图区域发生了变化(x=%d,y=%d,\r\nwidth=%d,height=%d).\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d",(int)_map.visibleMapRect.origin.x,(int)_map.visibleMapRect.origin.y,(int)_map.visibleMapRect.size.width,(int)_map.visibleMapRect.size.height,(int)_map.zoomLevel,_map.rotation,_map.overlooking];
    
    _info.text = showmeg;
    [self updateZoomle];
}
-(void)updateZoomle{
    _zoomL = _map.zoomLevel;
    _zoomlevel.text = [@(_zoomL) stringValue];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
