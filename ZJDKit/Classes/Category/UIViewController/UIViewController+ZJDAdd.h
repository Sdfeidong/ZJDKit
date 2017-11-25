//
//  UIViewController+ZJDAdd.h
//  ReadCloud
//
//  Created by aidong on 2017/10/11.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZJDAdd)

/**
 获取当前的VC的最顶层控制器 nav上的第一层控制器
 
 @param currentVC 当前控制器
 @return VC
 */
+ (UIViewController *)getTopLevelController:(UIViewController *)currentVC;

/**
 获取当前的控制器 解决“whose view is not in the window hierarchy”
 
 @return VC
 */
+ (UIViewController *)getTopRootViewController;
@end
