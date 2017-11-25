//
//  BasicViewController.m
//  V6
//
//  Created by aidong on 15/8/13.
//  Copyright (c) 2015年 aidong. All rights reserved.
//

#import "BasicViewController.h"
#import "YYKit.h"
#import "ZJD_Macros.h"

@interface BasicViewController (){
    
}

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

}
#pragma mark - viewWillAppear:
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];

}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//}

- (void)createNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem
{
    _navIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMScreen_W, kNavBarHeight)];
    _navIV.tag = 98;
    [self.view addSubview:_navIV];
    _navIV.backgroundColor = [UIColor clearColor];
    _navIV.userInteractionEnabled = YES;
    _navIV.alpha = 1; // 默认导航不透明
    
    _statusBarView.frame = CGRectMake(_statusBarView.frame.origin.x, _statusBarView.frame.origin.y, _statusBarView.frame.size.width, kStatusBarHeight);
    _statusBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_statusBarView];
    
    /* { 导航条 } */
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, kStatusBarHeight, kMScreen_W, kTopBarHeight)];
    ((UIImageView *)_navView).backgroundColor = [UIColor clearColor];
    [_navIV addSubview:_navView];
    _navView.userInteractionEnabled = YES;
    
    // 默认tag 99;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, (_navView.height - 40)/2, _navView.width, 40)];
    titleLabel.tag = 99;
    [titleLabel setText:szTitle];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [_navView addSubview:titleLabel];
    
    UIView *item1 = menuItem(0);
    if (item1 != nil){
        [_navView addSubview:item1];
    }
    
    UIView *item2 = menuItem(1);
    if (item2 != nil){
        [_navView addSubview:item2];
    }
    
    UIView *item3 = menuItem(2);
    if (item3 != nil) {
        [_navView addSubview:item3];
    }
    
    UIView *item4 = menuItem(3);
    if (item4 != nil) {
        [_navView addSubview:item4];
    }
    
    [self.view bringSubviewToFront:self.navIV];
}

#pragma mark - btnAction
- (void)backBtnAction{

    if (self.backActionBlock) {
        self.backActionBlock();
    }
    
    if (self.beingFromPushViewController) {
    
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)backPopToViewControllerClass:(Class)aClass {
    
    for (BasicViewController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:aClass]) { //这里判断是否为你想要跳转的页面
            // 跳转
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

#pragma mark - Self
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

//支持旋转
-(BOOL)shouldAutorotate{
    return YES;
}

//支持的方向 因为界面我们只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
