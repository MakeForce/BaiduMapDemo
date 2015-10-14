//
//  KHCustomOverlay.h
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/14.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

@interface KHCustomOverlay : BMKShape<BMKOverlay>
{
    @package
    BMKMapPoint *_points;
    int _pointCount;
    BMKMapRect _boundingMapRect;
}
@property (nonatomic, readonly) BMKMapRect boundingMapRect;
@property (nonatomic, readonly) BMKMapPoint* points;
@property (nonatomic, readonly) int pointCount;
-(id)initWithPoints:(BMKMapPoint *)points count:(NSUInteger)count;

+ (KHCustomOverlay *)customWithPoints:(BMKMapPoint *)points count:(NSUInteger)count;

@end
