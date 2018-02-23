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

- (NSString *)UASortString
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


- (NSArray *)UASortKeys
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

@end
