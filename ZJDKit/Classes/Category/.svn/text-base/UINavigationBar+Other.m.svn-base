//
//  UINavigationBar+Other.m
//  YYKSearch
//
//  Created by aidong on 17/1/21.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "UINavigationBar+Other.h"

@implementation UINavigationBar (Other)

- (void)setColor:(UIColor *)color {
    
    // 创建一个UIView对象，背景颜色由参数获得
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.bounds.size.width, 64)];
    // 使用KVC 直接对backgroundView赋值
    [self setValue:view forKey:@"backgroundView"];
}

@end
