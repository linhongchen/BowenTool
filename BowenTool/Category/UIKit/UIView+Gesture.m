//
//  UIView+Gesture.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>

#define ua_objcAssociatedGesturekKey (__bridge const void *)(block)
#define ua_objcAssociatedBlockkKey (__bridge const void *)(gesture)
@implementation UIView (Gesture)

/* 轻击手势key */
//static char ua_kActionHandlerTapBlockKey;
- (void)ua_whenTouches:(NSUInteger)numberOfTouches taps:(NSUInteger)numberOfTaps block:(void (^)(UITapGestureRecognizer * _Nonnull))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, ua_objcAssociatedGesturekKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ua_handleActionForTapGesture:)];
        gesture.numberOfTouchesRequired = numberOfTouches; //触摸手指数
        gesture.numberOfTapsRequired = numberOfTaps; //点击次数
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, ua_objcAssociatedGesturekKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, ua_objcAssociatedBlockkKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)ua_handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^block)(UITapGestureRecognizer *) = objc_getAssociatedObject(self, ua_objcAssociatedBlockkKey);
        if (block) block(gesture);
    }
}

/* 单击 */
- (void)ua_whenTapped:(void (^)(UITapGestureRecognizer * _Nonnull))block
{
    [self ua_whenTouches:1 taps:1 block:block];
}
/* 双击 */
- (void)ua_whenDoubleTapped:(void (^)(UITapGestureRecognizer * _Nonnull))block
{
    [self ua_whenTouches:1 taps:2 block:block];
}

/* 长按手势key */
static char ua_kActionHandlerLongPressBlockKey;

- (void)ua_whenLongPressed:(void (^)(UILongPressGestureRecognizer * _Nonnull))block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, ua_objcAssociatedGesturekKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(ua_handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, ua_objcAssociatedGesturekKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &ua_kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)ua_handleActionForLongPressGesture:(UILongPressGestureRecognizer*)gesture
{
    void(^block)(UILongPressGestureRecognizer *) = objc_getAssociatedObject(self, &ua_kActionHandlerLongPressBlockKey);
    if (block) block(gesture);
}

/* 轻扫手势key */
//static char ua_kActionHandlerSwipeBlockKey;

- (void)ua_whenSwipedWithTouches:(NSUInteger)numberOfTouches direction:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer * _Nonnull))block
{
    UISwipeGestureRecognizer *gesture = objc_getAssociatedObject(self, ua_objcAssociatedGesturekKey);
    if (!gesture)
    {
        gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ua_handleActionForSwipeGesture:)];
        gesture.numberOfTouchesRequired = numberOfTouches; //触摸手指数
        gesture.direction = direction; //轻扫方向
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, ua_objcAssociatedGesturekKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, ua_objcAssociatedBlockkKey, block, OBJC_ASSOCIATION_COPY);
}
/* 单指轻扫 */
- (void)ua_whenSwipedWithDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer * _Nonnull))block
{
    [self ua_whenSwipedWithTouches:1 direction:direction block:block];
}
- (void)ua_whenSwipedLeft:(void (^)(UISwipeGestureRecognizer * _Nonnull))block
{
    [self ua_whenSwipedWithDirection:UISwipeGestureRecognizerDirectionLeft block:block];
}
- (void)ua_whenSwipedRight:(void (^)(UISwipeGestureRecognizer * _Nonnull))block
{
    [self ua_whenSwipedWithDirection:UISwipeGestureRecognizerDirectionRight block:block];
}
- (void)ua_whenSwipedUp:(void (^)(UISwipeGestureRecognizer * _Nonnull))block
{
    [self ua_whenSwipedWithDirection:UISwipeGestureRecognizerDirectionUp block:block];
}
- (void)ua_whenSwipedDown:(void (^)(UISwipeGestureRecognizer * _Nonnull))block
{
    [self ua_whenSwipedWithDirection:UISwipeGestureRecognizerDirectionDown block:block];
}

- (void)ua_handleActionForSwipeGesture:(UISwipeGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^block)(UISwipeGestureRecognizer *) = objc_getAssociatedObject(self, ua_objcAssociatedBlockkKey);
        if (block) block(gesture);
    }
}

/* 捏合手势key */
static char ua_kActionHandlerPinchBlockKey;

- (void)ua_whenPinch:(void (^)(UIPinchGestureRecognizer * _Nonnull))block
{
    UIPinchGestureRecognizer *gesture = objc_getAssociatedObject(self, ua_objcAssociatedGesturekKey);
    if (!gesture)
    {
        gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(ua_handleActionForPinchGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, ua_objcAssociatedGesturekKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &ua_kActionHandlerPinchBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)ua_handleActionForPinchGesture:(UIPinchGestureRecognizer*)gesture
{
    void(^block)(UIPinchGestureRecognizer *) = objc_getAssociatedObject(self, &ua_kActionHandlerPinchBlockKey);
    if (block) block(gesture);
}

/* 拖动手势key */
static char ua_kActionHandlerPanBlockKey;

- (void)ua_whenPan:(void (^)(UIPanGestureRecognizer * _Nonnull))block
{
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, ua_objcAssociatedGesturekKey);
    if (!gesture)
    {
        gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(ua_handleActionForPanGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, ua_objcAssociatedGesturekKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &ua_kActionHandlerPanBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)ua_handleActionForPanGesture:(UIPanGestureRecognizer*)gesture
{
    void(^block)(UIPanGestureRecognizer *) = objc_getAssociatedObject(self, &ua_kActionHandlerPanBlockKey);
    if (block) block(gesture);
}

/* 旋转手势key */
static char ua_kActionHandlerRotationBlockKey;

- (void)ua_whenRotation:(void (^)(UIRotationGestureRecognizer * _Nonnull))block
{
    UIRotationGestureRecognizer *gesture = objc_getAssociatedObject(self, ua_objcAssociatedGesturekKey);
    if (!gesture)
    {
        gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(ua_handleActionForRotationGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, ua_objcAssociatedGesturekKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &ua_kActionHandlerRotationBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)ua_handleActionForRotationGesture:(UIRotationGestureRecognizer*)gesture
{
    void(^block)(UIRotationGestureRecognizer *) = objc_getAssociatedObject(self, &ua_kActionHandlerRotationBlockKey);
    if (block) block(gesture);
}

@end
