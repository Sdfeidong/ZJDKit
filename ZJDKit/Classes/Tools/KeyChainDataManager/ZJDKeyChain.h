//
//  ZJDKeyChain.h
//  GKCC
//
//  Created by aidong on 2018/1/11.
//  Copyright © 2018年 aidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

@end
