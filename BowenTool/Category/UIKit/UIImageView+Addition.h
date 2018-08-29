//
//  UIImageView+Addition.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Addition)

/**
 *  @brief  根据bundle中的图片名创建imageview
 *
 *  @param imageName bundle中的图片名
 *
 *  @return imageview
 */
+ (id)ua_imageViewWithImageNamed:(NSString*)imageName;
/**
 *  @brief  根据frame创建imageview
 *
 *  @param frame imageview frame
 *
 *  @return imageview
 */
+ (id)ua_imageViewWithFrame:(CGRect)frame;

+ (id)ua_imageViewWithStretchableImage:(NSString*)imageName Frame:(CGRect)frame;
/**
 *  @brief  创建imageview动画
 *
 *  @param imageArray 图片名称数组
 *  @param duration   动画时间
 *
 *  @return imageview
 */
+ (id)ua_imageViewWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;
- (void)ua_setImageWithStretchableImage:(NSString*)imageName;


// 画水印
// 图片水印
- (void)ua_setImage:(UIImage *)image waterMark:(UIImage *)mark inRect:(CGRect)rect;
// 文字水印
- (void)ua_setImage:(UIImage *)image stringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (void)ua_setImage:(UIImage *)image stringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;

@end
