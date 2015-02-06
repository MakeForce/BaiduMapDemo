//
//  KHPaoPaoView.h
//  BaiduMapDemo
//
//  Created by iOS01 on 15-2-6.
//  Copyright (c) 2015年 OliverTheFerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHPointAnnotation.h"

@interface KHPaoPaoView : UIView
{
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
}
-(instancetype)init;
/**
 *   设置标注
 *
 *   @param point 标注
 */
-(void)setAnnotationWith:(KHPointAnnotation *)point;
@end
