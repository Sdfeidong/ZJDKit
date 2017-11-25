//
//  UIColor+Utils.m
//  YYKSearch
//
//  Created by yyk100 on 16/10/26.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "UIColor+Utils.h"
#import "UIColor+YYAdd.h"

@implementation UIColor (Utils)

+ (UIColor *)randomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height
{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

#pragma mark - 项目用色
+(UIColor *)appMainColor{
    return [UIColor colorWithHexString:@"#9f1716"];
}

//导航条颜色
+ (UIColor *)appNavigationBarColor{
    return [UIColor appMainColor];
}

//app蓝色
+ (UIColor *)appBlueColor{
    return [UIColor colorWithHexString:@"#7687f1"];
}

//app红色
+ (UIColor *)appRedColor{
    return [UIColor colorWithHexString:@"#ff415b"];
}

//app黄色
+ (UIColor *)appYellowColor{
    return [UIColor colorWithHexString:@"#f7ba5b"];
}

//app橙色
+ (UIColor *)appOrangeColor{
    return [UIColor colorWithHexString:@"#ea6644"];
}

//app绿色
+ (UIColor *)appGreenColor{
    return [UIColor colorWithHexString:@"#52cbb9"];
}

//app背景色
+ (UIColor *)appBackGroundColor{
    return [UIColor colorWithHexString:@"#f6f6f6"];
}

//app直线色
+ (UIColor *)appLineColor{
    return [UIColor colorWithHexString:@"#D6D6D6"];
}
//app导航栏文字颜色
+ (UIColor *)appNavTitleColor{
    return [UIColor colorWithHexString:@"#013e5d"];
}
//app标题颜色
+ (UIColor *)appTitleColor{
    return [UIColor colorWithHexString:@"#474747"];
}

//app文字颜色
+ (UIColor *)appTextColor{
    return [UIColor colorWithHexString:@"#A0A0A0"];
}

//app浅红颜色
+ (UIColor *)appLightRedColor{
    return [UIColor colorWithHexString:@"#FFB7C1"];
}

//app输入框颜色
+ (UIColor *)appTextFieldColor{
    return [UIColor colorWithHexString:@"#FFFFFF"];
}

//app黑色色
+ (UIColor *)appBlackColor{
    return [UIColor colorWithHexString:@"#333d47" ];
}
/**
 *  app次分割线
 */
+ (UIColor *)appSecondLineColor{
    return [UIColor colorWithHexString:@"#e5e5e5"];
}

@end

