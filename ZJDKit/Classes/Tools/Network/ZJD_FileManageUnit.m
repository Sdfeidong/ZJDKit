//
//  ZJD_FileManageUnit.m
//  MYCode
//
//  Created by aidong on 14-9-2.
//  Copyright (c) 2014年 aidong. All rights reserved.
//

#import "ZJD_FileManageUnit.h"
#import "ZJDKit.h"

// 已在PrefixHeader.pch 定义过
//#define NFM_DM [NSFileManager defaultManager]

@implementation ZJD_FileManageUnit

+(NSString *)userPath:(NSString *)folderPath{
    NSString *key = @"user_folder_path";
    if (folderPath == nil) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:folderPath forKey:key];
        return folderPath;
    }
}
// 切换用户时，获取其它用户的文件夹 [用户ID 文件夹名 --> UserID-2]
+(NSString *) otherUserFolder:(NSString *)folderPath {
    
    NSString *document;
    document = [[ZJD_FileManager documentsDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"User/%@",folderPath]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath] ) {
        NSError *error;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
            // 创建新文件夹
            NSLog(@"error:%@",error);
        }
    }
    // NSLog(@"当用户 %@ \n文件夹地址：%@",userAccount,document);
    return document;
}

// 获取存当前登陆用户文件夹
+(NSString *) userFolder{
    
    NSString *document;
    if ([ZJD_FileManageUnit userPath:nil]!=nil) {
        document = [[ZJD_FileManager documentsDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"User/%@",[ZJD_FileManageUnit userPath:nil]]];
    }else{
        document = [[ZJD_FileManager documentsDir] stringByAppendingPathComponent:@"Data"];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:document] ) {
        NSError *error;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
            // 创建新文件夹
            NSLog(@"error:%@",error);
        }
    }
    // NSLog(@"当前文件夹地址：%@",document);
    return document;
}

// 获取或创建当前登陆用户文件夹下某个文件夹
+(NSString *) userFolder:(NSString *)folderPath{
    
    NSString *document;
    if ([ZJD_FileManageUnit userPath:nil]!=nil) {
        document = [NSString stringWithFormat:@"%@/%@",[ZJD_FileManageUnit userFolder],folderPath];
    }else{
        document = [[ZJD_FileManager documentsDir] stringByAppendingPathComponent:@"Data"];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:document] ) {
        NSError *error;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"error:%@",error);
        }
    }
    // NSLog(@"当前文件夹地址：%@",document);
    return document;
}

// 与上面略有区别，用时请注意。（主要用于对于其它非用户文件夹的操作）
+(NSString *) documentFolder{
    
    NSString *document;
    document = [[ZJD_FileManager documentsDir] stringByAppendingPathComponent:@"Data"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:document] ) {
        NSError *error;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"error:%@",error);
        }
    }
    
    //NSLog(@"document :%@",document);
    return document;
}

@end


