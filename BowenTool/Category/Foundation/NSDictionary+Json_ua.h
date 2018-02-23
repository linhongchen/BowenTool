//
//  NSDictionary+Json_ua.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json_ua)

- (NSString *)jsonString:(NSString *)key;

- (NSDictionary *)jsonDict:(NSString *)key;
- (NSArray *)jsonArray:(NSString *)key;
- (NSArray *)jsonStringArray:(NSString *)key;


- (BOOL)jsonBool:(NSString *)key;
- (NSInteger)jsonInteger:(NSString *)key;
- (long long)jsonLongLong:(NSString *)key;
- (unsigned long long)jsonUnsignedLongLong:(NSString *)key;

- (double)jsonDouble:(NSString *)key;

@end
