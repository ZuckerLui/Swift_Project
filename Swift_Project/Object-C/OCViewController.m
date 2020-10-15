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
@property (nonatomic, copy) NSString *str;

@property (nonatomic, strong) RuntimeObject *runtimeObjc;
@end

@implementation OCViewController
@dynamic array;
@synthesize dic = _dic;
- (void)viewDidLoad {
    [super viewDidLoad];
    // 深浅拷贝
    [self copyAndmutableCopy];
    // 消息转发机制
    [self messageForward];

}


- (void)copyAndmutableCopy {
    //    NSString *str = [NSMutableString stringWithString:@"1234"];
    //    NSString *copyStr = [str copy];
    //    NSMutableString *mStr = [str mutableCopy];
    //    mStr = @"123456789";
    //    NSLog(@"str =  %p, copyStr = %p, mStr = %p",&str, &copyStr, &mStr);
    //    NSLog(@"str =  %@, copyStr = %@, mStr = %@",str, copyStr, mStr);

        
        NSMutableString *str = [NSMutableString stringWithString:@"1234"];
        NSString *copyStr = [str copy];
        NSMutableString *mStr = [str mutableCopy];
        [str appendString:@"56789"];
        copyStr = @"0000";
        NSLog(@"str =  %p, copyStr = %p, mStr = %p",&str, &copyStr, &mStr);
        NSLog(@"str =  %@, copyStr = %@, mStr = %@",str, copyStr, mStr);
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:@[str, @"2"]];
        NSArray *copyArr = [arr copy];
        NSMutableArray *mArr = [arr mutableCopy];
        
        // 容器深拷贝后，容器内的元素并不会发生深拷贝。解决：
        NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:arr copyItems:YES];
        NSMutableString *newStr = arr[0];
        [newStr appendString:@""];
        NSLog(@"arr =  %p, copyArr = %p, mArr = %p",&arr, &copyArr, mArr);
}

- (void)messageForward {
    self.runtimeObjc = [RuntimeObject new];
    [self.runtimeObjc performSelector:@selector(testMsgFunction)];
}
@end
