//
//  DeviceTools.m
//  GKCC
//
//  Created by aidong on 2017/7/20.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "DeviceTools.h"
#import <sys/mount.h>

@implementation DeviceTools

/**
 获取电池状态
 */
+ (CGFloat)getBatteryQuantity {
    return [[UIDevice currentDevice] batteryLevel];
}
/**
 获取磁盘总容量
 */
+ (long long)getTotalDiskSize {
    
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

/**
 获取可用磁盘容量
 */
+ (long long)getAvailableDiskSize {
    
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

/**
 容量字符串转换函数
 */
+ (NSString *)fileSizeToString:(unsigned long long)fileSize {
    
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10) {
        return @"0B";
        
    } else if (fileSize < KB) {
        return @"< 1KB";
        
    } else if (fileSize < MB) {
        return [NSString stringWithFormat:@"%.1fKB",((CGFloat)fileSize)/KB];
        
    } else if (fileSize < GB) {
        return [NSString stringWithFormat:@"%.1fMB",((CGFloat)fileSize)/MB];
        
    } else {
        return [NSString stringWithFormat:@"%.1fGB",((CGFloat)fileSize)/GB];
    }
}

@end
