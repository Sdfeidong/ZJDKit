//
//  RegularValidate.h
//  YYKSearch
//
//  Created by yyk100 on 16/9/27.
//  Copyright © 2016年 aidong. All rights reserved.
//

/**
 *  正则校验
 */

#import <Foundation/Foundation.h>

@interface RegularValidate : NSObject

/**
 *  用于验证输入框的内容
 *
 *  @param regText   需要检测的正则表达式
 *  @param candidate 需要检测的字符串
 *
 *  @return 返回的是否为真
 */
+ (BOOL)validate:(NSString *)regText withCandidate:(NSString *)candidate;

// 检测 字符串是否全是数字
+ (BOOL)validateNumber:(NSString *)candidate;

// 检测 邮箱是否正确
+ (BOOL)validateEmail:(NSString *)candidate;

// 检测 用户名
+ (BOOL)validateName:(NSString *)candidate;

// 密码
+ (BOOL)validatePassword:(NSString *)candidate;

//预注册密码
+ (BOOL)validatePrePassword:(NSString *)candidate;

//手机号
+ (BOOL)validatePhone:(NSString *)candidate;

//邮编
+ (BOOL)validatePostCode:(NSString *)candidate;

//图片格式
+ (BOOL)validatePictureType:(NSString *)candidate;

//中文
+ (BOOL)validateChinese:(NSString *)candidate;

//字母和数字
+ (BOOL)validateCharNum:(NSString *)candidate;

//社保卡号
+ (BOOL)validateSocialCard:(NSString *)candidate;

//身份证号
+ (BOOL)validateIDCard:(NSString *)candidate;

@end
