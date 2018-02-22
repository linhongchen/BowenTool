//
//  NSArray+UA.m
//  UA EA
//
//  Created by 陈伟财 on 2018/1/23.
//  Copyright © 2018年 Silk-Bowen-Pro. All rights reserved.
//

#import "NSArray+UA.h"

@implementation NSArray (UA)

- (NSArray<id> *)uasorteUsingAscending:(BOOL)ascending
{
    if (!self || self.count == 0)
    {
        return @[];
    }
    
    NSArray *newArr = [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (ascending == YES)
        {
            return [obj1 compare:obj2]; //升序
        }
        else
        {
            return [obj2 compare:obj1]; //升序
        }
    }];
    
    return newArr;
}

- (NSArray<id> *)uasorteUsingKeyPath:(NSString *)keyPath ascending:(BOOL)ascending
{
    if (!self || self.count == 0)
    {
        return @[];
    }
    NSArray *newArr = [self sortedArrayUsingComparator:^NSComparisonResult(id objDic1, id objDic2){
        
        id obj1 = [objDic1 valueForKeyPath:keyPath]?:@"0";
        id obj2 = [objDic2 valueForKeyPath:keyPath]?:@"0";
        
        if (ascending == YES)
        {
            return [obj1 compare:obj2]; //升序
        }
        else
        {
            return [obj2 compare:obj1]; //升序
        }
//        if ([obj1 integerValue] > [obj2 integerValue])
//        {
//            if (ascending == YES)
//            {
//                //54321
//                return (NSComparisonResult)NSOrderedDescending;
//            }
//            else
//            {
//                //12345
//                return (NSComparisonResult)NSOrderedAscending;
//            }
//        }
//        if ([obj1 integerValue] < [obj2 integerValue])
//        {
//            if (ascending == YES)
//            {
//                return (NSComparisonResult)NSOrderedAscending;
//            }
//            else
//            {
//                return (NSComparisonResult)NSOrderedDescending;
//            }
//        }
//
//        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return newArr;
}

@end
