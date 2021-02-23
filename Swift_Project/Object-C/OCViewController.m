//
//  OCViewController.m
//  Swift_Project
//
//  Created by 吕征 on 2020/10/4.
//  Copyright © 2020 lvzheng. All rights reserved.
//

#import "OCViewController.h"
#import "RuntimeObject.h"

@interface OCViewController ()
{
    NSArray *_array;
}
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dic;


@property (nonatomic, strong) RuntimeObject *runtimeObjc;

@property (nonatomic, copy) NSString *copStr;
@property (nonatomic, strong) NSString *stongStr;
@property (nonatomic, copy) NSMutableString *mStr;
@end

@implementation OCViewController
@dynamic array;
@synthesize dic = _dic;
- (void)viewDidLoad {
    [super viewDidLoad];
    // 深浅拷贝
//    [self copyAndmutableCopy];
    [self copyAndStrong];
    // 消息转发机制
    [self messageForward];
}

- (void)copyAndStrong {
    /**
        strong 和copy修饰的string，
        如果赋值对象是一个mutableSting，那么stong修饰的string只是强引用了这个mutableString，而copy修饰的string，基于深浅拷贝（mutableString使用copy也是深拷贝，产生一个String），会产生一个新的对象。
        如果赋值对象是一个string，那么copy和strong都是一样的。
     
        不可以用copy修饰mutableString，因为会产生一个不可变的string，mutableString要用Strong修饰
     */
    NSMutableString *str = [NSMutableString stringWithFormat:@"hello"];
//    NSString *str = @"hello";
    self.copStr = str;
    self.stongStr = str;
    NSLog(@"%p -------- %p ------------ %p",str, self.copStr, self.stongStr);
    [str appendString:@" world"];
    NSLog(@"%@ ------ %@ ------ %@",str, self.copStr, self.stongStr);
    
    self.mStr = [NSMutableString stringWithFormat:@"可变字符串"]; // mStr其实被赋值的是一个不可变的string
//    [self.mStr appendString:@"1234"]; // 会崩溃
}

- (void)copyAndmutableCopy {
    // copy修饰NSString
        NSString *str = @"1234";
        NSString *copyStr = [str copy];
        NSMutableString *mStr = [str mutableCopy];
//        mStr = @"123456789";
        NSLog(@"str =  %p, copyStr = %p, mStr = %p",str, copyStr, mStr);
        NSLog(@"str =  %@, copyStr = %@, mStr = %@",str, copyStr, mStr);

        
//        NSMutableString *str = [NSMutableString stringWithString:@"1234"];
//        NSString *copyStr = [str copy];
//        NSMutableString *mStr = [str mutableCopy];
//        [str appendString:@"56789"];
//        copyStr = @"0000";
//        NSLog(@"str =  %p, copyStr = %p, mStr = %p",str, copyStr, mStr);
//        NSLog(@"str =  %@, copyStr = %@, mStr = %@",str, copyStr, mStr);
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[str, @"2"]];
        NSArray *copyArr = [arr copy];
        NSMutableArray *mArr = [arr mutableCopy];
        
        // 容器深拷贝后，容器内的元素并不会发生深拷贝。解决：
        NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:arr copyItems:YES];
        NSMutableString *newStr = arr[0];
        [newStr appendString:@""];
        NSLog(@"arr =  %p, copyArr = %p, mArr = %p",arr, copyArr, mArr);
}

- (void)messageForward {
    self.runtimeObjc = [RuntimeObject new];
    [self.runtimeObjc performSelector:@selector(testMsgFunction)];
}
@end
