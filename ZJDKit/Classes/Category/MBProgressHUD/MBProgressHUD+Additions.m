//
//  MBProgressHUD+Additions.m
//  YYKSearch
//
//  Created by aidong on 17/2/3.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "MBProgressHUD+Additions.h"
#import "ZJD_Macros.h"

// 自动消失的时间
#define MB_AUTO_DISAPPEAR_TIME 1.5f
//
#define MB_LABEL_FONT 14

@implementation MBProgressHUD (Additions)

/**
 * 加载 MBProgressHUD;
 */
+ (void)loadingMBProgressHUD{
    __async_main__,^{
        [self createMBProgressHUDviewWithMessage:nil isWindiw:YES];
    });
}

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    UIView  *view = isWindow ? (UIView*)[UIApplication sharedApplication].delegate.window : [self getCurrentUIVC].view;
    // 如果有HUD 先隐藏
    [self hideHUDWithSuperView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message ? message : Msg_Loading;
    hud.label.font = [UIFont systemFontOfSize:MB_LABEL_FONT];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message withSuperView:(UIView *)superView
{
    UIView  *view = (superView == nil) ? (UIView*)[UIApplication sharedApplication].delegate.window : superView;
    // 如果有HUD 先隐藏
    [self hideHUDWithSuperView:view];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message ? message : Msg_Loading;
    hud.label.font = [UIFont systemFontOfSize:MB_LABEL_FONT];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
#pragma mark-------------------- show Tip----------------------------

+ (void)showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:MB_AUTO_DISAPPEAR_TIME];
}
+ (void)showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:MB_AUTO_DISAPPEAR_TIME];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
        hud.mode = MBProgressHUDModeText;
        [hud hideAnimated:YES afterDelay:aTimer];
    });
}

#pragma mark-------------------- show Activity----------------------------

+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------
+ (void)showCustomIconWithType:(MBHUD_CustomIconType)type
                       message:(NSString *)message
                      isWindow:(BOOL)isWindow
{
    NSString *iconName = @"MBHUD_Info";
    if (type == MBHUD_Success) {
        iconName = @"MBHUD_Success";
    } else if (type == MBHUD_Error) {
        iconName = @"MBHUD_Error";
    } else if (type == MBHUD_Info) {
        iconName = @"MBHUD_Info";
    } else if (type == MBHUD_Warn) {
        iconName = @"MBHUD_Warn";
    }
    [self showCustomIcon:iconName message:message isWindow:isWindow];
}

+ (void)showSuccessMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Success" message:Message];
}
+ (void)showErrorMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Error" message:Message];
}
+ (void)showInfoMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Info" message:Message];
}
+ (void)showWarnMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Warn" message:Message];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:true];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false];
}
+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    // 做个延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"MBProgressHUD+Additions.bundle/MBProgressHUD" stringByAppendingPathComponent:iconName]]];
        hud.mode = MBProgressHUDModeCustomView;
        [hud hideAnimated:YES afterDelay:MB_AUTO_DISAPPEAR_TIME];
    });
}

#pragma mark - 隐藏
+ (void)hideHUDWithSuperView:(UIView *)superView
{
    if (superView) {
        [self hideHUDForView:superView animated:YES];
    } else {
        [self hideHUD];
    }
}
/**
 * 隐藏 MBProgressHUD;
 */
+ (void)hideHUD
{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[self getCurrentUIVC].view animated:YES];
}

#pragma mark - 获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}
+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }
    return superVC;
}

@end
