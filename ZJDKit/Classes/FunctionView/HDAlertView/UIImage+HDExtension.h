//
//  UIImage+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 15/1/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HDExtension)

/**
 *  拉伸图片
 *
 *  @param name 图片名字
 *
 *  @return 拉伸好的图片
 */
+ (instancetype)hd_resizedImageWithImageName:(NSString *)name;

/**
 *  拉伸图片
 *
 *  @param image 要拉伸的图片
 *
 *  @return 拉伸好的图片
 */
+ (instancetype)hd_resizedImageWithImage:(UIImage *)image;

/**
 *  返回一个缩放好的图片
 *
 *  @param image  要切割的图片
 *  @param imageSize 边框的宽度
 *
 *  @return 切割好的图片
 */
+ (instancetype)hd_cutImage:(UIImage*)image andSize:(CGSize)imageSize;

/**
 *  返回一个下边有半个红圈的原型头像
 *
 *  @param image  要切割的图片
 *
 *  @return 切割好的头像
 */
+ (instancetype)hd_captureCircleImage:(UIImage*)image;

/**
 *  根据url返回一个圆形的头像
 *
 *  @param iconUrl 头像的URL
 *  @param border  边框的宽度
 *  @param color   边框的颜色
 *
 *  @return 切割好的头像
 */
+ (instancetype)hd_captureCircleImageWithURL:(NSString *)iconUrl andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  根据iamge返回一个圆形的头像
 *
 *  @param iconImage 要切割的头像
 *  @param border    边框的宽度
 *  @param color     边框的颜色
 *
 *  @return 切割好的头像
 */
+ (instancetype)hd_captureCircleImageWithImage:(UIImage *)iconImage andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (instancetype)hd_blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount;

/**
 *  截取对应的view生成一张图片
 *
 *  @param view 要截的view
 *
 *  @return 生成的图片
 */
+ (instancetype)hd_viewShotWithView:(UIView *)view;

/**
 *  截屏
 *
 *  @return 返回截屏的图片
 */
+ (instancetype)hd_screenShot;

/**
 *  给图片添加水印
 *
 *  @param bgName         原图的名字
 *  @param waterImageName 水印的名字
 *
 *  @return 添加完水印的图片
 */
+ (instancetype)hd_waterImageWithBgImageName:(NSString *)bgName andWaterImageName:(NSString *)waterImageName ;

/**
 *  图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param percent 要压缩的比例(建议在0.3以上)
 *
 *  @return 压缩之后的图片
 *
 *  @exception 压缩之后为image/jpeg 格式
 */
+ (instancetype)hd_reduceImage:(UIImage *)image percent:(CGFloat)percent;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param newSize 压缩后的图片的像素尺寸
 *
 *  @return 压缩好的图片
 */
+ (instancetype)hd_imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  生成了一个毛玻璃效果的图片
 *
 *  @return 返回模糊化好的图片
 */
- (instancetype)hd_blurredImage:(CGFloat)blurAmount;

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @param blurLevel 毛玻璃的模糊程度
 *
 *  @return 毛玻璃好的图片
 */
- (instancetype)hd_blearImageWithBlurLevel:(CGFloat)blurLevel;

/**
 *  根据颜色返回图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (instancetype)hd_imageWithColor:(UIColor *)color;

/**
 *  这里要分享的是将image旋转，而不是将imageView旋转，原理就是使用quartz2D来画图片，然后使用ctm变幻来实现旋转。
    注：quartz2D的绘图左边和oc里面的绘图左边不一样，导致绘画出的图片是反转的。所以一上来得使它转正再进行进一步的旋转等
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

#pragma mark - 图片压缩
/**
 *  图片的压缩其实是俩概念，
 1、是 “压” 文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降，
 2、是 “缩” 文件的尺寸变小，也就是像素数减少。长宽尺寸变小，文件体积同样会减小。
 
 这个 UIImageJPEGRepresentation(image, 0.0)，是1的功能。
 这个 [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)] 是2的功能。
 
 所以，这俩你得结合使用来满足需求，不然你一味的用1，导致，图片模糊的不行，但是尺寸还是很大。
 */

/**
 *  调整图片尺寸（宽高）和大小（KB）
 *
 *  @param sourceImage  原始图片
 *  @param maxWidth     新图片最大宽度
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (UIImage *)getImage:(UIImage *)sourceImage maxWidth:(CGFloat)maxWidth maxSize:(CGFloat) maxSize;


// 获取视频的第一帧图片（视频缩略图）
+ (UIImage *)getThumbnailImage:(NSString *)videoURL;

@end
