//
//  KHCustomOverlayView.m
//  BaiduMapDemo
//
//  Created by Xa_sanLingYI on 15/10/14.
//  Copyright © 2015年 OliverTheFerry. All rights reserved.
//

#import "KHCustomOverlayView.h"
#import "KHCustomOverlay.h"
@implementation KHCustomOverlayView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (KHCustomOverlay *)customOverlay
{
    return (KHCustomOverlay*)self.overlay;
}
- (id)initWithCustomOverlay:(KHCustomOverlay *)customOverlay;
{
    self = [super initWithOverlay:customOverlay];
    if (self)
    {
        
    }
    
    return self;
}

- (void)glRender
{
    //自定义overlay绘制
    KHCustomOverlay *customOverlay = [self customOverlay];
    if (customOverlay.pointCount >= 3) {
        self->keepScale = NO;
        
        [self renderLinesWithPoints:customOverlay.points pointCount:customOverlay.pointCount strokeColor:self.strokeColor lineWidth:self.lineWidth looped:YES lineDash:YES];
        [self renderRegionWithPoints:customOverlay.points pointCount:customOverlay.pointCount fillColor:self.fillColor usingTriangleFan:YES];
    } else {
        GLuint testureID = [self loadStrokeTextureImage:[UIImage imageNamed:@"line"]];
        if (testureID) {
            [self renderTexturedLinesWithPoints:customOverlay.points pointCount:customOverlay.pointCount lineWidth:30 textureID:testureID looped:NO];
        } else {
            [self renderLinesWithPoints:customOverlay.points pointCount:customOverlay.pointCount strokeColor:self.strokeColor lineWidth:self.lineWidth looped:NO];
        }
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
