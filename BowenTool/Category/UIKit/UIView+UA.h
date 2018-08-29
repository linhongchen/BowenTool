//
//  UIView+UA.h
//  RAC-Bowen
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UA)

@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

+ (instancetype)lineView;

+ (instancetype)lineGrayView;

- (void)shake;

//添加渐变蒙版
- (void)addGradientLayer;
@end

typedef enum : NSUInteger {
    UA_AnimationType_Transcale = 0,
    UA_AnimationType_Present,
} UA_AnimationType;

@interface UIView (NTESPresent)

//弹出一个UA自动以动画效果的窗口
- (void)uapresentView:(UIView*)view
             complete:(void(^)(void)) complete;
//弹出一个UA自动以动画效果的窗口
- (void)uapresentView:(UIView*)view
        willAnimation:(void(^)(void)) willAnimation
          doAnimation:(void(^)(void)) doAnimation
             complete:(void(^)(void)) complete;

//弹出一个类似present效果的窗口
- (void)uapresentTransformView:(UIView*)view
                      complete:(void(^)(void)) complete;
//UA自定义
//弹出一个类似present效果的窗口
- (void)uapresentTransformView:(UIView*)view
                 willAnimation:(void(^)(void)) willAnimation
                   doAnimation:(void(^)(void)) doAnimation
                      complete:(void(^)(void)) complete;

- (void)uapresentView:(UIView *)contentView
       blackViewColor:(UIColor *)color
          animateType:(UA_AnimationType)animateType
             animated:(BOOL)animated
        willAnimation:(void(^)(void)) willAnimation
          doAnimation:(void(^)(void)) doAnimation
             complete:(void(^)(void)) complete;


//获取一个view上正在被present的view
- (UIView *)uapresentedView;

- (void)uadismissPresentedView:(BOOL)animated
                      complete:(void(^)(void)) complete;
- (void)uadismissPresentedView:(BOOL)animated
                 willAnimation:(void(^)(void)) willAnimation
                      complete:(void(^)(void)) complete;

//这个是被present的窗口本身的方法
//如果自己是被present出来的，消失掉
- (void)uahideSelf:(BOOL)animated
          complete:(void(^)(void)) complete;
- (void)uahideSelf:(BOOL)animated
     willAnimation:(void(^)(void)) willAnimation
          complete:(void(^)(void)) complete;

@end
