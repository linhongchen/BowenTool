//
//  UIControl+Block.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "UIControl+Block.h"
#import <objc/runtime.h>

@implementation UIControl (Block)

#pragma mark - <<<<<< TouchDown >>>>>> -
- (void)ua_touchDown:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchDown:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchDownAction:)
   forControlEvents:UIControlEventTouchDown];
}
- (void)ua_touchDownAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchDown:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchDownRepeat >>>>>> -
- (void)ua_touchDownRepeat:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchDownRepeat:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchDownRepeatAction:)
   forControlEvents:UIControlEventTouchDownRepeat];
}
- (void)ua_touchDownRepeatAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchDownRepeat:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchDragInside >>>>>> -
- (void)ua_touchDragInside:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchDragInside:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchDragInsideAction:)
   forControlEvents:UIControlEventTouchDragInside];
}
- (void)ua_touchDragInsideAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchDragInside:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchDragOutside >>>>>> -
- (void)ua_touchDragOutside:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchDragOutside:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchDragOutsideAction:)
   forControlEvents:UIControlEventTouchDragOutside];
}
- (void)ua_touchDragOutsideAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchDragOutside:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchDragEnter >>>>>> -
- (void)ua_touchDragEnter:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchDragEnter:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchDragEnterAction:)
   forControlEvents:UIControlEventTouchDragEnter];
}
- (void)ua_touchDragEnterAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchDragEnter:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchDragExit >>>>>> -
- (void)ua_touchDragExit:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchDragExit:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchDragExitAction:)
   forControlEvents:UIControlEventTouchDragExit];
}
- (void)ua_touchDragExitAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchDragExit:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchUpInside >>>>>> -
- (void)ua_touchUpInside:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchUpInside:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchUpInsideAction:)
   forControlEvents:UIControlEventTouchUpInside];
}
- (void)ua_touchUpInsideAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchUpInside:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchUpOutside >>>>>> -
- (void)ua_touchUpOutside:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchUpOutside:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchUpOutsideAction:)
   forControlEvents:UIControlEventTouchUpOutside];
}
- (void)ua_touchUpOutsideAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchUpOutside:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< TouchCancel >>>>>> -
- (void)ua_touchCancel:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_touchCancel:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_touchCancelAction:)
   forControlEvents:UIControlEventTouchCancel];
}
- (void)ua_touchCancelAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_touchCancel:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< ValueChanged >>>>>> -
- (void)ua_valueChanged:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_valueChanged:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_valueChangedAction:)
   forControlEvents:UIControlEventValueChanged];
}
- (void)ua_valueChangedAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_valueChanged:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< EditingDidBegin >>>>>> -
- (void)ua_editingDidBegin:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_editingDidBegin:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_editingDidBeginAction:)
   forControlEvents:UIControlEventEditingDidBegin];
}
- (void)ua_editingDidBeginAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_editingDidBegin:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< EditingChanged >>>>>> -
- (void)ua_editingChanged:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_editingChanged:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_editingChangedAction:)
   forControlEvents:UIControlEventEditingChanged];
}
- (void)ua_editingChangedAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_editingChanged:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< EditingDidEnd >>>>>> -
- (void)ua_editingDidEnd:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_editingDidEnd:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_editingDidEndAction:)
   forControlEvents:UIControlEventEditingDidEnd];
}
- (void)ua_editingDidEndAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_editingDidEnd:));
    if (block)
    {
        block();
    }
}
#pragma mark - <<<<<< EditingDidEndOnExit >>>>>> -
- (void)ua_editingDidEndOnExit:(void (^)(void))eventBlock
{
    objc_setAssociatedObject(self, @selector(ua_editingDidEndOnExit:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(ua_editingDidEndOnExitAction:)
   forControlEvents:UIControlEventEditingDidEndOnExit];
}
- (void)ua_editingDidEndOnExitAction:(id)sender
{
    void (^block)(void) = objc_getAssociatedObject(self, @selector(ua_editingDidEndOnExit:));
    if (block)
    {
        block();
    }
}

@end
