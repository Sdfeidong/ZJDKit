//
//  ZJD_Networking.m
//  DKT4.0
//
//  Created by aidong on 16/5/23.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "ZJD_Networking.h"

#import "Reachability.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "ZJD_Header.h"
#import "YYKit.h"
#import "MJExtension.h"

static NSMutableArray *tasks;
@implementation ZJD_Networking

+ (ZJD_Networking *)sharedZJD_Networking
{
    static ZJD_Networking *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[ZJD_Networking alloc] init];
    });
    return handler;
}

+ (NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

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
                   faileAlert:(BOOL)faileAlert{

    // URL参数处理
    if (url == nil) {
        return nil;
    }
    // utf-8
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 去两端空格
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    // 若有缓存先返回缓存数据出页面
    NSString *cacheDirectory = [ZJD_FileManageUnit userFolder];
    YYCache *cache = [YYCache cacheWithPath:cacheDirectory];
    if (cacheTime && cacheTime != 0) {
        if (success) {
            id responseObject = [cache objectForKey:url];
            NSDictionary *dic = [self resultsWithResponseObject:responseObject];
            success(dic[@"status"],dic,YES);
        }
    }

    // 判断网络
    if (![self isConnectionAvailable]) {
        // 无网络链接
        [MBProgressHUD showTipMessageInWindow:Msg_NetworkError];
        if (fail) {
            NSError *error = [NSError mj_error];
            fail(error);
        }
        return nil;
    }
    NSLog(@"\n 请求地址----%@\n 请求参数----%@",url,passDict);

    // 处理参数
    NSMutableDictionary *params = [ZJD_Networking requestPostFormData:passDict];
    NSLog(@"\n 请求地址----%@\n 请求参数----%@",url,params);

    AFHTTPSessionManager *manager=[self getAFManager];
    NSURLSessionTask *sessionTask=nil;

    if (requestType == ZJD_RequestTypeGet) {
        
        sessionTask = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccessWithUrl:url responseObject:responseObject cacheTime:cacheTime sessionTask:sessionTask success:success showHUD:showHUD faileAlert:faileAlert];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self requestFailWithUrl:url error:error sessionTask:sessionTask fail:fail showHUD:showHUD faileAlert:faileAlert];
        }];
        
    } else if (requestType == ZJD_RequestTypePost){
        
        sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccessWithUrl:url responseObject:responseObject cacheTime:cacheTime sessionTask:sessionTask success:success showHUD:showHUD faileAlert:faileAlert];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self requestFailWithUrl:url error:error sessionTask:sessionTask fail:fail showHUD:showHUD faileAlert:faileAlert];
        }];
        
    } else if (requestType == ZJD_RequestTypePut){
        
        sessionTask = [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self requestSuccessWithUrl:url responseObject:responseObject cacheTime:cacheTime sessionTask:sessionTask success:success showHUD:showHUD faileAlert:faileAlert];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self requestFailWithUrl:url error:error sessionTask:sessionTask fail:fail showHUD:showHUD faileAlert:faileAlert];
        }];
        
    } else if (requestType == ZJD_RequestTypeDelete){
        
        sessionTask = [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self requestSuccessWithUrl:url responseObject:responseObject cacheTime:cacheTime sessionTask:sessionTask success:success showHUD:showHUD faileAlert:faileAlert];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self requestFailWithUrl:url error:error sessionTask:sessionTask fail:fail showHUD:showHUD faileAlert:faileAlert];
        }];
        
    } else if (requestType == ZJD_RequestTypeHead){
        
        sessionTask = [manager HEAD:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task) {
            
            [self requestSuccessWithUrl:url responseObject:nil cacheTime:cacheTime sessionTask:sessionTask success:success showHUD:showHUD faileAlert:faileAlert];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self requestFailWithUrl:url error:error sessionTask:sessionTask fail:fail showHUD:showHUD faileAlert:faileAlert];
        }];
        
    } else if (requestType == ZJD_RequestTypePatch){
        
        sessionTask = [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self requestSuccessWithUrl:url responseObject:responseObject cacheTime:cacheTime sessionTask:sessionTask success:success showHUD:showHUD faileAlert:faileAlert];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self requestFailWithUrl:url error:error sessionTask:sessionTask fail:fail showHUD:showHUD faileAlert:faileAlert];
        }];
    }

    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }

    dispatch_async(dispatch_get_main_queue(),^{
        // 任务存在且显示HUD 主线程更新UI
        if (sessionTask && showHUD) {
            [self loadingMBProgressHUDisTapCancel:YES task:sessionTask];
        }
    });

    return sessionTask;
}

+ (NSURLSessionTask *)uploadWithImage:(UIImage *)image
                              url:(NSString *)url
                         filename:(NSString *)filename
                             name:(NSString *)name
                           params:(NSDictionary *)passDict
                         progress:(ZJD_HandlerProgress)progress
                          success:(ZJD_HandlerSuccess)success
                             fail:(ZJD_HandlerFail)fail
                          showHUD:(BOOL)showHUD
                       faileAlert:(BOOL)faileAlert{

    // URL参数处理
    if (url == nil) {
        return nil;
    }
    // utf-8
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 去两端空格
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    // 判断网络
    if (![self isConnectionAvailable]) {
        // 无网络链接
        [MBProgressHUD showTipMessageInWindow:Msg_NetworkError];
        if (fail) {
            NSError *error = [NSError mj_error];
            fail(error);
        }
        return nil;
    }

    // 处理参数
    NSMutableDictionary *params = [ZJD_Networking requestPostFormData:passDict];
    NSLog(@"\n 请求地址----%@\n 请求参数----%@",url,params);

    AFHTTPSessionManager *manager=[self getAFManager];
    NSURLSessionTask *sessionTask=nil;

    sessionTask = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (image) {
            //压缩图片
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            
            NSString *imageFileName = filename;
            if (!kStringIsNotEmpty(imageFileName)) {
                imageFileName = [ZJD_ResourceFile getImageDefaultName];
            }
            
            // 上传图片，以文件流的格式
            [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestSuccessWithUrl:url responseObject:responseObject cacheTime:0 sessionTask:sessionTask success:success showHUD:showHUD faileAlert:faileAlert];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestFailWithUrl:url error:error sessionTask:sessionTask fail:fail showHUD:showHUD faileAlert:faileAlert];
    }];

    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }

    dispatch_async(dispatch_get_main_queue(),^{
        // 任务存在且显示HUD 主线程更新UI
        if (sessionTask && showHUD) {
            [self loadingMBProgressHUDisTapCancel:YES task:sessionTask];
        }
    });

    return sessionTask;
}

+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url
                       saveToPath:(NSString *)saveToPath
                         progress:(ZJD_HandlerProgress)progressBlock
                          success:(ZJD_HandlerSuccess)success
                          failure:(ZJD_HandlerFail)fail
                          showHUD:(BOOL)showHUD{

    NSLog(@"请求地址----%@\n    ",url);
    if (url==nil) {
        return nil;
    }

    if (showHUD==YES) {
        [MBProgressHUD loadingMBProgressHUD];
    }

    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [self getAFManager];

    NSURLSessionTask *sessionTask = nil;

    sessionTask = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载文件成功");
        
        [[self tasks] removeObject:sessionTask];
        
        if (error == nil) {
            if (success) {
                success(@"200",[filePath path],YES);//返回完整路径
            }
            
        } else {
            if (fail) {
                fail(error);
            }
        }
        
        [MBProgressHUD hideHUD];
    }];

    //开始启动任务
    [sessionTask resume];
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }

    return sessionTask;
}

+ (AFHTTPSessionManager *)getAFManager{

    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    // manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置返回数据为NSData
    // manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json

    manager.requestSerializer.stringEncoding  = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = RequestTimeOutInterval;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];

    return manager;
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring {
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            NSLog(@"未知网络");
            [ZJD_Networking sharedZJD_Networking].networkStats = ZJD_NetworkStatusUnknown;
            break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            NSLog(@"没有网络");
            [ZJD_Networking sharedZJD_Networking].networkStats = ZJD_NetworkStatusNotReachable;
            break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            NSLog(@"手机自带网络");
            [ZJD_Networking sharedZJD_Networking].networkStats = ZJD_NetworkStatusReachableViaWWAN;
            break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
            NSLog(@"WIFI");
            [ZJD_Networking sharedZJD_Networking].networkStats=ZJD_NetworkStatusReachableViaWiFi;
            break;
        }
    }];
    
    // 注意不是调用自身
    [mgr startMonitoring];
}

+ (BOOL)isConnectionAvailable{

    BOOL status ;

    Reachability *reach = [Reachability reachabilityForInternetConnection];

    NetworkStatus status22 = [reach currentReachabilityStatus];

    // 判断网络状态
    if (status22 == ReachableViaWiFi) {
        status = YES;
        //无线网
    } else if (status22 == ReachableViaWWAN) {
        status = YES;
        //移动网
    } else {
        status = NO;
    }
    return status;

    // 这个单例有问题 判断网络状态不准确
    // NSLog(@"网络状态 ：%ld",(long)[[ZJD_Networking sharedZJD_Networking] networkStats]);
    // return [[ZJD_Networking sharedZJD_Networking] networkStats] != ZJD_NetworkStatusNotReachable;
}

#pragma mark - Self
+ (NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
/**
 *  将服务器获取的数据 转成 OC 的NSDictionary、NSArray、NSString、nil(未识别)
 */
+ (id )resultsWithResponseObject:(id)json {

    if (!json || json == (id)kCFNull) {
        NSLog(@"原数据为nil，返回nil");
        return nil;
    }

    NSData *jsonData = nil;
    id jsonResults = nil;

    if ([json isKindOfClass:[NSDictionary class]]) {
        NSLog(@"返回原字典");
    } else if ([json isKindOfClass:[NSArray class]]) {
        NSLog(@"返回原数组");
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }

    if (jsonData) {
        
        jsonResults = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        
        if ([jsonResults isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON数据返回字典");
        } else if ([jsonResults isKindOfClass:[NSArray class]]) {
            NSLog(@"JSON数据返回数组");
        } else if ([jsonResults isKindOfClass:[NSString class]]) {
            NSLog(@"JSON数据返回字符串");
            
        } else if (jsonResults == nil && [json isKindOfClass:[NSString class]]) {
            NSLog(@"返回原字符串");
            return json;
        } else if (jsonResults == nil && [json isKindOfClass:[NSData class]]) {
            // 不是数组，不是字典，还不是字符串吗？
            NSString *string = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            return string;
        } else {
            // 未识别
            NSLog(@"未识别防止解析报错，原数据返回nil");
            NSLog(@"未识别原数据：%@",json);
            return nil;
        }
        
        return jsonResults;
    }

    return json;
}

/**
 * 判断 urlStr 是不是图片的 urlStr
 */
+ (NSString *)validImageUrlStr:(NSString *)imageUrlStr {

    NSArray *array = @[@"gif",@"GIF",@"jpg",@"JPG",@"jpeg",@"JPEG",@"png",@"PNG"];
    for (NSString *str in array) {
        if ([imageUrlStr containsString:str]) {
            return imageUrlStr;
        }
    }
    return nil;
}

#pragma mark - MBProgressHUD
/**
 * 加载 @“点击取消” MBProgressHUD;
 */
+ (void)loadingMBProgressHUDisTapCancel:(BOOL)isTapCancel
                               task:(NSURLSessionTask *)task {

    MBProgressHUD *hud = [MBProgressHUD createMBProgressHUDviewWithMessage:@"点击取消" isWindiw:YES];

    if (isTapCancel) {
        [hud setTapActionWithBlock:^{
            [task cancel];
            [[self tasks] removeObject:task];
        }];
    }
}

#pragma mark - 网络错误处理
+ (void)dealWithError:(NSError *)error {

    // 点击取消请求的不提示网络错误
    if (error.code != -999) {
        if (error.code == -1001) {
            // 请求超时
            [MBProgressHUD showTipMessageInWindow:Msg_NetworkTimeOut];
        } else {
            // 其它网络错误
            [MBProgressHUD showTipMessageInWindow:Msg_NetworkAnomalies];
        }
    }
}

#pragma mark - Base Request Success And Fail
// 请求成功
+ (void)requestSuccessWithUrl:(NSString *)url
               responseObject:(id)responseObject
                    cacheTime:(NSInteger)cacheTime
                  sessionTask:(NSURLSessionTask *)sessionTask
                      success:(ZJD_HandlerSuccess)success
                      showHUD:(BOOL)showHUD
                   faileAlert:(BOOL)faileAlert{

    if (showHUD) {
        [MBProgressHUD hideHUD];
    }

    // 缓存
    NSString *cacheDirectory = [ZJD_FileManageUnit userFolder];
    YYCache *cache = [YYCache cacheWithPath:cacheDirectory];
    if (cacheTime && cacheTime != 0) {
        // 缓存有效的数据
        [cache setObject:responseObject forKey:url];
    }

    /**
     // 应该是缓存下面这样的有效的数据，但目前有些接口没有status键值
     if ([ToolClass isNotEmptyDict:responseObject]) {
     if (responseObject[@"status"]&&[responseObject[@"status"] integerValue] == 1000) {
     if (cacheTime && cacheTime != 0) {
     // 缓存有效的数据
     [egoCache setData:responseObject forKey:url withTimeoutInterval:cacheTime];
     }
     }
     }
     */

    // 处理json 数据
    responseObject = [self resultsWithResponseObject:responseObject];
    NSLog(@"%@",url);
    NSLog(@"%@",responseObject);

    BOOL isStandardData = NO;
    if ([ToolClass isNotEmptyDict:responseObject]) {
        NSDictionary *dictResponse = responseObject;
        // key --> @"status" @"message" @"data"
        if ([dictResponse containsObjectForKey:@"status"] && [dictResponse containsObjectForKey:@"message"] && [dictResponse containsObjectForKey:@"data"]) {
            
            isStandardData = YES;
            // 解析标准数据
            [self parseStandardData:dictResponse responseSuccess:success faileAlert:faileAlert];
        }
    }

    if (!isStandardData) {
        // 非服务器标准格式数据
        if (success) {
            success(@"300",responseObject,NO);
        }
    }

    [[self tasks] removeObject:sessionTask];
}
// 请求失败
+ (void)requestFailWithUrl:(NSString *)url
                 error:(NSError *)error
           sessionTask:(NSURLSessionTask *)sessionTask
                  fail:(ZJD_HandlerFail)fail
               showHUD:(BOOL)showHUD
            faileAlert:(BOOL)faileAlert {

    NSLog(@"error = %@",error);
    if (fail) {
        fail(error);
    }

    if (showHUD) {
        [MBProgressHUD hideHUD];
    }

    // 网络错误的提示
    if (faileAlert) {
        [self dealWithError:error];
    }

    [[self tasks] removeObject:sessionTask];
}
/**
 解析服务器标准格式数据
 
 @param dictResponse @“date”字段里数据
 @param responseSuccess 需要实际解析的数据
 */
+ (void)parseStandardData:(NSDictionary *)dictResponse
          responseSuccess:(ZJD_HandlerSuccess)responseSuccess
               faileAlert:(BOOL)faileAlert {

    NSString *status = [NSString stringWithFormat:@"%@",dictResponse[@"status"]];
    NSString *message = dictResponse[@"message"];
    id data = dictResponse[@"data"];

    // 是否需要返回数据 ，YES -- > null 也返回
    BOOL isReturnData = NO;

    if ([status integerValue] == 200) {
        // 成功只返回解析的数据 不 显示message
        isReturnData = YES;
        
    } else if ([status integerValue] == 201) {
        // 成功返回解析的数据 且 显示message
        if (kStringIsNotEmpty(message)) {
            [MBProgressHUD showSuccessMessage:message];
        }
        isReturnData = YES;
        
    }
    else {
        // 显示message
        if ([status integerValue] >= 200 && [status integerValue] < 300) {
            // 2xx
            if (kStringIsNotEmpty(message)) {
                [MBProgressHUD showSuccessMessage:message];
            }
        } else {
            // 非2xx
            if (faileAlert) {
                if (kStringIsNotEmpty(message)) {
                    [MBProgressHUD showErrorMessage:message];
                }
            }
        }
        
        // 返回数据肯定"status"是 2xx
        // @“data” 为空 就不需要返回数据了
        if (data != nil && data != [NSNull null]) {
            isReturnData = YES;
        }
        
        if ([status integerValue] >= 300) {
            // 大于300 都是异常
            isReturnData = NO;
        }
    }

    // 注意了啊
    if (responseSuccess) {
        // 回调返回真正需要解析的数据
        if (isReturnData) {
            // YES 都表示数据请求或操作成功
            // 但有可能data 是nil 或 (null) 或 <null>
            responseSuccess(status,data,YES);
        } else {
            responseSuccess(status,nil,NO);
        }
    }
}

/**
 参数安全加密处理
 
 @param passDict 原来的参数
 @return 处理后的参数
 */
+ (NSMutableDictionary *)requestPostFormData:(NSDictionary *)passDict {
    // 处理参数
    NSMutableDictionary *mDic = ([ToolClass isNotEmptyDict:passDict]) ? [passDict mutableCopy] : [NSMutableDictionary new];

    // 增加时间戳
    [mDic setObject:[NSDate getCurrentDateTimestamp] forKey:@"ts"];
    // 获取sign_code校验值
    NSString *sign_code = [ZJD_Networking getSign_code:mDic];
    // 增加校验参数
    [mDic setObject:[sign_code md5String] forKey:@"sign_code"];

    // 传参之前将所有参数再urlencode编码一遍
    for (NSString *key in mDic.allKeys) {
        NSString *value = [mDic[key] stringByURLEncode];
        [mDic setObject:value forKey:key];
    }
    return mDic;
}

/**
 获取参数校验值得方法
 
 @param passDict 参与校验的参数
 @return 返回校验值
 */
+ (NSString *)getSign_code:(NSDictionary *)passDict{

    NSMutableDictionary *mDic = ([ToolClass isNotEmptyDict:passDict]) ? [passDict mutableCopy] : [NSMutableDictionary new];

    // 网络请求隐藏的加密字段
    if ([NUD_SUD objectForKey:NUD_httpSecretKey]) {
        [mDic setObject:[NUD_SUD objectForKey:NUD_httpSecretKey] forKey:@"skey"];
    }

    NSArray *myKeys = [mDic allKeys];
    // 排序
    NSArray *sortedKeys = [myKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableArray *sortedValues = [[NSMutableArray alloc] init];

    for(id key in sortedKeys) {
        id object = [mDic objectForKey:key];
        [sortedValues addObject:object];
    }

    NSMutableString *muString=[[NSMutableString alloc]init];
    for (int i=0; i<[sortedKeys count]; i++) {
        NSString *strkey=[sortedKeys objectAtIndex:i];
        // 对 key 进行 转义符 Encoding
        strkey=[strkey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *strValue=[sortedValues objectAtIndex:i];
        
        if (i==0) {
            [muString appendFormat:@"%@=%@",strkey,strValue];
        }else{
            [muString appendFormat:@"&%@=%@",strkey,strValue];
        }
    }

    NSLog(@"sign_code : %@",muString);
    NSLog(@"sign_code md5 : %@",[muString md5String]);
    return muString;
}
#pragma mark - 获取接口地址、参数等
/**
 添加公共参数
 */
+ (NSMutableDictionary *)getDefaultParamsWithDict:(NSDictionary *)passDict {

    NSMutableDictionary *mDic = ([ToolClass isNotEmptyDict:passDict]) ? [passDict mutableCopy] : [NSMutableDictionary new];
    // ...加默认参数
    
    return mDic;
}
@end

