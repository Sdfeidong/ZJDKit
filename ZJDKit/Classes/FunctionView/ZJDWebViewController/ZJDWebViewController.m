//
//  ZJDWebViewController.m
//  GKCC
//
//  Created by aidong on 2017/9/16.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "ZJDWebViewController.h"
#import <WebKit/WebKit.h>

#import "ZJDKit.h"

@interface ZJDWebViewController ()<WKNavigationDelegate> {
    
    // 加载详情的web
    WKWebView *_webView;
    // 加载web的菊花
    UIActivityIndicatorView *_webActivityView;
}

@end

@implementation ZJDWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 加载自定义导航
    [self layoutNav];
    // 其它view
    [self layoutOtherView];
    // ...
    
    // 初始化数据
    [self initData];
    // 添加通知
    [self addNotification];
}
#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}
// 自定义导航
- (void)layoutNav {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavWithTitle:self.navTitle createMenuItem:^UIView *(int nIndex) {
        
        if (nIndex == 0){
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(0, (self.navView.height - KNaVButtonHeight)/2, kNavButtonWidth, KNaVButtonHeight)];
            UIImage *image = [UIImage imageNamed:@"返回白"];
            [btn setImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
            return btn;
        }
        
        return nil;
    }];
    
    // 放在此处以免 block造成的异步。
    self.navIV.backgroundColor = self.navBackgroundColor;
    // 默认不透明
    self.navIV.alpha = 1;
}
// 其它view
- (void)layoutOtherView {
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kMScreen_W, kMScreen_H - kNavBarHeight)];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = Color_TableBG;
    [self.view addSubview:_webView];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    _webActivityView = [[UIActivityIndicatorView alloc]init];
    _webActivityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _webActivityView.centerX = _webView.centerX;
    _webActivityView.centerY = _webView.height/2;
    [_webView addSubview:_webActivityView];
    [_webActivityView startAnimating];
}

- (NSString *)urlStr {
    if (_urlStr == nil) {
        _urlStr = [NSString string];
    }
    return _urlStr;
}

#pragma mark - 初始化数据
- (void)initData {
    
}

#pragma mark - UIWebViewDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [_webActivityView stopAnimating];
    
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:15px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>"
                       "</body>"
                       "</html>"];
    
    [webView evaluateJavaScript:htmls completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [_webActivityView stopAnimating];
}

#pragma mark - BtnAction

#pragma mark - 跳转方法
+ (void)jumpWebviewWith:(NSString *)url
                superVC:(UIViewController *)superVC
               navColor:(UIColor *)navColor
               navTitle:(NSString *)navTitle
             backAction:(BackActionBlock)backAction {
    
    // 广告在webview中打开
    ZJDWebViewController *vc = [[ZJDWebViewController alloc] init];
    vc.urlStr = url;
    vc.navBackgroundColor = navColor;
    vc.navTitle = navTitle;
    [superVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Notification
- (void)addNotification {
    
    // [NNC_DC addObserver:self selector:@selector(<#selector#>) name:<#(nullable NSNotificationName)#> object:nil];
}
/**
 - (void)nameNoti:(NSNotification *)noti {
 
 NSDictionary *dictObject = [noti object];
 NSDictionary *dictInfo = [noti userInfo];
 }
 */
#pragma mark - Self
- (void)dealloc {
    
    // 移除self的所有通知
    // [NNC_DC removeObserver:self];
    // ...
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

