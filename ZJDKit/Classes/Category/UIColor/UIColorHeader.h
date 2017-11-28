//
//  UIColorHeader.h
//  YYKSearch
//
//  Created by yyk100 on 16/10/26.
//  Copyright © 2016年 aidong. All rights reserved.
//

#ifndef UIColorHeader_h
#define UIColorHeader_h

#import "UIColor+Utils.h"
/** *****************************************  **/

#pragma mark - 颜色（color）

// RGB颜色转换（16进制）(0x000000--0xFFFFFF)
#define UIColorFromHexadecimal(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 颜色(RGBA) (当 a=1 时,表示不透明）
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1)]
// 随机颜色
#define RANDCOLOR               [UIColor randomColor]
// 透明色（无颜色）
#define CLEARCOLOR              [UIColor clearColor]

// 颜色越来越淡 都是黑色
#define Color_Black             [UIColor blackColor]
#define Color_TextBlack         UIColorFromHexadecimal(0x0d0d0d)
#define Color_TextBlack_33      UIColorFromHexadecimal(0x333333)
#define Color_TextBlack_66      UIColorFromHexadecimal(0x666666)
#define Color_TextBlack_99      UIColorFromHexadecimal(0x999999)

// 白色
#define Color_White             [UIColor whiteColor]
#define Color_TextWhite_ff      UIColorFromHexadecimal(0xffffff)
#define Color_TextWhite_f8      UIColorFromHexadecimal(0xf8f8f8)

// 灰色
#define Color_Gray_CellSep_e2   UIColorFromHexadecimal(0xe2e2e2) // cell分割线颜色
#define Color_TextGray_102      RGBACOLOR(102, 102, 102, 1) // 深灰
#define Color_TextGray_7c       UIColorFromHexadecimal(0x7c7c7c) // 灰黑1
#define Color_TextGray_7f       UIColorFromHexadecimal(0x7f7f7f) // 灰黑2
#define Color_TextGray_cc       UIColorFromHexadecimal(0xcccccc) // 标签色
#define Color_TextGray_ee       UIColorFromHexadecimal(0xeeeeee) // 标签色
#define Color_TextGray_fe       UIColorFromHexadecimal(0xfefefe) // 描边色
#define Color_TextGray_Tag      UIColorFromHexadecimal(0x646464) // 标签色
#define Color_TextGray_Sum      UIColorFromHexadecimal(0x808080) // 摘要
#define Color_GrayBorder_dd     UIColorFromHexadecimal(0xdddddd)
/**
 灰色背景 白色字体可显示
 */
#define Color_TextGray_200      RGBCOLOR(200, 200, 200)

// 蓝色
#define Color_DashLine_Blue     RGBACOLOR(68, 138, 202, 1)
#define Color_BG_Blue           UIColorFromHexadecimal(0xa2c0db) // 非常淡的蓝色
#define Color_TextBlue          UIColorFromHexadecimal(0x228ee6)
// 红色 常用作价格
#define Color_TextRedPrice      UIColorFromHexadecimal(0xff0000)
// 金钱的显示颜色 （金黄色）
#define Color_Money             RGBACOLOR(235, 194, 0, 1)
//
#define Color_BG_Note           RGBACOLOR(255, 251, 207, 1)

#define Color_TableBG           RGBACOLOR(239, 239, 239, 1) // tableView 背景色
#define Color_Stroke            RGBACOLOR(208, 208, 208, 1) // 描边色

#define Color_TabBlue           RGBACOLOR(28, 126, 253, 1)
#define Color_SearchBlue        RGBACOLOR(35, 98, 223, 1)
#define Color_SearchTextBlue    RGBACOLOR(82, 129, 228, 1)
/** *****************************************  **/


#endif /* UIColorHeader_h */
