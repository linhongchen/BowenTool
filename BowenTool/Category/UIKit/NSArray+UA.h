//
//  NSArray+UA.h
//  UA EA
//
//  Created by 陈伟财 on 2018/1/23.
//  Copyright © 2018年 Silk-Bowen-Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (UA)

//元素YES升序、NO降序
- (NSArray<id> *)uasorteUsingAscending:(BOOL)ascending;

//KeyPath对应的元素 YES升序、NO降序
- (NSArray<id> *)uasorteUsingKeyPath:(NSString *)keyPath ascending:(BOOL)ascending;

@end
