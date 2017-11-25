//
//  ZJDLaunchViewController.m
//  GKCC
//
//  Created by aidong on 2017/9/16.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "ZJDLaunchViewController.h"

@interface ZJDLaunchViewController ()

@end

@implementation ZJDLaunchViewController

-(void)viewWillAppear:(BOOL)animated{
    if(self.launchView.timer && (self.launchView.timeInteger > 0) && self.launchView.isClick) {
        dispatch_resume(self.launchView.timer);
    }
    self.launchView.isClick = NO;
}
-(void)viewWillDisappear:(BOOL)animated {
    if(self.launchView.timer && (self.launchView.timeInteger > 0) && self.launchView.isClick) {
        dispatch_suspend(self.launchView.timer);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

+ (ZJDLaunchViewController *)setLaunchRootViewController {
    ZJDLaunchViewController *WZXlaunchVC = [[ZJDLaunchViewController alloc] init];
    [[UIApplication sharedApplication].delegate window].rootViewController = WZXlaunchVC;
    return WZXlaunchVC;
}

@end

