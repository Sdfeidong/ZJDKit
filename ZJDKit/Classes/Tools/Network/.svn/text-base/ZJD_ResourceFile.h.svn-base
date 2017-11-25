//
//  ZJD_ResourceFile.h
//  ZJDKit
//
//  Created by yyk100 on 16/9/6.
//  Copyright © 2016年 aidong. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 *  资源类型
 */
typedef NS_ENUM(NSInteger, ZJD_ResourceType) {
    ZJD_ResourceTypeImage = 600,    // 图片
    ZJD_ResourceTypeAudio,          // 音频
    ZJD_ResourceTypeVideo,          // 视频
    ZJD_ResourceTypeDocument,       // 文档
    ZJD_ResourceTypeOther,          // 其它（zip等）
};

@interface ZJD_ResourceFile : NSObject

/**
 *  资源类型
 */
@property (nonatomic , assign) ZJD_ResourceType resourceType;

/**
 *  资源文件名称[fileName]
 */
@property (nonatomic , copy) NSString *fileName;

/**
 *  资源文件的[mimeType]
 */
@property (nonatomic , copy) NSString *mimeType;

/**
 *  对应服务器上[upload.php中]处理文件的[字段"file"]
 */
@property (nonatomic , copy) NSString *serverName;

/**
 *  资源文件数据流[二进制]
 */
@property (nonatomic , strong) NSData *fileData;

/**
 *  获取图片默认命名
 */
+ (NSString *)getImageDefaultName;

@end
