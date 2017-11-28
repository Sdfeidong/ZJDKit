//
//  ZJDWebViewController.h
//  GKCC
//
//  Created by aidong on 2017/9/16.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "BasicViewController.h"

/**
 类型
 */
typedef NS_ENUM(NSInteger, ZJDWebViewType) {
    /**
     *  广告
     */
    ZJDWebViewTypeAas = 0,
    /**
     *  普通网址跳转
     */
    ZJDWebViewTypeHttp = 1,
};


@interface ZJDWebViewController : BasicViewController

@property (nonatomic , copy) NSString *urlStr;

@property (nonatomic , assign) ZJDWebViewType viewType;

#pragma mark - 跳转方法
+ (void)jumpWebviewWith:(NSString *)url
                superVC:(UIViewController *)superVC
               viewType:(ZJDWebViewType)viewType
             backAction:(BackActionBlock)backAction;

@end

