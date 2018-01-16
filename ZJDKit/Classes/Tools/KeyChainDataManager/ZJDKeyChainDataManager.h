//
//  ZJDKeyChainDataManager.h
//  GKCC
//
//  Created by aidong on 2018/1/11.
//  Copyright © 2018年 aidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDKeyChainDataManager : NSObject

/**
 *   存储 UUID
 *
 *     */
+(void)saveUUID:(NSString *)UUID;

/**
 *  读取UUID (主要方法)
 *
 */
+(NSString *)readUUID;

/**
 *    删除数据
 */
+(void)deleteUUID;


@end
