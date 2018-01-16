//
//  UIButton+CountDown.m
//  YYK
//
//  Created by yyk100 on 16/3/9.
//  Copyright © 2016年 yyk100. All rights reserved.
//

#import "UIButton+CountDown.h"
#import "ZJDKit.h"

@implementation  UIButton (CountDown)

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{
    
    [self setTitleColor:Color_White forState:UIControlStateNormal];
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                
//                NSLog(@"提示框弹出");
//                UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"验证超时" message: nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
                
//                [NSTimer scheduledTimerWithTimeInterval:0.5f
//                                                 target:self
//                                               selector:@selector(timerFireMethod:)
//                                               userInfo:promptAlert
//                                                repeats:NO];
        //        [promptAlert show];
                /*提示文字版3秒后自动退出
                 UILabel  * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
                 label1.text = @"我是提示";
                 [self addSubview:label1];
                 
                 [UIView beginAnimations:nil context:nil];
                 [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                 [UIView setAnimationDuration:3.0];
                 [UIView setAnimationDelegate:self];
                 label1.alpha =0.0;
                 [UIView commitAnimations];
                 */
            });
            
        }else{
            
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@ (%@S)",subTitle,timeStr] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

//-(void)timerFireMethod:(UIButton *)btn{
//    
//}


@end
