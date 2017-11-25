//
//  ZJDWebViewController.m
//  GKCC
//
//  Created by aidong on 2017/9/16.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "ZJDWebViewController.h"
#import <WebKit/WKWebView.h>
#import "ZJD_Header.h"
@interface ZJDWebViewController ()<UIWebViewDelegate> {
    
    // 加载详情的web
    UIWebView *_webView;
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
    NSString *navTitle = @"广告";
    [self createNavWithTitle:navTitle createMenuItem:^UIView *(int nIndex) {
        
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
    self.navIV.backgroundColor = [UIColor appNavigationBarColor];
    // 默认不透明
    self.navIV.alpha = 1;
}
// 其它view
- (void)layoutOtherView {
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kMScreen_W, kMScreen_H - kNavBarHeight)];
    _webView.delegate = self;
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
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_webActivityView stopAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
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
    [webView stringByEvaluatingJavaScriptFromString:htmls];
    
    /**
     //修改服务器页面的meta的值
     NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", mywebView.frame.size.width-300];
     [webView stringByEvaluatingJavaScriptFromString:meta];
     */
}

#pragma mark - BtnAction

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

