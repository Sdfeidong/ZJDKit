//
//  UITableViewCell+ZJDAdd.m
//  YYKSearch
//
//  Created by aidong on 16/12/8.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "UITableViewCell+ZJDAdd.h"

@implementation UITableViewCell (ZJDAdd)

/**
 最后一行cell 分割线顶头
 */
- (void)setLastCellSeperatorToLeft {
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [self setPreservesSuperviewLayoutMargins:NO];
    }
}

@end
