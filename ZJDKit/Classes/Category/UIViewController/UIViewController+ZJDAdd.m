//
//  UIViewController+ZJDAdd.m
//  ReadCloud
//
//  Created by aidong on 2017/10/11.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "UIViewController+ZJDAdd.h"

@implementation UIViewController (ZJDAdd)

+ (UIViewController *)getTopLevelController:(UIViewController *)currentVC {
    // 上层控制器
    UIViewController *parentVC = currentVC.presentingViewController;
    UIViewController *upperVC;
    while (parentVC) {
        upperVC = parentVC;
        parentVC = parentVC.presentingViewController;
    }
    return upperVC;
}

+ (UIViewController *)getTopRootViewController{
    
    UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
    // 在这里加一个这个样式的循环
    while (topRootViewController.presentedViewController) {
        // 这里固定写法
        topRootViewController = topRootViewController.presentedViewController;
    }
    return topRootViewController;
}

@end
