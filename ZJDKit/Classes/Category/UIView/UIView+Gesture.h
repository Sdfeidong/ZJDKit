//
//  UIView+Gesture.h
//  YYKSearch
//
//  Created by aidong on 16/12/13.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gesture)


/**
 添加点击手势

 @param block <#block description#>
 */
- (void)setTapActionWithBlock:(void (^)(void))block;


/**
 添加长按手势

 @param block <#block description#>
 */
- (void)setLongPressActionWithBlock:(void (^)(void))block;

@end
