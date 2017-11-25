//
//  ZJD_StarEvaluateView.m
//  KFXX
//
//  Created by aidong on 16/3/19.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "ZJD_StarEvaluateView.h"
#import "UIView+Extension.h"
#import "ZJD_Header.h"

@interface ZJD_StarEvaluateView (){
    
    NSInteger _totalStars;
}

@end

@implementation ZJD_StarEvaluateView

// 默认有五个星星
- (instancetype)initWithFrame:(CGRect)frame
                   totalStars:(NSInteger)totalStars
                    starIndex:(NSInteger)index
                    starWidth:(CGFloat)starWidth
                        space:(CGFloat)space
                 defaultImage:(UIImage *)defaultImage
                   lightImage:(UIImage *)lightImage
                     isCanTap:(BOOL)isCanTap{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if (totalStars <= 0) {
            _totalStars = 5;
        } else {
            _totalStars = totalStars;
        }
        
        if (defaultImage) {
            self.defaultImage = defaultImage;
        } else {
            self.defaultImage = [UIImage imageNamed:@"灰星星"];
        }
        
        if (lightImage) {
            self.lightImage = lightImage;
        } else {
            self.lightImage = [UIImage imageNamed:@"黄星星"];
        }
        
        for (NSInteger j = 0; j < _totalStars; j++) {
            
            
            UIImageView *tapHeadIV = [[UIImageView alloc] initWithFrame:CGRectMake(j* (starWidth + space), 0, starWidth, self.bounds.size.height)];
            tapHeadIV.backgroundColor = [UIColor clearColor];
            tapHeadIV.tag = j + 1;
            tapHeadIV.contentMode = UIViewContentModeScaleAspectFit;
            tapHeadIV.userInteractionEnabled = YES;
            
            if (j < index) {
                [tapHeadIV setImage:self.lightImage];
            } else {
                [tapHeadIV setImage:self.defaultImage];
            }
            
            // 是否可点击
            __weak typeof(tapHeadIV)weakTapHeadIV = tapHeadIV;
            if (isCanTap) {
                [tapHeadIV setTapActionWithBlock:^{
                    [self starTapImage:weakTapHeadIV];
                }];
            }
            
            [self addSubview:tapHeadIV];
            
            // self.width
            self.width = (starWidth + space) * _totalStars;
        }
    }
    return self;
}

- (void)starTapImage:(UIImageView *)tapIV{
    
    for (NSInteger i = 1; i <= _totalStars; i++) {
        UIImageView *starBtn = (UIImageView *)[self viewWithTag:i];
        if (i <= tapIV.tag) {
            [starBtn setImage:self.lightImage];
        } else {
            [starBtn setImage:self.defaultImage];
        }
    }
    
    if (self.starEvaluateBlock) {
        self.starEvaluateBlock(self,tapIV.tag);
    }
}


- (void)starTapBtn:(UIButton *)btn{
    
    for (NSInteger i = 1; i <= _totalStars; i++) {
        UIButton *starBtn = (UIButton *)[self viewWithTag:i];
        if (i <= btn.tag) {
            [starBtn setImage:self.lightImage forState:UIControlStateNormal];
        } else {
            [starBtn setImage:self.defaultImage forState:UIControlStateNormal];
        }
    }
    
    if (self.starEvaluateBlock) {
        self.starEvaluateBlock(self,btn.tag);
    }
}

@end

