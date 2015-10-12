//
//  MapDemoViewController.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/12.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "MapDemoViewController.h"

@interface MapDemoViewController ()<BMKMapViewDelegate>
@property (nonatomic, weak) IBOutlet BMKMapView *map;
@end

@implementation MapDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _map.mapType = BMKMapTypeStandard;
}
-(void)viewWillAppear:(BOOL)animated{
    [_map viewWillAppear];
    _map.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_map viewWillDisappear];
    _map.delegate = nil;
}
-(IBAction)changeMapType:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            _map.mapType = BMKMapTypeStandard;
            break;
        case 1:
            _map.mapType = BMKMapTypeSatellite;
            break;
        default:
            break;
    }
}
-(IBAction)switchValueChange:(UISwitch *)sender{
    switch (sender.tag) {
        case 0:
            [_map setTrafficEnabled:sender.on];//实时路况
            break;
        case 1:
            [_map setBaiduHeatMapEnabled:sender.on];//热力图层
            break;
        case 2:
            [_map setBuildingsEnabled:sender.on];//3D楼宇
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
