//
//  UIView+Find.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "UIView+Find.h"

@implementation UIView (Find)

/**
 *  @brief  找到指定类名的view对象
 *
 *  @param clazz view类名
 *
 *  @return view对象
 */
- (id)ua_findSubViewWithSubViewClass:(Class)clazz
{
    for (id subView in self.subviews)
    {
        if ([subView isKindOfClass:clazz])
        {
            return subView;
        }
    }
    return nil;
}
/**
 *  @brief  找到指定类名的SuperView对象
 *
 *  @param clazz SuperView类名
 *
 *  @return view对象
 */
- (id)ua_findSuperViewWithSuperViewClass:(Class)clazz
{
    if (self == nil)
    {
        return nil;
    }
    else if (self.superview == nil)
    {
        return nil;
    }
    else if ([self.superview isKindOfClass:clazz])
    {
        return self.superview;
    }
    else
    {
        return [self.superview ua_findSuperViewWithSuperViewClass:clazz];
    }
}
/**
 *  @brief  找到并且resign第一响应者
 *
 *  @return 结果
 */
- (BOOL)ua_findAndResignFirstResponder
{
    if (self.isFirstResponder)
    {
        [self resignFirstResponder];
        return YES;
    }
    
    for (UIView *v in self.subviews)
    {
        if ([v ua_findAndResignFirstResponder])
        {
            return YES;
        }
    }
    return NO;
}
/**
 *  @brief  找到第一响应者
 *
 *  @return 第一响应者
 */
- (UIView *)ua_findFirstResponder
{
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder))
    {
        return self;
    }
    
    for (UIView *v in self.subviews)
    {
        UIView *fv = [v ua_findFirstResponder];
        if (fv)
        {
            return fv;
        }
    }
    
    return nil;
}

/**
 *  @brief  找到当前view所在的viewcontroler
 */
- (UIViewController *)ua_viewController
{
    for (UIView *next = self; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
