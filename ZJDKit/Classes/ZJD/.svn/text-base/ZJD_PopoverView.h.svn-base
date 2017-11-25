//
//  ZJD_PopoverView.h
//  DKT4.0
//
//  Created by aidong on 15/7/20.
//  Copyright (c) 2015年 aidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJD_PopoverView : UIView

- (instancetype)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
- (void)show;
- (void)dismiss;
- (void)dismiss:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@end
