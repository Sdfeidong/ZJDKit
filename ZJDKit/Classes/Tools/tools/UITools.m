//
//  UITools.m
//  YYKSearch
//
//  Created by aidong on 16/11/29.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "UITools.h"

@implementation UITools
#pragma mark - UIView
/**
 * 给View设置阴影（shadow）
 */
+ (void)viewlayerShadow:(UIView *)view
                 Offset:(CGSize)size
                  color:(UIColor *)color
                 radius:(CGFloat)radius
                opacity:(CGFloat)opacity {
    
    // v.layer.shadowOffset = CGSizeMake(3, 3);
    view.layer.shadowOffset = size;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowRadius = radius;
    view.layer.shadowOpacity = opacity;
}

#pragma mark - UILabel
+ (UILabel*)createLabel:(NSString *)text
                   font:(UIFont *)font
        backgroundColor:(UIColor *)color {
    
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = font;
    label.backgroundColor =  color;
    label.numberOfLines = 0; // 不限行
    label.adjustsFontSizeToFitWidth = YES; // 当frame不够时，字体自适应
    
    // sizeToFit函数的意思是让视图的尺寸刚好包裹其内容。注意sizeToFit方法必要在设置字体、文字后调用才正确。
    // [label sizeToFit];
    return label;
}

#pragma mark - UIButton
-(UIButton*)createButton:(NSString*)title
                     tag:(NSInteger)tag
         backgroundColor:(UIColor *)color {
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [actionButton setTitle:title forState:UIControlStateNormal];
    actionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    actionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    actionButton.tag = tag;
    actionButton.backgroundColor = color;
    [actionButton sizeToFit];
    return actionButton;
}


@end
