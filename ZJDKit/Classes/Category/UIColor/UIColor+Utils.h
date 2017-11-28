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

@end
