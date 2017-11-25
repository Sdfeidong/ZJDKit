//
//  ZJDLaunchViewController.h
//  GKCC
//
//  Created by aidong on 2017/9/16.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJDLaunchAd.h"

@interface ZJDLaunchViewController : UIViewController

@property (nonatomic, strong)  ZJDLaunchAd *launchView;

+ (ZJDLaunchViewController *)setLaunchRootViewController;

@end
