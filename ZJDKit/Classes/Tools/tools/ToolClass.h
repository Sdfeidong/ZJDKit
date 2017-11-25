//
//  ToolClass.h
//  NEWSapp
//
//  Created by aidong on 14-10-28.
//  Copyright (c) 2014年 aidong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^RequestFinishedBlock)(id result);
typedef void(^RequestFaildBlock)(void);
typedef void(^myBlock)(BOOL seccess);

@interface ToolClass : NSObject

/**
 *  一句提示语
 */
+ (void)simpleAlertWithTips:(NSString *)tips withAlert:(NSString *)alert superVC:(UIViewController *)superVC isAutoDismiss:(BOOL)isAutoDismiss;

#pragma mark - SDImageCache清理
+ (void)SDImageCacheClearWithSleepTimeInterval:(CGFloat)TimeInterval SDWebImageManagerCancelAll:(BOOL)cancelAll;

#pragma mark - image
/** 图片获取 **/
+ (NSString *)imageUrlWithStrUrl:(NSString *)url;
+ (UIImage *)imageWithStrUrl:(NSString *)url;
+ (UIImage*)imageWithColor:(UIColor*)color rect:(CGRect)rect;

+ (UIImage *)imageFromView: (UIView *)theView;

/**
 *  头像的加载 原 200 * 267 先截取上部分 200 * 200 再填充 IV
 */
+ (void)setAvatarImageWithImageURL:(NSURL *)url avatar_IV:(UIImageView *)avatar_IV;

/**
 @abstract 将一个UIImage添加高斯模糊效果.
 @param image 需要处理的UIImage.
 @param blur 高斯模糊的等级.
 @returns 返回一个加过高斯模糊的UIImage.
 */
+ (UIImage *)transferBlurImage:(UIImage *)image withBlurLevel:(CGFloat)blur rect:(CGRect)rect;


// ios5 Json
+ (id)iOS5_JSONObjectWithData:(NSData *)jsonData;

+ (NSData *)objectToJSONData:(id)theData;

#pragma -mark NSStrin
/**
 *  字符 @“A” 、@“B”、@“C” ... 转数字 @“1”、@“2”、@“3”
 */
+ (NSString *)numberStringWithCharacterString:(NSString *)charStr;
/**
 *  字符串拼接 如：（A,B,C,D）
 *
 *  @param array  array 拼接的字符串的数组
 *  @param midStr @","
 *
 *  @return A,B,C,D
 */
+ (NSString *)StringByArrayStr:(NSArray <NSString *> *)array midStr:(NSString *)midStr;
/**
 *  字符串替换
 */
+ (NSString *)string:(NSString *)originalStr withSearchStr:(NSString *)search withReplace:(NSString *)replace;
/**
 *  HTML字符串替换
 */
+ (NSString *)replaceHtmlStr:(NSString *)htmlStr;

/**
 *  截取字符串 (向前截取)
 */
+ (NSString *)fromString:(NSString *)originalStr withString:(NSString *)midStr;

/**
 *  截取字符串 (向后截取)
 */
+ (NSString *)backwardFromString:(NSString *)originalStr withString:(NSString *)midStr;
/**
 *  CGSize 字符串占得大小
 */
+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font;
/**
 *  替换字符串 (后边字符串替换)
 */
+ (NSString *)fromString:(NSString *)originalStr withString:(NSString *)midStr appendingStr:(NSString *)appendingStr;
+ (CGSize)getSingleRowSizeWithString:(NSString *)string
                            withFont:(UIFont *)font;

+ (CGSize)string:(NSString *)string boundingRectWithWidth:(CGFloat)width font:(UIFont *)font;

+ (CGFloat)getHeightWithString:(NSString *)string rectWidth:(CGFloat)width textFont:(UIFont *)font space:(CGFloat)space;

/**
 *  字典转json字符串 （按自定义的key顺序转换）
 */
+ (NSString *) jsonStrWithDict:(NSDictionary *)dict keyArr:(NSArray *)keyArr;

/**
 *  字典转XML字符串 （按自定义的key顺序转换）
 */
+ (NSString *) xmlStrWithDict:(NSDictionary *)dict keyArr:(NSArray *)keyArr headMsg:(NSString *)headMsg headNode:(NSString *)headNode;

#pragma -mark Label
/**
 *  label.text 行间距排列
 */
+ (void)labelText:(NSString *)string withLabel:(UILabel *)label withLabelSpace:(CGFloat)space limitRows:(NSInteger)number;
/**
 *  string 获取高度
 */
+ (CGFloat)getStringHeightWithText:(NSString *)string withLabelWidth:(CGFloat)width withTextFont:(UIFont *)font withSpace:(CGFloat)space;
/**
 *  label 获取高度
 */
+ (CGFloat)getLabelHeightWithText:(NSString *)string withLabel:(UILabel *)label withSpace:(CGFloat)space;
/**
 *  获取一个固定宽高的label
 */
+ (UILabel *)labelWithText:(NSString *)string withLabelWidth:(CGFloat)width withSpace:(CGFloat)space withFont:(UIFont*)font limitRows:(NSInteger)number;
/**
 *  label上字体颜色分段显示
 */
+ (void)labelText:(NSString *)string textColor:(UIColor *)textColor withLabel:(UILabel *)label withRangeString:(NSString *)rangeStr rangeColor:(UIColor *)rangeColor;
/**
 *  导航栏中心label
 */
+ (UILabel *)navCenterTitleLabelWithUILabel:(UILabel *)label;


#pragma mark - Img_label_View
+ (UIView *)getImg_label_ViewWithImage:(UIImage *)image img_width:(CGFloat)img_width label_text:(NSString *)label_text label_font:(UIFont *)label_font text_color:(UIColor *)text_color image_label_space:(CGFloat)space;

#pragma mark - NSString
/**
 *  BOOL  验证字符串是否是一个数字（整形）
 */
+ (BOOL)verifyStringisNumber:(NSString *)string;

/*0--1 : lerp( float percent, float x, float y ){ return x + ( percent * ( y - x ) ); };*/
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax;


/**
 * 渐变图层
 */
+ (void) insertTransparentGradientView:(UIView *)tempView;

#pragma 排序
/**
 *  选择排序 数组里都是dict 排序关键字是可转int  ascending 升（YES）/降
 */
+ (NSArray *)selectSortWithArray:(NSArray *)arrDict keywords:(NSString *)keywords ascending:(BOOL)ascending;
/**
 *  选择排序 数组里都是dict 排序关键字是可转int (顺序)
 */
+ (NSArray *)selectSortWithArray:(NSArray *)arrDict keywords:(NSString *)keywords;
/**
 *  选择排序 数组里都是可转int
 */
+ (NSArray *)selectSortWithArray:(NSArray *)aData;
/**
 *  选择排序 数组里都是可转int (倒序)
 */
+ (NSArray *)selectSortReverseOrderWithArray:(NSArray *)aData;

+ (NSMutableArray *)sortArrayWithMutableArray:(NSMutableArray *)mutArr Key:(NSString *)key ascending:(BOOL)ascend;

/**
 *  sortDescriptor  排序
 *
 *  dataArray       源数据
 *  keyArray        排序的关键字
 *  ascendingArray  升降序数组 @[YES,YES]
 */
+ (NSMutableArray *)sortDescriptorWithDataArray:(NSMutableArray *)dataArray keyArray:(NSArray *)keyArray ascendingArray:(NSArray *)ascendingArray;

#pragma mark - NSUserDefault
/** 清除 所有NSUserDefault的数据 */
+ (void)cleanAllUserDefault;

#pragma mark - 判断对象是否为空
/**
 *  判断对象是否为空
 *  PS：nil、NSNil、@""、@0 以上4种返回YES
 *
 *  @return YES 为空  NO 为实例对象
 */
+ (BOOL)isNullOrNilWithObject:(id)object;
/**
 *  判断对象是否为非空字典
 */
+ (BOOL)isNotEmptyDict:(id)object;
/**
 *  判断对象是否为非空数组
 */
+ (BOOL)isNotEmptyArray:(id)object;
/**
 *  判断对象是数组 但为空
 */
+ (BOOL)isEmptyArray:(id)object;

#pragma mark - 其它
/**
 当前账号是否支持 指纹登录验证
 
 @return YES/NO
 */
+ (BOOL)isCurrentAccountSupportTouch:(NSString *)sud_key;

/**
 打电话
 */
+ (void)telephoneTnterviewWithTel:(NSString *)tel;

/**
 *  是否调用系统相机
 */
+ (BOOL)isCanOpenCamera;

/**
 *  是否可以调用系统相册
 */
- (BOOL)isCanOpenPhoto;

#pragma mark - 随机数据
/**
 获取几张随机图片
 */
+ (NSArray *)getPictureNameWithTotal:(NSInteger)total;
/**
 获取几张随机图片
 */
+ (NSArray *)getPictureWithTotal:(NSInteger)total;

/**
 获取随机的标签(tags)
 */
+ (NSArray *)getRandTags;

/**
 获取随机的图片url
 */
+ (NSString *)getRandPhotoUrl;

/**
 获取随机的用户名
 */
+ (NSString *)getRandUsername;
/**
 获取随机的评论
 */
+ (NSString *)getRandComment;
/**
 获取随机活动名称
 */
+ (NSString *)getRandActivityTitle;
/**
 获取随机机构名称
 */
+ (NSString *)getRandPlaceTitle;
/**
 获取随机地址
 */
+ (NSString *)getRandPlaceAddress;

@end


