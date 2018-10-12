//
//  ZJD_Macros.h
//  ZJDCodeDemo
//
//  Created by yyk100 on 16/9/6.
//  Copyright © 2016年 aidong. All rights reserved.
//

#ifndef ZJD_Macros_h
#define ZJD_Macros_h


static const CGFloat CELL_SEPARATOR_LINE_HEIGHT = 0.6f;


/** *****************************************  **/

#pragma mark - GCD

/** { thread } */
// __async_opt__
#define __async_global__        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//#define __async_main__ dispatch_async(dispatch_get_main_queue() // 简单的写法
#define __async_main__          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue() // MJ的写法

/** *****************************************  **/

#define weakSelf(weakSelf) __weak typeof(self)weakSelf = self;
#define strongSelf(strongSelf) __strong typeof(weakSelf)strongSelf = weakSelf; if (!strongSelf) return;

/** *****************************************  **/

#pragma mark - 常用系统的单例

/** 常用系统的单例 */
#define APP_share               (UIApplication *)[UIApplication sharedApplication]
#define APP_Delegate            (AppDelegate *)[APP_share delegate]
#define NUD_SUD                 [NSUserDefaults standardUserDefaults]
#define NNC_DC                  [NSNotificationCenter defaultCenter]
#define NFM_DM                  [NSFileManager defaultManager]

/** *****************************************  **/

#pragma mark - 图片（image）

#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]


/** *****************************************  **/

#pragma mark - 字体/字号（font）
// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)     [UIFont fontWithName:(NAME) size:(FONTSIZE)]
//方正黑体简体字体定义
//#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

// 自定义字体
#define TEXT_FONT_18        SYSTEMFONT(18)
#define TEXT_FONT_17        SYSTEMFONT(17)
#define TEXT_FONT_16        SYSTEMFONT(16)
#define TEXT_FONT_15        SYSTEMFONT(15)
#define TEXT_FONT_14        SYSTEMFONT(14)
#define TEXT_FONT_13        SYSTEMFONT(13)
#define TEXT_FONT_12        SYSTEMFONT(12)
#define TEXT_FONT_11        SYSTEMFONT(11)
#define TEXT_FONT_10        SYSTEMFONT(10)
#define TEXT_FONT_8         SYSTEMFONT(8)

#define TEXT_FONT_IPHONE_14     ((isiPad) ? SYSTEMFONT(16) : SYSTEMFONT(14))
#define TEXT_FONT_IPHONE_12     ((isiPad) ? SYSTEMFONT(14) : SYSTEMFONT(12))

#pragma mark - 圆角和加边框
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


/** *****************************************  **/

#pragma mark - 本地化字符串

//程序的本地化,引用国际化的文件
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define LocalString(x, ...)     NSLocalizedString(x, nil)
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)


/** *****************************************  **/

#pragma mark - 系统（system）

#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif

/** 检查系统版本 */
// 优先使用这几种方法判断系统
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// 当前版本
#define SSystemVersion          [[UIDevice currentDevice] systemVersion]
#define FSystemVersion          [[[UIDevice currentDevice] systemVersion] floatValue]
#define DSystemVersion          [[[UIDevice currentDevice] systemVersion] doubleValue]

#define iOS5_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")
#define iOS6_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define iOS9_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define iOS10_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")


/** 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define isiPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


/** 获取当前语言 */
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** *****************************************  **/

#pragma mark - DEBUG LOG
// DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...);
#endif

// DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif


/** DEBUG RELEASE **/
#if DEBUG
#define MCRelease(x)            [x release]
#else
#define MCRelease(x)            [x release], x = nil
#endif

/** NIL RELEASE **/
#define NILRelease(x)           [x release], x = nil


/** *****************************************  **/

#pragma mark - Log Method (宏 LOG)

// 日志 / 断点
// DEBUG模式
#define ITTDEBUG

// LOG等级
#define ITTLOGLEVEL_INFO        10
#define ITTLOGLEVEL_WARNING     3
#define ITTLOGLEVEL_ERROR       1

// LOG最高等级
#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// LOG PRINT
// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)      NSLog(@"< %s:(%d) > : " xx , __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)      ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME()   ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)      ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)      ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)    ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)    ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)       ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)       ((void)0)
#endif

// 条件LOG
#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...)\
\
{\
if ((condition))\
{\
ITTDPRINT(xx, ##__VA_ARGS__);\
}\
}
#else
#define ITTDCONDITIONLOG(condition, xx, ...)\
\
((void)0)
#endif

// 断点Assert
#define ITTAssert(condition, ...)\
\
do {\
if (!(condition))\
{\
[[NSAssertionHandler currentHandler]\
handleFailureInFunction:[NSString stringWithFormat:@"< %s >", __PRETTY_FUNCTION__]\
file:[[NSString stringWithUTF8String:__FILE__] lastPathComponent]\
lineNumber:__LINE__\
description:__VA_ARGS__];\
}\
} while(0)

/** *****************************************  **/

#pragma mark - number转String
// int 转 string
#define IntTranslateStr(int_str) [NSString stringWithFormat:@"%d",int_str];
#define FloatTranslateStr(float_str) [NSString stringWithFormat:@"%.2d",float_str];

/** *****************************************  **/

// 解决 label的宽高非整数时在iPhone6以后设备上显示边缘有黑线的问题
// 向上取整

#define CEIL(width)                  ceil(width)


/** *****************************************  **/

#pragma mark - Frame/Bounds相关 (宏 x, y, width, height)

// MainScreen Height&Width
#define kMScreen_Bounds     [UIScreen mainScreen].bounds
#define kMScreen_W          kMScreen_Bounds.size.width
#define kMScreen_H          kMScreen_Bounds.size.height

// 屏幕尺寸的宽高与scale的乘积就是相应的分辨率值
#define kMScreen_Scale       [UIScreen mainScreen].scale

#define ZJD_KeyWindow [UIApplication sharedApplication].keyWindow
#define ZJD_FirstWindow [UIApplication sharedApplication].windows.firstObject
#define ZJD_RootViewController ZJD_KeyWindow.rootViewController

// 当前屏幕宽度与iPhone6宽度比
#define Scale_WithiPhone6       kMScreen_W/375

//适配宏 width 取整数
#define RELATIVESIZE(width)     ceil((float)(width) * Scale_WithiPhone6)

// banner 或 视频高度
/**
 屏幕 w : h (4 : 3)
 */
#define kDefaultHeight3             CEIL(kMScreen_W * 3 / 4)
/**
 屏幕 w : h (16 : 9)
 */
#define kDefaultHeight9             CEIL(kMScreen_W * 9 / 16)

// 系统控件默认高度
#define kStatusBarHeight            (iPhoneX ? 44.f : 20.f)
#define kTopBarHeight               (44.f)
#define kHomeIndicatorHeight        (iPhoneX ? 34.f : 0.f)
#define kBottomBarHeight            (49.f)

#define kNavBarHeight               (iPhoneX ? 88.f : 64.f)
#define kBottomHeight               (iPhoneX ? (49.f + 34.f) : 49.f)

// SureButton整体高度 40或49
#define kSureButtonHeight        (40.f) // 确认，提交按钮默认高度
#define kSureButtonLeftPadding   (15.f)

#define kBottomBarBtnWidth       (120.f)
#define kBottomBarBtnHeight      (35.f)

#define kCellDefaultHeight          (44.f)

#define kEnglishKeyboardHeight      (216.f)
#define kChineseKeyboardHeight      (252.f)

#define kNavTitleButtonWidth        (60.f)

#define kNavButtonWidth             ((isiPad) ? (60.f) : (44.f))
#define KNaVButtonHeight            (44.f)

#define kDefaultCellHeight          ((isiPad) ? (60.f) : (44.f))
#define KdefaultCellLeftPadding     ((isiPad) ? (50.f) : (15.f))

/** *****************************************  **/

/** 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */

#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

/** *****************************************  **/

#pragma mark - 其他

// 设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)      [_OBJECT viewWithTag : _TAG]

// 由角度获取弧度
#define degreesToRadian(x)              (M_PI * (x) / 180.0)
// 弧度获取角度
#define radianToDegrees(radian)         (radian*180.0)/(M_PI)

// 定义一个define函数
#define TT_RELEASE_CF_SAFELY(__REF)     { if (nil != (__REF)) { CFRelease(__REF); __REF = nil; } }

// 是非空字符串，但可能是空格
#define kStringIsValid(str)             ([(str) isKindOfClass:[NSString class]] && [(str) length] > 0 && (![str isEqualToString:@"<null>"]) && (![str isEqualToString:@"(null)"]))

// 去string两端空格及换行符
#define GetNoWhiteSpaceString(str)      [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

// 字符串不为空(去空格)
#define kStringIsNotEmpty(str)          (kStringIsValid(str) && kStringIsValid(GetNoWhiteSpaceString(str)))


/** *****************************************  **/
// 纯数字
#define NUMBERS      @"0123456789"
// 字母和数字
#define CHARENUM  @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

/** *****************************************  **/


/** *****************************************  **/

/** 随机数（ 0 ~ num 不包括num） */
#define RANDNUM(num)            arc4random() % num
// NSInteger total = 1+arc4random()%(5);

/** 时间间隔 */
#define kHUDDuration            (1.f)

/** 一天的秒数 */
#define SecondsOfDay            (24.f * 60.f * 60.f)
/** 秒数 */
#define Seconds(Days)           (24.f * 60.f * 60.f * (Days))

/** 一天的毫秒数 */
#define MillisecondsOfDay       (24.f * 60.f * 60.f * 1000.f)
/** 毫秒数 */
#define Milliseconds(Days)      (24.f * 60.f * 60.f * 1000.f * (Days))

// 默认缓存过期时间 30天
#define kDefaultTimeoutInterval     Seconds(30)


/** *****************************************  **/
#define Title_NoInput            @"未填写"
#define Title_NoSelected         @"未选择"

/** *****************************************  **/

/** *****************************************  **/

#pragma mark - 提示语
// HUD显示语
#define Msg_Loading             @"请稍候..."

// Alert提示语
#define Msg_NetworkAnomalies    @"网络连接失败，请稍候再试"
#define Msg_NetworkError        @"无网络服务，请检查网络"
// 网络请求超时
#define Msg_NetworkTimeOut      @"请求超时"
// 没有数据
#define Msg_NotGetDataSource    @"暂无数据"
// 网络异常，重新获取数据
#define Msg_GetDataAgain        @"网络异常，重新加载"
// 请求数据失败
#define Msg_GetDataFail         @"请求数据失败"

// 未获取到习题
#define Msg_NotGetExercises     @"暂无相关习题"
// 暂无相关课程
#define Msg_NotGetCourse        @"暂无相关课程"
// 没有数据
#define Msg_NotGetClassData     @"您还没有加入班级"
// 添加成功
#define Msg_AddSuccess          @"添加成功"
// 添加失败
#define Msg_AddFailed           @"添加失败"
// 修改成功
#define Msg_ModifySuccess       @"修改成功"
// 修改成功
#define Msg_ModifyFailed        @"修改失败"

// 没输入手机号
#define Msg_NoPhoneNum          @"手机号不能为空"
// 没输入验证码
#define Msg_InputVerifyCode     @"请输入验证码"
// 没输入密码
#define Msg_NoPassword          @"密码不能为空"
// 请输入正确的手机号
#define Msg_InputPhoneNum       @"手机号格式不正确"
// 请输入密码
#define Msg_InputPassword       @"请输入密码：6~16位数字或字母"
#define Msg_SettingPassword     @"请设置密码：6~16位数字或字母"

// 账号或密码错误
#define Msg_WrongAccountPassword    @"账号或密码错误"

/** *****************************************  **/


/** *****************************************  **/
#pragma mark - Button显示文字

// 确认 按钮
#define ButtonTitle_Sure                @"确认"
// 确认 按钮带两个英文空格
#define ButtonTitle_SureWithBlank       @"确  认"
// 提交 按钮
#define ButtonTitle_Submit              @"提交"
// 提交 按钮带两个英文空格
#define ButtonTitle_SubmitWithBlank     @"提  交"

// 确认 按钮
#define ButtonTitle_Search              @"搜索"
// 确认 按钮带两个英文空格
#define ButtonTitle_SearchWithBlank     @"搜  索"

// 登录 按钮
#define ButtonTitle_Login               @"登录"
// 登录 按钮带两个英文空格
#define ButtonTitle_LoginWithBlank      @"登  录"
// 登出 按钮
#define ButtonTitle_LogOut              @"退出登录"

/** *****************************************  **/

#endif

