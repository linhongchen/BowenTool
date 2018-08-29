//
//  UIImage+GIF.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface UIImage (GIF)

+ (UIImage *)ua_animatedGIFNamed:(NSString *)name;

+ (UIImage *)ua_animatedGIFWithData:(NSData *)data;

- (UIImage *)ua_animatedImageByScalingAndCroppingToSize:(CGSize)size;
@end
