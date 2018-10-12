//
//  ZJDWebViewController.h
//  GKCC
//
//  Created by aidong on 2017/9/16.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "BasicViewController.h"

@interface ZJDWebViewController : BasicViewController

@property (nonatomic , copy) NSString *urlStr;

#pragma mark - 跳转方法
+ (void)jumpWebviewWith:(NSString *)url
                superVC:(UIViewController *)superVC
               navColor:(UIColor *)navColor
               navTitle:(NSString *)navTitle
             backAction:(BackActionBlock)backAction;

@end

