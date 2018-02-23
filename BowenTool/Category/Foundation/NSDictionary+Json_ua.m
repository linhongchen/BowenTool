//
//  NSDictionary+Json_ua.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSDictionary+Json_ua.h"

@implementation NSDictionary (Json_ua)

- (NSString *)jsonString:(NSString *)key
{
    if (!self)
    {
        return @"";
    }
    
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]])
    {
        return object;
    }
    else if([object isKindOfClass:[NSNumber class]])
    {
        return [object stringValue];
    }
    return @"";
}

- (NSDictionary *)jsonDict:(NSString *)key
{
    if (!self)
    {
        return @{};
    }
    
    id object = [self objectForKey:key];
    return [object isKindOfClass:[NSDictionary class]] ? object : @{};
}


- (NSArray *)jsonArray:(NSString *)key
{
    if (!self)
    {
        return @[];
    }
    
    id object = [self objectForKey:key];
    return [object isKindOfClass:[NSArray class]] ? object : @[];
    
}

- (NSArray *)jsonStringArray:(NSString *)key
{
    if (!self)
    {
        return @[];
    }
    
    NSArray *array = [self jsonArray:key];
    BOOL invalid = NO;
    for (id item in array)
    {
        if (![item isKindOfClass:[NSString class]])
        {
            invalid = YES;
        }
    }
    return invalid ? @[] : array;
}

- (BOOL)jsonBool:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object boolValue];
    }
    return NO;
}

- (NSInteger)jsonInteger:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object integerValue];
    }
    return 0;
}

- (long long)jsonLongLong:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object longLongValue];
    }
    return 0;
}

- (unsigned long long)jsonUnsignedLongLong:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object unsignedLongLongValue];
    }
    return 0;
}


- (double)jsonDouble:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object doubleValue];
    }
    return 0;
}

@end
