//
//  UIActionSheet+Block.h
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionSheetBlock)(NSInteger);
@interface UIActionSheet (Block)<UIActionSheetDelegate>

- (void)showInView: (UIView *)view completionHandler: (ActionSheetBlock)block;
- (void)clearActionBlock;

@end
