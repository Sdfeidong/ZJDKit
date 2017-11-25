//
//  ZJD_FileManageUnit.m
//  MYCode
//
//  Created by aidong on 14-9-2.
//  Copyright (c) 2014年 aidong. All rights reserved.
//

#import "ZJD_FileManageUnit.h"
#import "ZJD_Header.h"

// 已在PrefixHeader.pch 定义过
//#define NFM_DM [NSFileManager defaultManager]

@implementation ZJD_FileManageUnit

+(NSString *)userPath:(NSString *)folderPath{
    NSString *key = @"user_folder_path";
    if (folderPath == nil) {
        return [NUD_SUD objectForKey:key];
    }else{
        [NUD_SUD setObject:folderPath forKey:key];
        return folderPath;
    }
}
// 切换用户时，获取其它用户的文件夹 [用户ID 文件夹名 --> UserID-2]
+(NSString *) otherUserFolder:(NSString *)folderPath {
    
    NSString *document;
    document = [PATH_OF_DOCUMENT stringByAppendingPathComponent:[NSString stringWithFormat:@"User/%@",folderPath]];
    
    if (![NFM_DM fileExistsAtPath:folderPath] ) {
        NSError *error;
        if (![NFM_DM createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
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
        document = [PATH_OF_DOCUMENT stringByAppendingPathComponent:[NSString stringWithFormat:@"User/%@",[ZJD_FileManageUnit userPath:nil]]];
    }else{
        document = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"Data"];
    }
    
    if (![NFM_DM fileExistsAtPath:document] ) {
        NSError *error;
        if (![NFM_DM createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
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
        document = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"Data"];
    }
    
    if (![NFM_DM fileExistsAtPath:document] ) {
        NSError *error;
        if (![NFM_DM createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"error:%@",error);
        }
    }
    // NSLog(@"当前文件夹地址：%@",document);
    return document;
}

// 与上面略有区别，用时请注意。（主要用于对于其它非用户文件夹的操作）
+(NSString *) documentFolder{
    
    NSString *document;
    
    document = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"Data"];
    
    if (![NFM_DM fileExistsAtPath:document] ) {
        NSError *error;
        if (![NFM_DM createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"error:%@",error);
        }
    }
    
    //NSLog(@"document :%@",document);
    return document;
}

#pragma mark -
#pragma mark - 获取文件大小
// 单个文件的大小
+ (long long)fileSizeAtPath:(NSString *) filePath{
    if ([NFM_DM fileExistsAtPath:filePath]){
        return [[NFM_DM attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
// 遍历文件夹获得文件夹大小
+ (float)folderSizeAtPath:(NSString *) folderPath{
    
    if (![NFM_DM fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[NFM_DM subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0*1024.0);
}
+ (NSString *)fileSize:(long long)size {
    if (size > 1024 * 1024 * 1024) {
        return [NSString stringWithFormat:@"%.2fGB",size/(1024.0*1024.0*1024)];
    } else if (size > 1024 * 1024) {
        return [NSString stringWithFormat:@"%.2fMB",size/(1024.0*1024.0)];
    } else if (size > 1024)  {
        return [NSString stringWithFormat:@"%.2fKB",size/1024.00];
    } else  {
        return [NSString stringWithFormat:@"%lldB",size];
    }
}
+ (NSArray *)readFileListsWithFloderPath:(NSString *)floderPath{
    // 读取Docunment下所有文件
    NSArray *fileList = [NSArray array];
    NSError *error;
    fileList =[NFM_DM contentsOfDirectoryAtPath:floderPath error:&error];
    NSLog(@"路径 -- >%@\nfileList -- >%@", floderPath,fileList);
    return fileList;
}
@end


