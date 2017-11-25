//
//  ZJD_CountTime.m
//  YYKSearch
//
//  Created by yyk100 on 16/9/30.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "ZJD_CountTime.h"

NSString * const NNC_CountTimeNotification = @"NNC_CountTimeNotification";


@implementation ZJD_CountTime {
    
    dispatch_source_t _timer;
    
    BOOL _isStart;
    BOOL _isPause;
    BOOL _isReuse;
    BOOL _isCreat;
}

#pragma mark - 单例
// 第一步：静态全局变量，始终指向实例化出的对象。
static ZJD_CountTime *sharedCountTime = nil;

// 第二步：外界初始化得到单例类对象的唯一借口，这个类方法返回的就是sharedCountTime，即类的一个对象，如果sharedCountTime为空，则实例化一个对象，如果不为空，则直接返回。这样保证了实例的唯一。
+ (ZJD_CountTime *)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCountTime = [[super allocWithZone:nil]init];
    });
    
    return sharedCountTime;
}

// 第三步：重写allocWithZone方法
+(id)allocWithZone:(NSZone *)zone
{
    return [ZJD_CountTime shared];
}

// 第四步：这两个方法是为了防止外界拷贝造成多个实例，保证实例的唯一性。
-(id)copy
{
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

// 可写可不写 一般放如初始化数据
- (id)init
{
    if (sharedCountTime){
        return sharedCountTime;
    }
    
    self = [super init];
    return self;
}

#pragma mark - Action
- (void)startCount {
    
    _isStart = YES;
    _isPause = NO;
    _isReuse = NO;
    self.timeCount = 0;
    [self startToCountTime];
}

- (void)pauseCount {
    
    if (_isStart) {
        _isReuse = YES;
        _isPause = YES;
        dispatch_suspend(_timer);
    }
}

- (void)reuseCount {
    
    if (_isStart) {
        // 计时过暂停又开始
        _isStart = YES;
        _isPause = NO;
        _isReuse = YES;
        [self startToCountTime];
        
    } else {
        
        // 直接开始计时
        [self startCount];
    }
    
}

- (void)endCount {
    
    if (_isCreat){
        
        if (_isPause == YES) {
            dispatch_resume(_timer);
            
        }
        
        dispatch_source_cancel(_timer);
        _isStart = NO;
        _isCreat = NO;
    }
}

- (void)startToCountTime {
    
    // 表示从0开始计
    if (_isReuse == NO) {
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    }
    
    // 已计时
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 监听这个通知，可实时获取 _timeCount
            NSDictionary *dict = @{@"timeCount":[NSString stringWithFormat:@"%d",_timeCount]};
            [[NSNotificationCenter defaultCenter] postNotificationName:NNC_CountTimeNotification object:dict];
            
        });
        _timeCount ++;
    });
    
    dispatch_resume(_timer);
}

+ (NSString *)timerString:(int)countNum {
    
    int hours = countNum / 3600;
    int minutes = (countNum - (3600*hours)) / 60;
    int seconds = countNum%60;
    NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours,minutes,seconds];
    // NSLog(@"%@",strTime);
    
    return strTime;
}

@end
