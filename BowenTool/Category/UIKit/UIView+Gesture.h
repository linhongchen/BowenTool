//
//  UIView+Gesture.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gesture)

/**
 *  轻击手势
 *
 *  @param numberOfTouches 触摸手指数
 *  @param numberOfTaps    点击次数
 *  @param block           回调
 */
- (void)ua_whenTouches:(NSUInteger)numberOfTouches taps:(NSUInteger)numberOfTaps block:(void(^)(UITapGestureRecognizer *tapGesture))block;
/**
 *  @brief  单击手势
 *
 *  @param block 回调
 */
- (void)ua_whenTapped:(void(^)(UITapGestureRecognizer *tapGesture))block;
/**
 *  @brief  双击手势
 *
 *  @param block 回调
 */
- (void)ua_whenDoubleTapped:(void(^)(UITapGestureRecognizer *tapGesture))block;

/**
 *  @brief  长按手势
 *
 *  @param block 回调
 */
- (void)ua_whenLongPressed:(void(^)(UILongPressGestureRecognizer *longPressGesture))block;

/**
 *  轻扫手势
 *
 *  @param numberOfTouches 触摸手指数
 *  @param direction       轻扫方向
 *  @param block           回调
 */
- (void)ua_whenSwipedWithTouches:(NSUInteger)numberOfTouches direction:(UISwipeGestureRecognizerDirection)direction block:(void(^)(UISwipeGestureRecognizer *swipeGesture))block;
/**
 *  @brief  单指轻扫
 *
 *  @param block 回调
 */
- (void)ua_whenSwipedWithDirection:(UISwipeGestureRecognizerDirection)direction block:(void(^)(UISwipeGestureRecognizer *swipeGesture))block;
- (void)ua_whenSwipedLeft:(void(^)(UISwipeGestureRecognizer *swipeGesture))block;
- (void)ua_whenSwipedRight:(void(^)(UISwipeGestureRecognizer *swipeGesture))block;
- (void)ua_whenSwipedUp:(void(^)(UISwipeGestureRecognizer *swipeGesture))block;
- (void)ua_whenSwipedDown:(void(^)(UISwipeGestureRecognizer *swipeGesture))block;

/**
 *  @brief  捏合手势
 *
 *  @param block 回调
 */
- (void)ua_whenPinch:(void(^)(UIPinchGestureRecognizer *pinchGesture))block;

/**
 *  @brief  拖动手势
 *
 *  @param block 回调
 */
- (void)ua_whenPan:(void(^)(UIPanGestureRecognizer *pinchGesture))block;

/**
 *  @brief  旋转手势
 *
 *  @param block 回调
 */
- (void)ua_whenRotation:(void(^)(UIRotationGestureRecognizer *pinchGesture))block;


@end

NS_ASSUME_NONNULL_END
