//
//  ZJD_CountTime.h
//  YYKSearch
//
//  Created by yyk100 on 16/9/30.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const NNC_CountTimeNotification;


@interface ZJD_CountTime : NSObject

@property (nonatomic,assign) int timeCount;

/**
 *  单例
 *
 *  @return 实例
 */
+ (ZJD_CountTime *)shared;

/**
 *  开始计时
 */
- (void)startCount;
/**
 *  暂停计时
 */
- (void)pauseCount;
/**
 *  继续计时
 */
- (void)reuseCount;
/**
 *  结束计时
 */
- (void)endCount;

/**
 *  返回一个换算好的时间字符串用于显示
 *
 *  @param countNum 计时数
 *
 *  @return 00:15:09
 */
+ (NSString *)timerString:(int)countNum;

@end
