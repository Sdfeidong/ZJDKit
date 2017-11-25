//
//  UIScrollView+ZJDRefresh.m
//  GKCC
//
//  Created by aidong on 17/6/30.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "UIScrollView+ZJDRefresh.h"
#import "MJRefresh.h"

@implementation UIScrollView (ZJDRefresh)


- (void)setRefreshWithHeaderBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock{
    
    
    if (headerBlock) {
        
        MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (headerBlock) {
                headerBlock();
            }
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.mj_header = header;
    }
    if (footerBlock) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }];
        [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden = YES;
        self.mj_footer = footer;
    }
    
}

- (void)headerBeginRefreshing
{
    [self.mj_header beginRefreshing];
}

- (void)headerEndRefreshing
{
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing
{
    [self.mj_footer endRefreshing];
}

- (void)footerNoMoreData
{
    [self.mj_footer setState:MJRefreshStateNoMoreData];
}

- (void)hideFooterRefresh{
    self.mj_footer.hidden = YES;
}


- (void)hideHeaderRefresh{
    self.mj_header.hidden = YES;
}

@end
