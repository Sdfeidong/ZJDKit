//
//  UIImageView+ZJDAdd.h
//  ReadCloud
//
//  Created by aidong on 2017/10/12.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZJDAdd)

/**
 UIImageView设置image，可以是UIImage，url，图片名称
 
 @param object UIImage、图片url、图片名称
 */
- (void)zjd_setImageWithObject:(id)object ;

/**
 UIImageView设置image，可以是UIImage，url，图片名称

 @param object UIImage、图片url、图片名称
 @param placeholderImage 默认图片
 */
- (void)zjd_setImageWithObject:(id)object placeholderImage:(UIImage *)placeholderImage ;

@end
