//
//  UIImage+UA.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UA)

#pragma mark - <<<<<< OriginalImage >>>>>> -
+ (UIImage *)ua_imageNamed:(NSString *)name;


#pragma mark - <<<<<< 二维码 >>>>>> -
//普通二维码-转带图片的二维码
- (UIImage *)createIconQRCodeImageWithIcon:(CIImage *)image iconSize:(CGFloat)iconSize;
+ (UIImage *)createQRCodeImageWithString:(NSString *)string size:(CGFloat) size;
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image size:(CGFloat) size;


#pragma mark - <<<<<< 根据颜色生成纯色图片 >>>>>> -
//根据颜色生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;



#pragma mark - <<<<<< 图片某一点的颜色 >>>>>> -
//取图片某一点的颜色
- (UIColor *)ua_colorAtPoint:(CGPoint )point;
//取某一像素的颜色
- (UIColor *)ua_colorAtPixel:(CGPoint)point;
//获得灰度图
+ (UIImage*)ua_covertToGrayImageFromImage:(UIImage*)sourceImage;



#pragma mark - <<<<<< 无缓存的图片 >>>>>> -
//根据main bundle中的文件名读取图片
//return 无缓存的图片
+ (UIImage *)ua_imageWithFileName:(NSString *)name;
+ (UIImage *)ua_imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle;


#pragma mark - <<<<<< 图片尺寸 >>>>>> -
//压缩图片
- (UIImage *)ua_compressImage;
- (UIImage *)ua_changeImageSize:(CGSize)size;
//截取部分图像
- (UIImage *)ua_clipSubImage:(CGRect)rect;
//等比例缩放-size缩放尺寸
- (UIImage *)ua_scaleToSize:(CGSize)size;
//图片切成圆形
- (instancetype)ua_circleImage;
+ (instancetype)ua_circleImage:(NSString *)image;




+ (UIImage*)ua_resizableHalfImage:(NSString *)name;
/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *  eg:[UIImage compressImage:image toMaxLength:512*1024*8 maxWidth:1024];
 *  @return 压缩后图片的二进制
 */
+ (NSData *)ua_compressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)ua_resizeImage:(UIImage *)image newSize:(CGSize)newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)ua_scaleImage:(UIImage *)image length:(CGFloat)imageLength;


/**
 *  合成加半透明水印
 *
 *  @param maskImage 水印图
 *  @param rect      水印图位置
 *
 *  @return 图片
 */
- (UIImage *)ua_addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;
@end
