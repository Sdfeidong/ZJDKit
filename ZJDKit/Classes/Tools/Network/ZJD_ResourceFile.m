//
//  ZJD_ResourceFile.m
//  ZJDKit
//
//  Created by yyk100 on 16/9/6.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "ZJD_ResourceFile.h"
#import "ZJD_Header.h"

@implementation ZJD_ResourceFile

/**
 *  获取图片默认命名
 */
+ (NSString *)getImageDefaultName {
    
    NSString *imageName = [NSDate get_yyyyMMddHHmmss_DateFromTimestamp:[NSDate getCurrentDateTimestamp]];
    imageName = [imageName stringByAppendingString:@".jpg"];
    return imageName;
}

@end
