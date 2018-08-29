//
//  NSDictionary+UA.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSDictionary+UA.h"
#import "NSString+UA.h"

@implementation NSDictionary (UA)

- (NSString *)uaSortString
{
    NSArray *keyArray = [self allKeys];
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *key in sortArray)
    {
        [tempArray addObject:[NSString stringWithFormat:@"%@%@",key,[self objectForKey:key]]];
    }
    
    NSString *comments = [tempArray componentsJoinedByString:@""];
    return comments;
}


- (NSString *)uaJsonString
{
    //@"{\"appId\":\"app001\",\"appKey\":\"123456\"}"
    NSString *text = @"";
    if (!self)
    {
        text = @"{}";
    }
    else
    {
        NSArray *keys = [self allKeys];
        if (!keys || keys.count == 0)
        {
            text = @"{}";
        }
        else
        {
            text = [text stringByAppendingString:@"{"];
            for (NSString *key in keys)
            {
                text = [text stringByAppendingString:[NSString stringWithFormat:@"\"%@\"", key]];
                id value = [self objectForKey:key];
                text = [text stringByAppendingString:[NSString stringWithFormat:@":\"%@\",", value]];
            }
            text = [text substringToIndex:text.length - 1];
            text = [text stringByAppendingString:@"}"];
        }
    }
    
    return text;
}


- (NSArray *)uaSortKeys
{
    if (!self)
    {
        return @[];
    }
    
    NSArray *oldKeys = [self allKeys];
    NSArray *newKeys = [oldKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2){
        return [obj1 compare:obj2]; //升序
    }];
    return newKeys;
}




/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)ua_dictionaryByMergingWith:(NSDictionary *)dict
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:self];
    NSMutableDictionary *resultTemp = [NSMutableDictionary dictionaryWithDictionary:dict];
    [resultTemp addEntriesFromDictionary:dict];
    [resultTemp enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop)
    {
        if ([self objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * newVal = [[self objectForKey: key] ua_dictionaryByMergingWith:(NSDictionary *)obj];
                [result setObject: newVal forKey: key];
            }
            else
            {
                [result setObject: obj forKey: key];
            }
        }
        else if([dict objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * newVal = [[dict objectForKey: key] ua_dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            }
            else
            {
                [result setObject: obj forKey: key];
            }
        }
    }];
    return (NSDictionary *)[result mutableCopy];
}

#pragma mark - Manipulation
- (NSDictionary *)ua_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *result = [self mutableCopy];
    [result addEntriesFromDictionary:dictionary];
    return result;
}

- (NSDictionary *)ua_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys
{
    NSMutableDictionary *result = [self mutableCopy];
    [result removeObjectsForKeys:keys.allObjects];
    return result;
}

@end
