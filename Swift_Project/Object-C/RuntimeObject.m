//
//  RuntimeObject.m
//  Swift_Project
//
//  Created by 吕征 on 2020/10/15.
//  Copyright © 2020 lvzheng. All rights reserved.
//

#import "RuntimeObject.h"
#import <objc/runtime.h>
#import "BackupRespondObject.h"

@implementation RuntimeObject
/**
 消息转发机制：1、方法解析处理阶段 2、快速转发阶段 3、常规转发阶段
 在三个步骤的每一步，消息接受者都还有机会去处理消息。同时，越往后面处理代价越高，最好的情况是在第一步就处理消息，
 这样runtime会在处理完后缓存结果，下回再发送同样消息的时候，可以提高处理效率。第二步转移消息的接受者也比进入转发流程的代价要小，
 如果到最后一步forwardInvocation的话，就需要处理完整的NSInvocation对象了。
*/

/**
    Method resolution 方法解析处理阶段：调用了实力方法，首先会进行+(BOOL)resolveInstanceMethod:(SEL)sel判断；调用了类方法会进行 +(BOOL)resolveClassMethod:(SEL)sel判断
    如果能接受消息返回yes，不能返回no并进入第二步（快速转发阶段）
 */
//+(BOOL)resolveInstanceMethod:(SEL)sel{
//    //判断是否为外部调用的方法
//        if ([NSStringFromSelector(sel) isEqualToString:@"testMsgFunction"]) {
//            // 第一个参数：给哪个类添加方法
//            // 第二个参数：添加方法的方法编号
//            // 第三个参数：添加方法的函数实现（函数地址）
//            // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
//            class_addMethod([self class], sel, (IMP)testMsg_1, "v@:");
//            return YES;
//        }
//        return [super resolveInstanceMethod:sel];
//}
//
//void testMsg_1(id self, SEL sel)
//{
//    NSLog(@"来到了runtime添加的方法");
//}


/**
    Fast forwarding 快速转发阶段：一个对象内部可能还有其他可能响应的对象，所以下面方法的作用是转发SEL到其他可以响应该方法的对象。
 */
//-(id)forwardingTargetForSelector:(SEL)aSelector{
//  if ([NSStringFromSelector(aSelector) isEqualToString:@"testMsgFunction"]) {
//        NSLog(@"通过快速转发调用后援类的方法");
//        return [BackupRespondObject new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}


/**
    Normal forwarding 常规转发阶段:本质上跟第二步是一样的都是切换接受消息的对象，
    但是第三步切换响应目标更复杂一些，第二步里面只需返回一个可以响应的对象就可以了，第三步还需要手动将响应方法切换给备用响应对象。
 */

// 此方法返回SEL方法的签名，返回的签名是根据方法的参数来封装的。
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    //如果返回为nil则进行手动创建签名
   if ([super methodSignatureForSelector:aSelector] == nil) {
        NSMethodSignature * sign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        return sign;
    }
    return [super methodSignatureForSelector:aSelector];
}

// 上面的方法如果返回有签名 则进入消息转发最后一步
// NSInvocation对象包含了这个方法的所有信息，包括：方法名、所有参数、返回值类型
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    //创建备用对象
    BackupRespondObject * backUp = [BackupRespondObject new];
    SEL sel = anInvocation.selector;
    //判断备用对象是否可以响应传递进来等待响应的SEL
    if ([backUp respondsToSelector:sel]) {
        NSLog(@"通过常规转发调用后援类的方法");
        [anInvocation invokeWithTarget:backUp];
    }else{
       // 如果备用对象不能响应 则抛出异常
        [self doesNotRecognizeSelector:sel];
    }
}
@end
