//
//  NSString+Base64.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64Additions)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

@end
