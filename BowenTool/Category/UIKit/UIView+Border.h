//
//  UIView+Border.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UAViewBorderType) {
    UAViewBorderTop = 1<<1,
    UAViewBorderLeft = 1<<2,
    UAViewBorderBottom = 1<<3,
    UAViewBorderRight = 1<<4,
    UAViewBorderLeftAndBottom = 1<<5,
    UAViewBorderRightAndBottom = 1<<6,
};

@interface UIView (Border)

/** 边框类型(在view的frame确定后设置该属性) */
/** borderWidth 默认0.5*/
@property (nonatomic, assign) UAViewBorderType ua_borderType;

@end
