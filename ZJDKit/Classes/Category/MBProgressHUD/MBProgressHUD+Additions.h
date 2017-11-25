//
//  MBProgressHUD+Additions.h
//  YYKSearch
//
//  Created by aidong on 17/2/3.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, MBHUD_CustomIconType) {
    MBHUD_Success,
    MBHUD_Error,
    MBHUD_Info,
    MBHUD_Warn
};

@interface MBProgressHUD (Additions)

/**
 * 加载 MBProgressHUD;
 */
+ (void)loadingMBProgressHUD;


+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow;
+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message withSuperView:(UIView *)superView;


+ (void)hideHUDWithSuperView:(UIView *)superView;
+ (void)hideHUD;


+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;


+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;


+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;

+ (void)showCustomIconWithType:(MBHUD_CustomIconType)type
                       message:(NSString *)message
                      isWindow:(BOOL)isWindow;

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;


@end
