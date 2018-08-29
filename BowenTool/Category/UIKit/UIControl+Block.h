//
//  UIControl+Block.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/28.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Block)

- (void)ua_touchDown:(void (^)(void))eventBlock;
- (void)ua_touchDownRepeat:(void (^)(void))eventBlock;
- (void)ua_touchDragInside:(void (^)(void))eventBlock;
- (void)ua_touchDragOutside:(void (^)(void))eventBlock;
- (void)ua_touchDragEnter:(void (^)(void))eventBlock;
- (void)ua_touchDragExit:(void (^)(void))eventBlock;
- (void)ua_touchUpInside:(void (^)(void))eventBlock;
- (void)ua_touchUpOutside:(void (^)(void))eventBlock;
- (void)ua_touchCancel:(void (^)(void))eventBlock;
- (void)ua_valueChanged:(void (^)(void))eventBlock;
- (void)ua_editingDidBegin:(void (^)(void))eventBlock;
- (void)ua_editingChanged:(void (^)(void))eventBlock;
- (void)ua_editingDidEnd:(void (^)(void))eventBlock;
- (void)ua_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
