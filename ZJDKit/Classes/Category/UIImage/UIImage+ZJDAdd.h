//
//  UIImage+ZJDAdd.h
//  ReadCloud
//
//  Created by aidong on 2017/10/26.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJDAdd)


/**
 生成二维码
 */
+ (UIImage *)creatCIQRCodeImageWithDataString:(NSString *)dataString
                                         size:(CGSize)size;

/**
 *  根据CIImage生成指定大小高清的UIImage
 */
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

@end
