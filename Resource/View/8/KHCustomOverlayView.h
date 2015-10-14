//
//  KHCustomOverlayView.h
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/14.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

@class KHCustomOverlay;
@interface KHCustomOverlayView : BMKOverlayGLBasicView
- (id)initWithCustomOverlay:(KHCustomOverlay *)customOverlay;

@property (nonatomic, readonly) KHCustomOverlay *customOverlay;
@end
