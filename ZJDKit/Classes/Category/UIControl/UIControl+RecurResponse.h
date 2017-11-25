//
//  UIControl+RecurResponse.h
//  TestButton
//
//  Created by yyk100 on 16/9/5.
//  Copyright © 2016年 aidong. All rights reserved.
//

/*
 *  主要解决重复响应的问题（如按钮的重复点击）
 */

#import <UIKit/UIKit.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const void *BandNameKey = &BandNameKey;

@interface UIControl (RecurResponse)
// 接受响应的间隔时间 默认0；
@property (nonatomic, assign) NSTimeInterval zjd_acceptEventInterval;
// 是否忽略间隔时间内的响应事件
@property (nonatomic, assign) BOOL zjd_ignoreEvent;

@end
