//
//  ZJD_FileManageUnit.h
//  MYCode
//
//  Created by aidong on 14-9-2.
//  Copyright (c) 2014年 aidong. All rights reserved.
//

/**
 *  沙盒说明
 *
 *  默认情况下，每个沙盒含有3个文件夹：Documents, Library 和 tmp。
 因为应用的沙盒机制，应用只能在几个目录下读写文件：
 Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 Library：存储程序的默认设置或其它状态信息；
 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 tmp：提供一个即时创建临时文件的地方。
 iTunes在与iPhone同步时，备份所有的Documents和Library文件。
 iPhone在重启时，会丢弃所有的tmp文件。
 */

/**
 *  登陆成功时就要同时获取或创建用户文件目录
 *  以后基本操作都基于该文件路径下
 *
 *  [ZJD_FileManageUnit userPath:[FDUserObject shared].userID];
 *  [ZJD_FileManageUnit userFolder];
 *
 */

#import <Foundation/Foundation.h>

@interface ZJD_FileManageUnit : NSObject

/**
 用户路径
 */
+ (NSString *)userPath:(NSString *)folderPath;
/**
 切换用户时，获取其它用户的根文件夹 [用户ID 文件夹名 --> UserID-2]
 */
+(NSString *) otherUserFolder:(NSString *)folderPath;
/**
 当前用户根文件夹
 */
+ (NSString *)userFolder;
/**
 当前用户根文件夹下的文件夹
 */
+ (NSString *)userFolder:(NSString *)folderPath;
/**
 获取非用户文件存储路径
 */
+ (NSString *)documentFolder;
/**
 获取单个文件的大小
 */
+ (long long)fileSizeAtPath:(NSString *) filePath;
/**
 获取某个文件夹的大小 (包括其内部所有的文件夹和文件)
 */
+ (float )folderSizeAtPath:(NSString *) folderPath;
/**
 将文件的大小（B）转化为（多少G/M/B）
 */
+ (NSString *)fileSize:(long long)size;
/**
 获取某个路径下文件列表
 */
+ (NSArray *)readFileListsWithFloderPath:(NSString *)floderPath;

@end


