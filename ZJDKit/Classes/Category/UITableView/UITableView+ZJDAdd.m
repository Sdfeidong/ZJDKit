//
//  UITableView+ZJDAdd.m
//  YYKSearch
//
//  Created by yyk100 on 16/9/8.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "UITableView+ZJDAdd.h"

@implementation UITableView (ZJDAdd)

#pragma mark - 隐藏掉多余的cell分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
