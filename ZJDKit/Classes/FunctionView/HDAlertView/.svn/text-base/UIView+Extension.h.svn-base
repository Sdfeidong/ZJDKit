//
//  UIView+Extension.h
//  YYKSearch
//
//  Created by aidong on 16/12/22.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypeOpen, // 动画开启
    AnimationTypeClose // 动画关闭
};


@interface UIView (Extension)

#pragma mark - 快速设置控件的frame
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;


#pragma mark - 动画相关
/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 */
- (instancetype)addAnimationAtPoint:(CGPoint)point;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param animationColor 动画的颜色
 */
- (instancetype)addAnimationAtPoint:(CGPoint)point WithType:(AnimationType)type withColor:(UIColor *)animationColor;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param animationColor 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (instancetype)addAnimationAtPoint:(CGPoint)point WithType:(AnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;

/**
 *  在某个点添加动画
 *
 *  @param point      动画开始的点
 *  @param duration   动画时间
 *  @param type       动画的类型
 *  @param animationColor 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (instancetype)addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(AnimationType) type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;

#pragma mark - 视图相关
/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 ** 竖线	  BOOL
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor verticalLine:(BOOL)vertical;

// 点划线默认
+ (UIView *)drawDefaultDashLineWithFrame:(CGRect)frame vertical:(BOOL)vertical;

+ (UIView *)lineViewWithFrame:(CGRect)frame WithLineColor:(UIColor *)lineColor;

/**
 自定义cell分割线
 */
+ (UIView *)cellSeparatorFrame:(CGRect)frame WithLineColor:(UIColor *)lineColor;

+ (UIView *)viewWithImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor space:(CGFloat)space;

/**
 *  小圆点
 */
+ (UIView *)roundDotWithWidth:(CGFloat)width color:(UIColor *)color;

/*
 *  渐现 （适合hidden后,出现）
 */
- (void)setSimpleAnimationsFadeInWithDuration:(double)duration;

@end
