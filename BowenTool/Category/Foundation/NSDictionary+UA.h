//
//  NSDictionary+UA.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (UA)

- (NSString *)uaSortString;

//- (NSString *)sign;

- (NSString *)uaJsonString;

- (NSArray *)uaSortKeys;


/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)ua_dictionaryByMergingWith:(NSDictionary *)dict;

#pragma mark - Manipulation
- (NSDictionary *)ua_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)ua_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;
@end
