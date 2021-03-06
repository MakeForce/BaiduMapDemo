//
//  MainTableViewController.m
//  BaiduMapDemo
//
//  Created by iOS01 on 15-2-6.
//  Copyright (c) 2015年 OliverTheFerry. All rights reserved.
//

#import "MainTableViewController.h"
@interface MainTableViewController ()
{
    NSArray *nameList;
    NSArray *controllerList;
    IBOutlet UIView *line;
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    nameList = @[@"地图初始化 BasicMapViewController",@"多地图展示 DualmapViewController",@"图层展示 MapDemoViewController", @"地图操作 MapControlViewController",@"UI操作 MapViewUIOperatViewController",@"定位 LocationViewController",@"覆盖物 CoverMapViewController" ,@"自定义覆盖 CustomOverlayViewController",@"POI搜索 PoiSearchViewController",@"地理编码 GeocodeViewController",@"路径规划 RouteSearchViewController",@"公交路线查询 BusLineSearchViewController",@"离线地图 OfflineDemoViewController",@"热力地图 HeatMapDemo",@"短传分享 ShortUrlShareDemoViewController",@"云检索 CloudSearchDemoViewController",@"调用百度地图客户端OpenBaiduMapDemo",@"OpenGL绘制 OpenGLDemoViewController",@"收藏夹 FavoritesDemoViewController",@"周边雷达 RadarTabBarController"];
    controllerList = @[@"BaseMap",@"MultiMap",@"useMap1",@"control",@"uiControl",@"getLocation",@"mapCover",@"customOverlay",@"PoiSearchViewController",@"GeocodeViewController",@"RouteSearchViewController",@"BusLineSearchViewController",@"OfflineDemoViewController",@"HeatMapDemo",@"ShortUrlShareDemoViewController",@"CloudSearchDemoViewController",@"OpenBaiduMapDemo",@"OpenGLDemoViewController",@"FavoritesDemoViewController",@"RadarTabBarController"];
    [line setFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
    if(nameList.count > 0)
    {
        line.hidden = NO;
    }else
    {
        line.hidden = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return nameList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    cell.textLabel.text = [nameList objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<8) {
        [self performSegueWithIdentifier:controllerList[indexPath.row] sender:nil];
    }
    else if(indexPath.row < 18){
        Class className = NSClassFromString(controllerList[indexPath.row]);
        id controller = [[className alloc] init];
        [controller setTitle:nameList[indexPath.row]];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        NSString *identifier = (indexPath.row == 18)?@"FavoritesDemoViewController":@"RadarTabBarController";
        UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:identifier];
        [viewController setTitle:nameList[indexPath.row]];
        UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
        customLeftBarButtonItem.title = @"返回";
        self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
