//
//  UIImageView+toBig.m
//  GKCC
//
//  Created by aidong on 2017/7/12.
//  Copyright © 2017年 aidong. All rights reserved.
//

#import "UIImageView+toBig.h"
#import <objc/runtime.h>
#import "ZJD_Header.h"

@interface UIImageView ()<UIScrollViewDelegate>

@property (nonatomic ,strong)UIImageView *imageV;
//当前是否已经处于动画状态
@property (nonatomic ,assign)BOOL imageViewIsStateAnimation;

@end

@implementation UIImageView (toBig)

- (void)canToBigImageViewWithWindow
{
    self.imageViewIsStateAnimation = NO;
    
    self.userInteractionEnabled = YES;
    __weak typeof(self)weakSelf = self;
    [self setTapActionWithBlock:^{
        [weakSelf ToBig];
    }];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

//点击放大
- (void)ToBig{
    
    if (self.imageViewIsStateAnimation == NO) {
        
        // 获取当前的VC
        UIViewController *vc = [self viewController];

        // 背景View
        UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        backView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [vc.view addSubview:backView];
    
        // 利用 UIScrollView 自带的可缩放属性做图片的捏合效果
        UIScrollView *imageBackView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMScreen_W, kMScreen_H)];
        imageBackView.canCancelContentTouches = YES;
        imageBackView.maximumZoomScale = 2.0; //最大倍率
        imageBackView.minimumZoomScale = 1.0; //最小倍率
        imageBackView.decelerationRate = 1.0; //减速倍率
        imageBackView.delegate = self;
        imageBackView.showsVerticalScrollIndicator = NO;
        imageBackView.showsHorizontalScrollIndicator = NO;
        imageBackView.contentSize = CGSizeMake(kMScreen_W, kMScreen_H);
        //imageBackView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [backView addSubview:imageBackView];

        CGFloat imageW = self.image.size.width;
        CGFloat imageH = self.image.size.height;
        CGFloat scale = imageW / imageH;
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kMScreen_H - kMScreen_W / scale)/2,kMScreen_W, kMScreen_W / scale)];
        self.imageV.image = self.image;
        self.imageV.userInteractionEnabled = YES;
        //self.imageV.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [imageBackView addSubview:self.imageV];
        
        __weak typeof(self)weakSelf = self;
        // 点击背景消失
        [imageBackView setTapActionWithBlock:^{
            [self hideAnimationWithView:backView];
        }];
        // 长按保存
        [self.imageV setLongPressActionWithBlock:^{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认要保存该图片到相册吗" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 保存到相册
                UIImageWriteToSavedPhotosAlbum(weakSelf.imageV.image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            }]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
                
            }];
        }];
    
        [self showAnimationWithView:backView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageV;
}


//让 contentSize 适应图片的变化，不至于变得过大或过小
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    CGSize ViewSize = view.frame.size;
    //CGFloat changeSizeWidth = ViewSize.width - ViewSize.width / scale;//宽度发生变化的值
    CGFloat changeSizeHeight = ViewSize.height - ViewSize.height / scale;//高度发生变化的值
    scrollView.contentSize = CGSizeMake(ViewSize.width, kMScreen_H + changeSizeHeight);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%f",scrollView.contentOffset.y);
}


- (void)showAnimationWithView:(UIView *)animationView{
    animationView.alpha = 0;
    CGFloat d1 = 0.2, d2 = 0.15;
    animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:d1 animations:^{
        animationView.alpha = 1;
        animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:d2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.alpha = 1;
            animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished2) {
            self.imageViewIsStateAnimation = YES;
        }];
    }];
}

- (void)hideAnimationWithView:(UIView *)animationView{
    
    CGFloat d1 = 0.2, d2 = 0.1;
    [UIView animateWithDuration:d2 animations:^{
        animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:d1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.alpha = 0;
            animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        } completion:^(BOOL finished2){
            //动画完成删除View
            [animationView removeFromSuperview];
            //更新状态以备下次点击放大
            self.imageViewIsStateAnimation = NO;
        }];
    }];
}

#pragma mark-----保存图片指定回调方法
- (void)image:(UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


#pragma mark------setter and getter
- (UIImageView *)imageV
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageV:(UIImageView *)imageV
{
    objc_setAssociatedObject(self, @selector(imageV) ,imageV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)imageViewIsStateAnimation
{
    return [objc_getAssociatedObject(self, _cmd ) boolValue];
}

- (void)setImageViewIsStateAnimation:(BOOL)imageViewIsStateAnimation
{
    objc_setAssociatedObject(self, @selector(imageViewIsStateAnimation),@(imageViewIsStateAnimation), OBJC_ASSOCIATION_RETAIN);
}
@end
