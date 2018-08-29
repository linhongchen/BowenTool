//
//  UIView+UA.m
//  RAC-Bowen
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "UIView+UA.h"

@implementation UIView (UA)
- (CGFloat)left
{
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top
{
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX
{
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY
{
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width
{
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height
{
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin
{
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size
{
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}



+ (instancetype)lineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightTextColor];
    return lineView;
}

+ (instancetype)lineGrayView
{
    UIView *lineGrayView = [[UIView alloc] init];
    lineGrayView.backgroundColor = [UIColor lightGrayColor];
    return lineGrayView;
}

- (void)shake
{
    CAKeyframeAnimation *animationKey = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animationKey setDuration:0.5f];
    
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [animationKey setValues:array];
    
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [animationKey setKeyTimes:times];
    
    [self.layer addAnimation:animationKey forKey:@"UATextFieldShake"];
}

- (void)addGradientLayer
{
    if (self.superview)
    {
        [self.superview layoutIfNeeded];
    }
    UIColor *color1 = [UIColor colorWithRed:(0)  green:(0)  blue:(0)   alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:(0)  green:(0)  blue:(0)  alpha:0.8];
    UIColor *color3 = [UIColor colorWithRed:(0)  green:(0)  blue:(0)  alpha:0.2];
    NSArray *colors = [NSArray arrayWithObjects:(id)color1.CGColor, color2.CGColor,color3.CGColor, nil];
    NSArray *locations = [NSArray arrayWithObjects:@(0.0), @(0.7),@(1.0), nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1, 0);
    self.layer.mask = gradientLayer;
}

@end


#import <objc/runtime.h>

@implementation UIView(NTESPresent)


static char PresentedViewAddress;       //被Present的View
static char PresentingViewAddress;      //正在Present其他视图的view
static char PresentedViewAnimationType; //PresentView的动画类型

#define AnimateDuartion 0.55f

- (void)uapresentView:(UIView *)view
             complete:(void (^)(void))complete
{
    [self uapresentView:view
          willAnimation:nil
            doAnimation:nil
               complete:complete];
}

- (void)uapresentView:(UIView *)view
        willAnimation:(void (^)(void))willAnimation
          doAnimation:(void (^)(void))doAnimation
             complete:(void (^)(void))complete

{
    UIColor *blackViewColor = [[UIColor blackColor]
                               colorWithAlphaComponent:0];
    [self uapresentView:view
         blackViewColor:blackViewColor
            animateType:UA_AnimationType_Present
               animated:YES
          willAnimation:willAnimation
            doAnimation:doAnimation
               complete:complete];
}

- (void)uapresentTransformView:(UIView*)view
                      complete:(void(^)(void)) complete
{
    [self uapresentTransformView:view
                   willAnimation:nil
                     doAnimation:nil
                        complete:complete];
}

- (void)uapresentTransformView:(UIView*)view
                 willAnimation:(void (^)(void))willAnimation
                   doAnimation:(void (^)(void))doAnimation
                      complete:(void(^)(void)) complete
{
    UIColor *blackViewColor = [[UIColor blackColor]
                               colorWithAlphaComponent:0];
    
    [self uapresentView:view
         blackViewColor:blackViewColor
            animateType:UA_AnimationType_Transcale
               animated:YES
          willAnimation:willAnimation
            doAnimation:doAnimation
               complete:complete];
}

- (void)uapresentView:(UIView *)view
       blackViewColor:(UIColor *)blackViewColor
          animateType:(UA_AnimationType)animateType
             animated:(BOOL)animated
        willAnimation:(void (^)(void))willAnimation
          doAnimation:(void (^)(void))doAnimation
             complete:(void(^)(void)) complete
{
    if (!self.window) return;

    UIView *blackView = [[UIView alloc] initWithFrame:self.window.bounds];
    blackView.backgroundColor = blackViewColor;
    [blackView addSubview:view];
    view.tag = 0x555;
    [self.window addSubview:blackView];
    objc_setAssociatedObject(self, &PresentedViewAddress, blackView, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(view, &PresentingViewAddress, self, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(view, &PresentedViewAnimationType, [NSNumber numberWithInteger:animateType], OBJC_ASSOCIATION_RETAIN);
    if (animated)
    {
        [self uadoAlertAnimate:blackView
                   animateType:animateType
                 willAnimation:willAnimation
                   doAnimation:doAnimation
                      complete:complete];
    }
    else
    {
        view.alpha = 1;
    }
}



- (UIView *)uapresentedView
{
    UIView *blackView =  objc_getAssociatedObject(self, &PresentedViewAddress);
    return blackView;
}

- (void)uadismissPresentedView:(BOOL)animated
                      complete:(void(^)(void)) complete
{
    [self uadismissPresentedView:animated willAnimation:nil complete:complete];
}

- (void)uadismissPresentedView:(BOOL)animated
                 willAnimation:(void(^)(void)) willAnimation
                      complete:(void(^)(void)) complete
{
    UIView *blackView =  objc_getAssociatedObject(self, &PresentedViewAddress);

    if (animated)
    {
        [self uadoHideAnimate:blackView
                willAnimation:willAnimation
                     complete:complete];
    }
    else
    {
        [blackView removeFromSuperview];
        [self uacleanAssocaiteObject];
    }
}

- (void)uahideSelf:(BOOL)animated
          complete:(void(^)(void)) complete
{
    [self uahideSelf:animated willAnimation:nil complete:complete];
}

- (void)uahideSelf:(BOOL)animated
     willAnimation:(void(^)(void)) willAnimation
          complete:(void(^)(void)) complete
{
    UIView *blackView =  objc_getAssociatedObject(self, &PresentingViewAddress);
    
    if (!blackView) return;

    [blackView uadismissPresentedView:animated
                        willAnimation:willAnimation
                             complete:complete];
}

#pragma mark - Animation
- (void)uadoAlertAnimate:(UIView*)blackView
             animateType:(UA_AnimationType)animateType
           willAnimation:(void (^)(void))willAnimation
             doAnimation:(void (^)(void))doAnimation
                complete:(void(^)(void)) complete
{
    UIView *view = [blackView viewWithTag:0x555];
    
    if (!view) return;
    
    CGFloat animationDuration = 0.0;
    
    if (animateType == UA_AnimationType_Transcale)
    {
        if (willAnimation)
        {
            willAnimation();
        }
        
        animationDuration = 0.5;
        
        view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.3 animations:^{
            view.transform = CGAffineTransformMakeScale(1.1, 1.1);
            if (doAnimation)
            {
                doAnimation();
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformMakeScale(1, 1);
            }];
        }];
    }
    else if (animateType == UA_AnimationType_Present)
    {
        if (willAnimation)
        {
            willAnimation();
        }
        
        animationDuration = 0.45;
        
        //CGFloat yy = contentView.y;
        //contentView.y = blackView.height;
        // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
        //[UIView animateWithDuration: 0.45 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:0 animations:^{
        //    contentView.y = yy;
        //} completion:nil];
    
        CGRect bounds = view.bounds;
        // 放大
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        scaleAnimation.duration  = animationDuration;
        scaleAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)];
        scaleAnimation.toValue   = [NSValue valueWithCGRect:bounds];
        
        // 移动
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        moveAnimation.duration   = animationDuration;
        moveAnimation.fromValue  = [NSValue valueWithCGPoint:[self.superview convertPoint:self.center toView:nil]];
        moveAnimation.toValue    = [NSValue valueWithCGPoint:self.window.center];
        
        CAAnimationGroup *group  = [CAAnimationGroup animation];
        group.beginTime          = CACurrentMediaTime();
        group.duration           = animationDuration;
        group.animations         = [NSArray arrayWithObjects:scaleAnimation,moveAnimation,nil];
        group.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group.fillMode           = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.autoreverses        = NO;
        
        [view.layer addAnimation:group forKey:@"groupAnimationAlert"];
        
        if (doAnimation)
        {
            doAnimation();
        }
    }
    
    //*****************************************************************************************
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (complete)
        {
            complete();
        }
    });
}

- (void)uadoHideAnimate:(UIView*)blackView
          willAnimation:(void(^)(void)) willAnimation
               complete:(void(^)(void)) complete
{
    if (!blackView) return;
    
    UIView *view = [blackView viewWithTag:0x555];
    
    NSNumber *type = objc_getAssociatedObject(self, &PresentedViewAnimationType);
    UA_AnimationType animateType = [type integerValue];
    
    CGFloat animationDuration = 0.0;

    if (animateType == UA_AnimationType_Transcale)
    {
        if (willAnimation)
        {
            willAnimation();
        }
        animationDuration = 0.35;
        [UIView animateWithDuration:animationDuration animations:^{
            view.transform = CGAffineTransformMakeScale(0.01, 0.01);
            //CGAffineTransform transform2 = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01);
            //view.transform = CGAffineTransformRotate(transform2, M_PI);
            view.alpha = 0;
        } completion:^(BOOL finished) {
            view.alpha = 1;
        }];
    }
    else if (animateType == UA_AnimationType_Present)
    {
        if (willAnimation)
        {
            willAnimation();
        }
        animationDuration = 0.45;
        
        // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
        //[UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.4 options:0 animations:^{
        //    contentView.y = blackView.height;
        //} completion:nil];
        // 缩小
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        scaleAnimation.duration = animationDuration;
        scaleAnimation.toValue  = [NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)];
        
        CGPoint position   = self.center;
        // 移动
        CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        moveAnimation.duration = animationDuration;
        moveAnimation.toValue  = [NSValue valueWithCGPoint:[self.superview convertPoint:self.center toView:nil]];
        
        CAAnimationGroup *group   = [CAAnimationGroup animation];
        group.beginTime           = CACurrentMediaTime();
        group.duration            = animationDuration;
        group.animations          = [NSArray arrayWithObjects:scaleAnimation,moveAnimation,nil];
        group.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group.fillMode            = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.autoreverses        = NO;
        
        view.layer.bounds    = self.bounds;
        view.layer.position  = position;
        view.layer.needsDisplayOnBoundsChange = YES;
        
        view.backgroundColor = [UIColor clearColor];
        
        [view.layer addAnimation:group forKey:@"uagroupAnimationHide"];
    }
    
    __weak __typeof__(self) weakSelf = self;
    __weak __typeof__(blackView) weakBlackView = blackView;
    //*****************************************************************************************
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong __typeof__(weakSelf) strongSelf = weakSelf;
        __strong __typeof__(weakBlackView) strongBlackView = weakBlackView;

        [strongBlackView removeFromSuperview];
        [strongSelf uacleanAssocaiteObject];
        if (complete)
        {
            complete();
        }
    });
}

- (void)uacleanAssocaiteObject
{
    objc_setAssociatedObject(self,&PresentedViewAddress,nil,OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self,&PresentingViewAddress,nil,OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self,&PresentedViewAnimationType,nil,OBJC_ASSOCIATION_RETAIN);
}

@end
