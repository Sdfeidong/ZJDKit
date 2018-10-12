//
//  UILabel+SetLabelSpace.h
//  ZJDKit
//
//  Created by aidong on 2018/10/12.
//

#import <UIKit/UIKit.h>

@interface UILabel (SetLabelSpace)


/**
 label 设置行间距 （space 行间距）
 */
- (void)setLabelSpace:(CGFloat)space
              withStr:(NSString*)str
             withFont:(UIFont*)font;

/**
 获取label高度
 */
+ (CGFloat)getLabelHeightWithSpace:(CGFloat)space
                           withStr:(NSString*)str
                          withFont:(UIFont*)font
                         withWidth:(CGFloat)width;

@end
