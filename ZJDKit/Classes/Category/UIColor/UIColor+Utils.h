//
//  UIColor+Utils.h
//  YYKSearch
//
//  Created by yyk100 on 16/10/26.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)randomColor;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;


/**
 *  导航条颜色
 */
+ (UIColor *)appNavigationBarColor;

/**
 *  app蓝色
 */
+ (UIColor *)appBlueColor;

/**
 *  app红色
 */
+ (UIColor *)appRedColor;

/**
 *  app黄色
 */
+ (UIColor *)appYellowColor;

/**
 *  app橙色
 */
+ (UIColor *)appOrangeColor;

/**
 *  app绿色
 */
+ (UIColor *)appGreenColor;

/**
 *  app背景色
 */
+ (UIColor *)appBackGroundColor;
/**
 *  app主题颜色
 * */
+ (UIColor *)appMainColor;

/**
 *  app直线颜色
 */
+ (UIColor *)appLineColor;
//app导航栏文字颜色

+ (UIColor *)appNavTitleColor;
/**
 *  app标题颜色
 */
+ (UIColor *)appTitleColor;

/**
 *  app文字颜色
 */
+ (UIColor *)appTextColor;

/**
 *  app浅红色颜色
 */
+ (UIColor *)appLightRedColor;

/**
 *  app输入框颜色
 */
+ (UIColor *)appTextFieldColor;

/**
 *  app黑色颜色
 */
+ (UIColor *)appBlackColor;


/**
 *  app次分割线
 */
+ (UIColor *)appSecondLineColor;

@end
