//
//  ZJDKeyChainDataManager.m
//  GKCC
//
//  Created by aidong on 2018/1/11.
//  Copyright © 2018年 aidong. All rights reserved.
//

#import "ZJDKeyChainDataManager.h"
#import "ZJDKeyChain.h"

@implementation ZJDKeyChainDataManager

static NSString * const KEY_IN_KEYCHAIN_UUID = @"唯一识别的KEY_UUID";
static NSString * const KEY_UUID = @"唯一识别的key_uuid";

+(void)saveUUID:(NSString *)UUID{
    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:KEY_UUID];
    
    [ZJDKeyChain save:KEY_IN_KEYCHAIN_UUID data:usernamepasswordKVPairs];
}

+(NSString *)readUUID{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[ZJDKeyChain load:KEY_IN_KEYCHAIN_UUID];
    
    NSString *uuid = [usernamepasswordKVPair objectForKey:KEY_UUID];
    
    // 不存在过
    if (!uuid) {
        uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [ZJDKeyChainDataManager saveUUID:uuid];
    }
    
    return uuid;
}

+(void)deleteUUID{
    
    [ZJDKeyChain delete:KEY_IN_KEYCHAIN_UUID];
    
}

@end
