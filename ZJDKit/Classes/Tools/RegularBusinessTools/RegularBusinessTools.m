//
//  RegularBusinessTools.m
//  GKCC
//
//  Created by aidong on 2017/7/15.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "RegularBusinessTools.h"

#import "STAlertView.h"
#import "ZJD_Header.h"
#import "YYKit.h"

NSString *const NotificationID = @"RemindUser";

@implementation RegularBusinessTools

#pragma mark-----相隔多少天没有打开应用就通过本地通知提示用户重新打开应用
/**
 相隔多少天没有打开应用就通过本地通知提示用户重新打开应用
 
 @param day 相隔的天数
 @param message 提示的内容
 @param alertTitle 提示的标题
 */
+ (void)RemindUserWithNotiAfterAFewDays:(NSInteger)day
                       AndRemindMessage:(NSString *)message
                         AndRemindTitle:(NSString *)alertTitle {
    
    [RegularBusinessTools CancelOldNotifactions];//先取消掉之前的通知
    
    // 注册本地通知
    UILocalNotification *localnotifit = [[UILocalNotification alloc] init];
    if (localnotifit) {
        // 获取通知时间
        NSDate *now = [NSDate date];
        localnotifit.timeZone = [NSTimeZone defaultTimeZone];
        
        // XXX秒后开始通知  天换算为秒    day * 24 * 3600
        localnotifit.fireDate = [now dateByAddingTimeInterval:day * 24 * 3600];
        // 重复类型  0 表示不重复
        localnotifit.repeatInterval = 0;
        // 提醒内容
        localnotifit.alertBody = message;
        
        // 通知栏里的通知标题
        if(FSystemVersion > 8.2) localnotifit.alertTitle = alertTitle;
        
        // 默认的通知声音（只有在真机上才会听到）
        localnotifit.soundName = UILocalNotificationDefaultSoundName;
        
        // 通知userInfo中的内容
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:NotificationID forKey:NSStringFromClass([UILocalNotification class])];
        localnotifit.userInfo = dic;
        
        // 将通知添加到系统中
        __async_main__,^{
            [[UIApplication sharedApplication] scheduleLocalNotification:localnotifit];
        });
    }
}


+ (void)CancelOldNotifactions {
    __async_main__,^{
        for (UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
            NSDictionary *notiDic = notification.userInfo;
            if ([[notiDic objectForKey:NSStringFromClass([UILocalNotification class])] isEqualToString:NotificationID]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    });
}

#pragma mark-----异步检查应用更新
/**
 *  异步检查应用更新
 */
+ (void)CheckTheUpdateWithAppID:(NSString *)AppID
{
    NSString *Verson = [UIApplication sharedApplication].appVersion;
    NSString *NewVersion = [Verson stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    // 414478124(微信) 1150760442（优易课）
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:AppID,@"id", nil];
    
    NSString *url = @"https://itunes.apple.com/cn/lookup";
    [ZJD_Networking baseWithUrl:url params:dic cacheTime:0 requestType:ZJD_RequestTypePost success:^(NSString *status, id results,BOOL isComplete) {
        
        NSDictionary *dict = results;
        if (![ToolClass isNotEmptyArray:dict[@"results"]]) {
            return ;
        }
    
        NSLog(@"苹果服务器返回的的版本更新信息---------%@",dict[@"results"][0][@"releaseNotes"]);
        //dict[@"results"][0][@"description"]应用简介
        //dict[@"results"][0][@"releaseNotes"]应用功能说明
        if([dict[@"resultCount"] integerValue])//如果获取成功
        {
            //保存最新版本号
            NSUserDefaults *Defult = [NSUserDefaults standardUserDefaults];
            [Defult setValue:dict[@"results"][0][@"version"] forKey:@"APPSTOREVERSION"];
            [Defult synchronize];
            
            NSString *AppleVerson = [dict[@"results"][0][@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
            if([NewVersion integerValue] < [AppleVerson integerValue])//应对苹果审核
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [STAlertView showTitle:@"有新版本更新"
                                     image:nil
                                   message:dict[@"results"][0][@"releaseNotes"]
                              buttonTitles:@[@"前往更新"]
                                   handler:^(NSInteger index) {
                                       //前去APPStroe下载
                                       NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",AppID];
                                       if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
                                       {
                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                                               
                                           }];
                                       }else
                                       {
                                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                                       }
                                       
                                       [NSThread sleepForTimeInterval:0.5];//否则跳转过程中会看到应用黑掉。。
                                       exit(0);//退出应用
                                   }];
                });
            }
        }
        
    } fail:^(NSError *error){
        
        
    } showHUD:NO faileAlert:NO];
}

#pragma mark-----用户使用两周后再打开应用提示去评价，根据APPID跳转应用市场
/**
 用户使用两周后再打开应用提示去评价，根据APPID跳转应用市场
 @param AppID AppID
 */
+ (void)GotoEvaluateWithAppID:(NSString *)AppID {
    
    NSUserDefaults *Defult = [NSUserDefaults standardUserDefaults];
    NSDate* date = [NSDate date];
    double tick = [date timeIntervalSince1970];
    NSInteger _t = [[NSString stringWithFormat:@"%.0f",tick] integerValue];
    //此版本用户第一次使用的开始时间
    NSInteger _Oldt = [[Defult objectForKey:@"FirstBuldTime"] integerValue];
    NSInteger Day = (_t - _Oldt)/(24 * 60 * 60); //已经使用此版本的天数
    
    //使用大于2周并且未弹出去评价窗口或者弹出被拒绝评价则继续弹出
    if (((Day >= 14)) && (![[NUD_SUD objectForKey:@"ISShowToAppStore"] integerValue])) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"致用户的一封信" message:@"亲爱的用户，经过一段时间的使用，我们真诚的希望您对我们的应用提出宝贵的意见或者建议，有了您的支持才能更好的为您服务，提供更加优质的，更加适合您的应用，感谢您的支持！" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *refuseAction = [UIAlertAction actionWithTitle:@"😭残忍拒绝" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [NUD_SUD setObject:[NSString stringWithFormat:@"%ld",(long)_t] forKey:@"FirstBuldTime"];//两周后继续弹出
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"😝好评赞赏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             AppID];
            
            
            if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }else
            {
                if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                }else
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
            }
            
            [NUD_SUD setObject:@"1" forKey:@"ISShowToAppStore"];//标记已经显示过了
            [NUD_SUD synchronize];
            
        }];
        
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"😓我要吐槽" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
            
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             AppID];
            
            if([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
            
            [NUD_SUD setObject:[NSString stringWithFormat:@"%ld",(long)_t] forKey:@"FirstBuldTime"];//两周后继续弹出
            [NUD_SUD synchronize];
            
        }];
        [alert addAction:okAction];
        [alert addAction:showAction];
        [alert addAction:refuseAction];
        [[UIViewController getTopRootViewController] presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark-----判断是否是第一次启动
/*!
 @brief 判断是否是第一次启动
 */
+ (BOOL)isFirstBuldVesion {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * systemVesion = [UIApplication sharedApplication].appVersion;
    BOOL isFirstV = [systemVesion isEqualToString:[defaults objectForKey:@"Vesion"]];
    // 不论是不是当前版本 都存入新值
    [defaults setObject:systemVesion forKey:@"Vesion"];
    [defaults synchronize];
    
    // 比较存入的版本号是否相同 如果相同则进入tabBar页面否则进入滚动视图
    if (isFirstV) {
        return NO;//不是第一次启动
    }
    
    ////必须写在return之后，存储第一次启动的时间
    NSDate* date = [NSDate date];
    double tick = [date timeIntervalSince1970];
    NSString* _t = [NSString stringWithFormat:@"%.0f",tick];
    [defaults setObject:_t forKey:@"FirstBuldTime"]; //记录新版本第一次启动的时间
    [defaults synchronize];
    
    [defaults setObject:@"0" forKey:@"ISShowToAppStore"];
    [defaults synchronize];
    return YES;
}
@end
