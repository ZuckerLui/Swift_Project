//
//  UIControl+Category.m
//  Swift_Project
//
//  Created by 吕征 on 2020/10/28.
//  Copyright © 2020 lvzheng. All rights reserved.
//

#import "UIControl+Category.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

@implementation UIControl (Category)
+(void)load {
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(swizzled_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}

/**
    这里不是递归，因为系统调用的sendAction:to:forEvent:会调用到swizzlde_sendAction:to:forEvent:，也就是调用下面这个方法
    sendAction:to:forEvent:的SEL指针指向了swizzlde_sendAction:to:forEvent:的IMP，swizzlde_sendAction:to:forEvent:的SEL指向的是sendAction:to:forEvent:的IMP
    我们经过判断后，认为可以执行点击事件，调用swizzlde_sendAction:to:forEvent:，实际上是调用了sendAction:to:forEvent:，因此不会递归。
 */
-(void)swizzled_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.ignoreEvent) {
        NSLog(@"点击过快事件被驳回！");
        return;
    }
    
    if (self.acceptEventInterval > 0) {
        self.ignoreEvent = YES;
        [self performSelector:@selector(setIgnoreEventWithNo) withObject:nil afterDelay:self.acceptEventInterval];
    }
    [self swizzled_sendAction:action to:target forEvent:event];
}

-(void)setIgnoreEventWithNo{
    self.ignoreEvent=NO;
}


- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_ASSIGN);
}

-(NSTimeInterval)acceptEventInterval {
    return [objc_getAssociatedObject(self,UIControl_acceptEventInterval) doubleValue];
}

-(void)setIgnoreEvent:(BOOL)ignoreEvent{
    objc_setAssociatedObject(self,UIControl_ignoreEvent, @(ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)ignoreEvent{
    return [objc_getAssociatedObject(self,UIControl_ignoreEvent) boolValue];
}
@end
