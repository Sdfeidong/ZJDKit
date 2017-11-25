//
//  UILabel+EdgeInsert.m
//  GKCC
//
//  Created by aidong on 2017/7/26.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "UILabel+EdgeInsert.h"
#import <objc/runtime.h>

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@implementation UILabel (EdgeInsert)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(zjd_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(zjd_sizeThatFits:));
    });
}

- (void)zjd_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.zjd_contentInsets;
    [self zjd_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)zjd_sizeThatFits:(CGSize)size {
//    if (CGSizeEqualToSize(size, CGSizeZero)) {
//        NSAssert(NO, @"label size can not be CGSizeZero");
//    }
    UIEdgeInsets insets = self.zjd_contentInsets;
    size = [self zjd_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedZjd_contentInsets;
- (void)setZjd_contentInsets:(UIEdgeInsets)zjd_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedZjd_contentInsets, [NSValue valueWithUIEdgeInsets:zjd_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)zjd_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedZjd_contentInsets) UIEdgeInsetsValue];
}

@end
