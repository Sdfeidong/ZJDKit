//
//  UIScrollView+ZJDRefresh.h
//  GKCC
//
//  Created by aidong on 17/6/30.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZJDRefresh)

- (void)setRefreshWithHeaderBlock:(void(^)(void))headerBlock
                      footerBlock:(void(^)(void))footerBlock;


- (void)headerBeginRefreshing;
- (void)headerEndRefreshing;
- (void)footerEndRefreshing;
- (void)footerNoMoreData;

- (void)hideHeaderRefresh;
- (void)hideFooterRefresh;

@end
