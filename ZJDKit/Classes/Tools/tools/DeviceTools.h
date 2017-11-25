//
//  DeviceTools.h
//  GKCC
//
//  Created by aidong on 2017/7/20.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceTools : NSObject

/**
 获取电池状态
 */
+ (CGFloat)getBatteryQuantity;

/**
 获取磁盘总容量
 */
+ (long long)getTotalDiskSize;

/**
 获取可用磁盘容量
 */
+ (long long)getAvailableDiskSize;

/**
 容量字符串转换函数
 */
+ (NSString *)fileSizeToString:(unsigned long long)fileSize;


@end
