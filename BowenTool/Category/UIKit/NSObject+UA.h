//
//  NSObject+UA.h
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (UA)

#pragma mark - <<<<<< SVProgress >>>>>> -
//extern void ShowHUD(void);
//extern void ShowSuccessStatus(NSString *statues);
//extern void ShowErrorStatus(NSString *statues);
//extern void ShowMaskStatus(NSString *statues);
//extern void ShowMessage(NSString *statues);
//extern void ShowProgress(CGFloat progress);
//extern void DismissHud(void);
//extern void ShowError(NSError *error);

#pragma mark - <<<<<< 导航栏/状态栏 >>>>>> -
+ (CGFloat)tabbarHeight;
+ (CGFloat)navbarHeight;
+ (CGFloat)lineHeight;
+ (CGFloat)spaceHeight;


//获取网络状态-BOOL-是否有网络
//+ (BOOL)isNetworkStatus;

////播放提示音
//+ (void)vibrate;
////震动
//+ (void)vishake;
@end
