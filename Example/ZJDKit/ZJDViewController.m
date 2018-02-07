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

#import "ZJDTestViewController.h"

@interface ZJDViewController ()

@end

@implementation ZJDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self zjdTest];
}
// 各种方法测试
- (void)zjdTest {
    
    NSLog(@"哈哈、测试啦");
    NSLog(@"%@",[NSDate getCurrentDateTimestamp13]);
    NSLog(@"%@",[ZJDKeyChainDataManager readUUID]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
