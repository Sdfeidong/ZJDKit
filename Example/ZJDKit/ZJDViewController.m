//
//  ZJDViewController.m
//  ZJDKit
//
//  Created by Sdfeidong on 11/24/2017.
//  Copyright (c) 2017 Sdfeidong. All rights reserved.
//

#import "ZJDViewController.h"

#import "ZJD_Macros.h"
#import "ZJDWebViewController.h"

@interface ZJDViewController ()

@end

@implementation ZJDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // ...btn
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 60)];
    btn.backgroundColor = RANDCOLOR;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSLog(@"%@",[NSDate getCurrentDateTimestamp13]);
}

- (void)btnAction {
    
    [ZJDWebViewController jumpWebviewWith:@"http://live.polyv.cn/watch/145836" superVC:self navColor:RANDCOLOR navTitle:@"直播间" backAction:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
