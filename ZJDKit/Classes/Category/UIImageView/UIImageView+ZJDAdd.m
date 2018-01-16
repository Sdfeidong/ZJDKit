//
//  UIImageView+ZJDAdd.m
//  ReadCloud
//
//  Created by aidong on 2017/10/12.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "UIImageView+ZJDAdd.h"
#import "ZJDKit.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (ZJDAdd)

- (void)zjd_setImageWithObject:(id)object {
    
    if ([object isKindOfClass:[UIImage class]]) {
        // UIImage
        self.image = (UIImage *)object;
    } else if ([object isKindOfClass:[NSString class]]) {
        // NSString
        NSString *imageName = [NSString stringWithFormat:@"%@",object];
        if ([imageName containsString:@"http"]) {
            // 图片url地址
            [self sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
        } else {
            // 本地图片名称
            self.image = [UIImage imageNamed:imageName];
        }
    }
}

- (void)zjd_setImageWithObject:(id)object placeholderImage:(UIImage *)placeholderImage {
    
    if ([object isKindOfClass:[UIImage class]]) {
        // UIImage
        self.image = (UIImage *)object;
    } else if ([object isKindOfClass:[NSString class]]) {
        // NSString
        NSString *imageName = [NSString stringWithFormat:@"%@",object];
        if ([ToolClass isNullOrNilWithObject:imageName]) {
            
            self.image = placeholderImage;
            
        } else {
            
            if ([imageName containsString:@"http"]) {
                // 图片url地址
                [self sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:placeholderImage];
            } else {
                // 本地图片名称
                self.image = [UIImage imageNamed:imageName];
            }
        }
        
    } else {
        // 设置默认图片
        self.image = placeholderImage;
    }
}

@end
