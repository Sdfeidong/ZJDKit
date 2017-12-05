//
//  BasicViewController.h
//  V6
//
//  Created by aidong on 15/8/13.
//  Copyright (c) 2015年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BackActionBlock)(void);

@interface BasicViewController : UIViewController

@property (nonatomic, strong) UIImageView *statusBarView;
@property (nonatomic, strong) UIImageView *navIV;// 包括statusBar
@property (nonatomic, strong) UIColor *navBackgroundColor;
@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIView *rightV;

@property (nonatomic, strong) NSDictionary *passDict;// VC跳转时传递的信息

@property (nonatomic, copy) BackActionBlock backActionBlock;

- (void)createNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem;

#pragma mark - btnAction
/**
 *  是否是通过nav push过来的
 */
- (BOOL)isFromPush;

- (void)popBack;
- (void)dismissBack;

/**
 *  默认返回上一个controller
 */
- (void)backBtnAction;
/**
 *  pop to 指定的 ViewController
 */
- (void)backPopToViewControllerClass:(Class)aClass;

@end
