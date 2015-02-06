//
//  KHPaoPaoView.m
//  BaiduMapDemo
//
//  Created by iOS01 on 15-2-6.
//  Copyright (c) 2015年 OliverTheFerry. All rights reserved.
//

#import "KHPaoPaoView.h"

@implementation KHPaoPaoView


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        //        这里需要注意百度地图中使用的是碎图片拼起来的,这里的细化工作呵呵 你们自己完成吧！
        UIImage *image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"medium@2x" ofType:@"png"]];
        
        self.frame = CGRectMake(0, 0, image.size.width+10, image.size.height+10);
        UIImageView *IMG = [[UIImageView alloc] initWithFrame:self.frame];
        IMG.image = image;
        IMG.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:IMG];
        
        label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,  __SCREEN_SIZE.width-100, 15)];
        [label1 setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:label1];
        label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 25,  __SCREEN_SIZE.width-100, 15)];
        [label2 setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:label2];
        label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40,  __SCREEN_SIZE.width-100, 15)];
        [label3 setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:label3];
        label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 55,  __SCREEN_SIZE.width-100, 15)];
        [label4 setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:label4];
    }
    return self;
}
-(void)setAnnotationWith:(KHPointAnnotation *)point
{
    label1.text = point.title;
    label2.text = point.subtitle;
    label3.text = point.title1;
    label4.text = point.title2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
