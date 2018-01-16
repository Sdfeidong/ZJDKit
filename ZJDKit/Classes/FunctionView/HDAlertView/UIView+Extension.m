//
//  UIView+Extension.m
//  YYKSearch
//
//  Created by aidong on 16/12/22.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "UIView+Extension.h"
#import "ZJDKit.h"

@implementation UIView (Extension)

#pragma mark - 快速设置控件的frame
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


#pragma mark - 动画相关
- (instancetype)addAnimationAtPoint:(CGPoint)point; {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    [self.layer addSublayer:shapeLayer];
    shapeLayer.fillColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0].CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

- (instancetype)addAnimationAtPoint:(CGPoint)point WithType:(AnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL))completion {
    
    [self addAnimationAtPoint:point WithDuration:1.0 WithType:type withColor:animationColor  completion:completion];
    
    return self;
}

- (instancetype)addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(AnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 1.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
        case AnimationTypeOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
        case AnimationTypeClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = duration;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        completion(true);
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

- (instancetype)addAnimationAtPoint:(CGPoint)point WithType:(AnimationType)type withColor:(UIColor *)animationColor; {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
        case AnimationTypeOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
        case AnimationTypeClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

// 计算离屏幕的边框最大的距离
- (CGFloat)mdShapeDiameterForPoint:(CGPoint)point {
    CGPoint cornerPoints[] = {
        {0.0, 0.0},
        {0.0, self.bounds.size.height},
        {self.bounds.size.width, self.bounds.size.height},
        {self.bounds.size.width, 0.0}
    };
    
    CGFloat radius = 0.0;
    for (int i = 0; i < 4; i++) {
        CGPoint p = cornerPoints[i];
        CGFloat d = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0));
        if (d > radius) {
            radius = d;
        }
    }
    
    return radius * 2.0;
}

#pragma mark - 视图相关
/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor verticalLine:(BOOL)vertical
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (vertical) {
        // 竖线
        
        // 设置起点
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame), CGRectGetHeight(lineView.frame)/2)];
        // 设置线长
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
        // 设置终点
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
        
    } else {
        // 横线
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
        
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

// 点划线默认
+ (UIView *)drawDefaultDashLineWithFrame:(CGRect)frame vertical:(BOOL)vertical {
    
    UIColor *colorDash = RGBACOLOR(220, 220, 220, 1);
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor clearColor];
    [UIView drawDashLine:line lineLength:0.5 lineSpacing:5 lineColor:colorDash verticalLine:vertical];
    return line;
}


+ (UIView *)lineViewWithFrame:(CGRect)frame WithLineColor:(UIColor *)lineColor {
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = lineColor;
    return line;
}

+ (UIView *)cellSeparatorFrame:(CGRect)frame WithLineColor:(UIColor *)lineColor {
    
    if (!lineColor) {
        lineColor = Color_Stroke;
    }
    
    UIView *line = [UIView lineViewWithFrame:frame WithLineColor:lineColor];
    line.height = 0.6f;
    return line;
}

+ (UIView *)viewWithImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor space:(CGFloat)space{
    
    UIView *midView = [[UIView alloc] init];
    midView.backgroundColor = CLEARCOLOR;
    
    UIImageView *iv = [[UIImageView alloc]initWithImage:image];
    [midView addSubview:iv];
    iv.userInteractionEnabled = YES;
    
    CGSize size = [ToolClass string:title sizeWithFont:font];
    // 分享
    UILabel *fenXiangLabel = [[UILabel alloc]initWithFrame:CGRectMake(iv.right, 0, CEIL(size.width + space), iv.height)];
    fenXiangLabel.backgroundColor = CLEARCOLOR;
    fenXiangLabel.font = font;
    fenXiangLabel.text = title;
    fenXiangLabel.textColor = textColor;
    fenXiangLabel.textAlignment = NSTextAlignmentCenter;
    [midView addSubview:fenXiangLabel];
    fenXiangLabel.userInteractionEnabled = YES;
    
    midView.width = CEIL(iv.width) + fenXiangLabel.width;
    midView.height = CEIL(fenXiangLabel.height);
    
    return midView;
}

/**
 *  小圆点
 */
+ (UIView *)roundDotWithWidth:(CGFloat)width color:(UIColor *)color {
    
    UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    ViewRadius(dotView, width / 2);
    dotView.backgroundColor = color;
    return dotView;
    
    /**
     *  调用示例
     */
    /**
     _dotView = [UIView roundDotWithWidth:10 color:[UIColor redColor]];
     _dotView.centerX = _headImage.width;
     _dotView.centerY = 0;
     [_headImage addSubview:_dotView];
     */
}
/*
 *  渐现 （适合hidden后,出现）
 */
- (void)setSimpleAnimationsFadeInWithDuration:(double)duration{
    
    self.hidden = NO;
    self.alpha = 0;
    
    // 默认最短时间0.2s; 最佳0.4s
    if (duration < 0.2) {
        duration = 0.2;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:duration];
    self.alpha = 1;
    [UIView commitAnimations];
}

@end
