//
//  UIButton+UA.m
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import "UIButton+UA.h"
#import <objc/runtime.h>

static const void *associatedKey = "associatedKey";
@implementation UIButton (UA)

/** 为Button扩充一个点击的Block属性 */
- (void)setClick:(clickBlock)click
{
    objc_setAssociatedObject(self, associatedKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (click) {
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (clickBlock)click
{
    return objc_getAssociatedObject(self, associatedKey);
}

- (void)buttonClick:(UIButton *)sender
{
    if (self.click) {
        self.click(sender);
    }
}


+ (instancetype)getButton:(CGRect)frame
                 fontSize:(int)fontSize
                 boldFont:(BOOL)boldFont
                     text:(NSString *)text
                textColor:(UIColor*)textColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    if (boldFont)
    {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.tintColor = [UIColor clearColor];
    if (text)
    {
        [button setTitle:text forState:UIControlStateNormal];
    }
    return button;
}


#pragma mark - <<<<<< ButtonType >>>>>> -
- (void)setbuttonType:(UAButtonType)type
{
    
    [self layoutIfNeeded];
    
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    
    //    CGFloat space = titleFrame.origin.x - imageFrame.origin.x - imageFrame.size.width;
    CGFloat space = 10;
    
    if (type == UAButtonTypeLeft)
    {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,titleFrame.size.width + space, 0, -(titleFrame.size.width + space))];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(titleFrame.origin.x - imageFrame.origin.x), 0, titleFrame.origin.x - imageFrame.origin.x)];
    }
    else if(type == UAButtonTypeBottom)
    {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleFrame.size.height + space, -(titleFrame.size.width))];
        
        [self setTitleEdgeInsets:UIEdgeInsetsMake(imageFrame.size.height + space, -(imageFrame.size.width), 0, 0)];
    }
}

- (void)layoutButtonWithStyle:(UAButtonStyle)style
                        space:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    //CGFloat labStrWidth = [[self currentTitle] stringSizeWithFont:self.titleLabel.font].width;
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    }
    else
    {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style)
    {
        case UAButtonStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case UAButtonStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case UAButtonStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case UAButtonStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


- (void)addTarget:(id)target action:(SEL)action
{
    self.enabled = YES;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)addBottomLine
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.currentTitle];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSFontAttributeName value:self.titleLabel.font range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:self.currentTitleColor range:strRange];
    [self setAttributedTitle:str forState:UIControlStateNormal];
}

- (CGSize)buttonSize
{
    if (!self.currentTitle || self.currentTitle.hash == @"".hash) return CGSizeZero;
    
    CGSize size = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

#pragma mark - <<<<<< Tool >>>>>> -
+ (CGFloat)defaultheight
{
    return 73;
}

+ (UIButton *)sureButtonWithText:(NSString *)text
{
    UIButton *sureButton = [UIButton getButton:CGRectZero
                                      fontSize:30
                                      boldFont:YES
                                          text:text
                                     textColor:[UIColor whiteColor]];
    [sureButton setBackgroundColor:[UIColor redColor]];
    [sureButton.layer setCornerRadius:4];
    [sureButton.layer setMasksToBounds:YES];
    [sureButton.layer setBorderWidth:0.5];
    [sureButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    return sureButton;
}

@end
