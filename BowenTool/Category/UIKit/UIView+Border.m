//
//  UIView+Border.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

@dynamic ua_borderType;
/** 设置边框类型 */
- (void)setUa_borderType:(UAViewBorderType)ua_borderType
{
    CGFloat bh = self.layer.borderWidth;
    if (ua_borderType & UAViewBorderBottom)
    {
        [self addBottomBorder:self borderHeight:bh];
    }
    if (ua_borderType & UAViewBorderLeft)
    {
        [self addLeftBorder:self borderHeight:bh];
    }
    if (ua_borderType & UAViewBorderRight)
    {
        [self addRightBorder:self borderHeight:bh];
    }
    if (ua_borderType & UAViewBorderTop)
    {
        [self addTopBorder:self borderHeight:bh];
    }
    if (ua_borderType & UAViewBorderLeftAndBottom)
    {
        [self addBottomBorder:self borderHeight:bh];
        [self addLeftBorder:self borderHeight:bh];
    }
    if (ua_borderType & UAViewBorderRightAndBottom)
    {
        [self addBottomBorder:self borderHeight:bh];
        [self addRightBorder:self borderHeight:bh];
    }
    self.layer.borderWidth = 0;
}

#pragma mark - private
/** 设置边框的frame */
- (void)addTopBorder:(UIView *)vi borderHeight:(CGFloat)bh
{
    CGRect frame = CGRectMake(0, 0, vi.frame.size.width, bh);
    [self addBorderLayerWithFrame:frame];
}
- (void)addLeftBorder:(UIView *)vi borderHeight:(CGFloat)bh
{
    CGRect frame = CGRectMake(0, 0, bh, vi.frame.size.height);
    [self addBorderLayerWithFrame:frame];
}
- (void)addBottomBorder:(UIView *)vi borderHeight:(CGFloat)bh
{
    CGRect frame = CGRectMake(0, vi.frame.size.height-bh, vi.frame.size.width, bh);
    [self addBorderLayerWithFrame:frame];
}
- (void)addRightBorder:(UIView *)vi borderHeight:(CGFloat)bh
{
    CGRect frame = CGRectMake(vi.frame.size.width-bh, 0, bh, vi.frame.size.height);
    [self addBorderLayerWithFrame:frame];
}

/** 添加边框到view上 */
- (void)addBorderLayerWithFrame:(CGRect)frame
{
    CALayer *border = [CALayer layer];
    border.frame = frame;
    border.backgroundColor = self.layer.borderColor;
    [self.layer addSublayer:border];
}

@end
