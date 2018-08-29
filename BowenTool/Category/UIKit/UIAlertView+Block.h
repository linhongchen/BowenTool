//
//  UIAlertView+Block.h
//  UA EA
//
//  Created by Silk-Bowen-Pro on 2017/10/27.
//  Copyright © 2017年 Silk-Bowen-Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertBlock)(NSInteger);
@interface UIAlertView (Block)

- (void)ua_showAlertWithCompletionHandler: (AlertBlock)block;
- (void)ua_clearActionBlock;

@end
