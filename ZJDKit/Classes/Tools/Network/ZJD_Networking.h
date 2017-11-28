//
//  ZJD_Networking.h
//  ZJDKit
//
//  Created by yyk100 on 16/9/6.
//  Copyright © 2016年 aidong. All rights reserved.
//


/**
 *  AFNetworking 3.1.0
 */

#import <Foundation/Foundation.h>

#import "ZJD_ResourceFile.h"

/**
 *  请求最大响应时间
 */
#define RequestTimeOutInterval              10.f

/**
 *  网络请求隐藏字段
 */
#define NUD_httpSecretKey       @"httpSecretKey"

/**
 *  网络状况
 */
typedef NS_ENUM (NSInteger , ZJD_NetworkStatus) {
    
    ZJD_NetworkStatusUnknown          = -1,    //未知网络
    ZJD_NetworkStatusNotReachable     = 0,     //没有网络
    ZJD_NetworkStatusReachableViaWWAN = 1,     //手机自带网络（流量）
    ZJD_NetworkStatusReachableViaWiFi = 2      //wifi
};


/**
 *  HTTP REQUEST METHOD TYPE
 */
typedef NS_ENUM(NSInteger, ZJD_RequestType) {
    ZJD_RequestTypeGet          = 1,
    ZJD_RequestTypePost         = 2,
    ZJD_RequestTypeDelete       = 3,
    ZJD_RequestTypePut          = 4,
    ZJD_RequestTypeHead         = 5,
    ZJD_RequestTypePatch        = 6
};

/**
 *  请求开始前预处理Block
 */
typedef void (^ZJD_HanderPrepareExecute)(void);

/**
 *  Handler处理过程中调用的Block (已完成/全部)
 */
typedef void (^ZJD_HandlerProgress)(int64_t bytesProgress, int64_t totalBytesProgress);

/**
 *  Handler处理成功时调用的Block isComplete：YES表示已向服务器请求到想要的数据或结果
 *  仅部分约定好的接口 需要status的值
 */
typedef void (^ZJD_HandlerSuccess)(NSString *status, id response,BOOL isComplete);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^ZJD_HandlerFail)(NSError *error);
/**
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */

@interface ZJD_Networking : NSObject
    
/**
 *  单例
 *
 *  @return ZJD_Networking
 */
+ (ZJD_Networking *)sharedZJD_Networking;
    
/**
 *  获取网络
 */
@property (nonatomic,assign)ZJD_NetworkStatus networkStats;

/**
 *  开启网络监测
 */
+ (void)startMonitoring;
    
/**
*  判断当前网络状态是否可用
*/
+ (BOOL)isConnectionAvailable;

/**
*  @param requestType  请求方法(GET、POST、PUT、DELETE、HEAD、PATCH)
*
*  @param url     请求连接，根路径
*  @param passDict  参数
*  @param success 请求成功返回数据
*  @param fail    请求失败
*  @param showHUD 是否显示HUD
*  @param cacheTime 缓存时间，以秒为单位 -1 为永久缓存  0 为不缓存
*/
+ (NSURLSessionTask *)baseWithUrl:(NSString *)url
                           params:(NSDictionary *)passDict
                        cacheTime:(NSInteger)cacheTime
                      requestType:(ZJD_RequestType)requestType
                          success:(ZJD_HandlerSuccess)success
                             fail:(ZJD_HandlerFail)fail
                          showHUD:(BOOL)showHUD
                       faileAlert:(BOOL)faileAlert;

/**
 *  上传图片方法
 *
 *  @param image      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param passDict     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
+ (NSURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)passDict
                             progress:(ZJD_HandlerProgress)progress
                              success:(ZJD_HandlerSuccess)success
                                 fail:(ZJD_HandlerFail)fail
                              showHUD:(BOOL)showHUD
                           faileAlert:(BOOL)faileAlert;

/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(ZJD_HandlerProgress )progressBlock
                              success:(ZJD_HandlerSuccess )success
                              failure:(ZJD_HandlerFail )fail
                              showHUD:(BOOL)showHUD;


/**
 *  将服务器获取的数据 转成 OC 的NSDictionary、NSArray、NSString、nil(未识别)
 */
+ (id )resultsWithResponseObject:(id)json;

/**
 * 判断 urlStr 是不是图片的 urlStr。曾遇见过图片地址放了MP4的URL,不停加载导致内存溢出
 */
+ (NSString *)validImageUrlStr:(NSString *)imageUrlStr;

#pragma mark - 获取公共参数
/**
 添加公共参数
 */
+ (NSMutableDictionary *)getDefaultParamsWithDict:(NSDictionary *)passDict;

@end

