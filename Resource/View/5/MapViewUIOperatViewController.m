//
//  MapViewUIOperatViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/13.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "MapViewUIOperatViewController.h"

@interface MapViewUIOperatViewController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *map;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;

@end

@implementation MapViewUIOperatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_map setZoomEnabled:NO];
    [_map setScrollEnabled:NO];
    [_map setShowMapScaleBar:NO];
    [_map setCompassPosition:CGPointMake(10, 10)];
    [_seg setSelectedSegmentIndex:0];
    [_map setOverlooking:-30];//用来触发指南针
}
-(void)viewWillAppear:(BOOL)animated{
    [_map viewWillAppear];
    _map.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_map viewWillDisappear];
    _map.delegate = self;
}
-(IBAction)valueChangAction:(UISwitch *)sender{
    switch (sender.tag) {
        case 0:{//手势缩放
            [_map setZoomEnabled:sender.on];
        }
            break;
        case 1:{//平移操作
            [_map setScrollEnabled:sender.on];
        }
            break;
        case 2:{//比例尺
            [_map setShowMapScaleBar:sender.on];
//            _map setMapScaleBarPosition:<#(CGPoint)#>自已比例尺位置
        }
            break;
        default:
            break;
    }
}
- (IBAction)segmentAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [_map setCompassPosition:CGPointMake(10, 10)];
            break;
        case 1:
            [_map setCompassPosition:CGPointMake(__SCREEN_SIZE.width-47, 0)];
            break;
        default:
            break;
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
