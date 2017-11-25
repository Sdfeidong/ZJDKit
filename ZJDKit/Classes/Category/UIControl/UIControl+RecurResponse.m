//
//  UIControl+RecurResponse.m
//  TestButton
//
//  Created by yyk100 on 16/9/5.
//  Copyright © 2016年 aidong. All rights reserved.
//

#import "UIControl+RecurResponse.h"

#import <objc/runtime.h>


@implementation UIControl (RecurResponse)

+ (void)load {
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__zjd_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}
- (void)__zjd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.zjd_ignoreEvent) return;
    if (self.zjd_acceptEventInterval > 0) {
        self.zjd_ignoreEvent = YES;
        [self performSelector:@selector(setIgnoreEvent) withObject:@(NO) afterDelay:self.zjd_acceptEventInterval];
    }
    [self __zjd_sendAction:action to:target forEvent:event];
}
- (void)setIgnoreEvent {
    self.zjd_ignoreEvent = NO;
}
// zjd_acceptEventInterval
- (NSTimeInterval)zjd_acceptEventInterval {
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
- (void)setZjd_acceptEventInterval:(NSTimeInterval)zjd_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(zjd_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
// zjd_ignoreEvent
- (BOOL)zjd_ignoreEvent {
    return [objc_getAssociatedObject(self, BandNameKey) boolValue];
}
- (void)setZjd_ignoreEvent:(BOOL)zjd_ignoreEvent {
    objc_setAssociatedObject(self, BandNameKey, [NSNumber numberWithBool:zjd_ignoreEvent], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
