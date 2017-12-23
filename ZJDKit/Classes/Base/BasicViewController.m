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
#import "UIViewController+ZJDAdd.h"

@interface BasicViewController ()<UIGestureRecognizerDelegate>{
    
}

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //开启iOS7及以上的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, (_navView.height - 40)/2, kMScreen_W - 44 * 2, 40)];
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
- (BOOL)isFromPush {
    
    /** 判断方法一
    // 当前vc
    // [self.navigationController.viewControllers.firstObject isEqual:self]
    // [self.navigationController.viewControllers indexOfObject:self] == 0
    if (self.navigationController.topViewController == self) {
        return YES;
    }
    return NO;
     */
    
    /** 判断方法二
    // 如果只是单个vc present的话判断没问题
    // 但如果是先present nav 再nav push 就会判断失误
    if (self.presentingViewController) {
        return YES;
    }
    return NO;
    */
    
    // 在pop的栈里肯定是push
    for (BasicViewController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:[self class]]) { //这里判断是否为你想要跳转的页面
            return YES;
        }
    }
    return NO;
}
- (void)backBtnAction{
    
    // 返回前的操作
    if (self.backActionBlock) {
        self.backActionBlock();
    }
    
    // 返回
    if ([self isFromPush]) {
        [self popBack];
    }
    else {
        [self dismissBack];
    }
}

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismissBack {
    UIViewController *vc = [UIViewController getTopLevelController:self];
    [vc dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)backPopToViewControllerClass:(Class)aClass {
    
    for (BasicViewController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:aClass]) { //这里判断是否为你想要跳转的页面
            
            if (self.backActionBlock) {
                self.backActionBlock();
            }
            
            // 跳转
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

// UIGestureRecognizerDelegate 重写侧滑协议
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.navigationController.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}
// 手势返回响应
- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        if (self.backActionBlock) {
            self.backActionBlock();
        }
        NSLog(@"parent :%@",parent);
        NSLog(@"~~~%@ 控制器 滑动返回成功~~~",[self class]);
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
