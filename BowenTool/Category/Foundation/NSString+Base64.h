//
//  NSString+Base64.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *)ua_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)ua_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)ua_base64EncodedString;
- (NSString *)ua_base64DecodedString;
- (NSData *)ua_base64DecodedData;

- (NSString *)ua_md5String;
@end
