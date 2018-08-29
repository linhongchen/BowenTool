//
//  NSObject+UA.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (UA)

/**
 *  根据各种情况判断NSObject是否为空 是空返回yes
 */
- (BOOL)ua_isEmpty;

#pragma mark - <<<<<< SVProgress >>>>>> -
extern void ShowHUD(void);
extern void ShowSuccessStatus(NSString *statues);
extern void ShowErrorStatus(NSString *statues);
extern void ShowMaskStatus(NSString *statues);
extern void ShowMessage(NSString *statues);
extern void ShowProgress(CGFloat progress);
extern void DismissHud(void);
extern void ShowError(NSError *error);

#pragma mark - <<<<<< 导航栏/状态栏 >>>>>> -
+ (CGFloat)tabbarHeight;
+ (CGFloat)navbarHeight;
+ (CGFloat)lineHeight;
+ (CGFloat)spaceHeight;


#pragma mark - <<<<<< TOOL >>>>>> -
//播放提示音
+ (void)vibrate;
//震动
+ (void)vishake;


#pragma mark - <<<<<< 指纹识别 >>>>>> -
+ (void)fingerprintIdentificationWithSuccess:(void(^)(void))successful fail:(void(^)(NSError *))fail;

@end
