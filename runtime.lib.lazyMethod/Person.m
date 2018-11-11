//
//  Person.m
//  runtime.lib.lazyMethod
//
//  Created by admin on 2018/11/11.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person

/// 当这个类接收到一个没有实现的类方法消息时执行
+(BOOL)resolveClassMethod:(SEL)sel
{
    return NO;
}

/// 当这个类接收到一个没有实现的实例方法消息时执行
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%@",NSStringFromSelector(sel));
    /**
     动态的为类添加新方法
     1. clss 类
     2. name SEL方法标号
     3. IMP  方法实现（函数指针）
     4. types 方法类型，可以为任意类型的值[参考](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100)
     */
    class_addMethod([self class], sel, (IMP)hha, "");
    return [super resolveInstanceMethod:sel];
}

/**
定义个函数实现，函数名即为函数指针
oc方法的调用 最终是调用函数，每个函数都会接收到两个隐式参数：
1. 方法的调用者，2. 方法编号SEL 3.传递过过来的参数值
*/
void hha(id objc,SEL cmd,id obj){
    NSLog(@"第一个参数：%@",objc);
    NSLog(@"第二个参数：%@",NSStringFromSelector(cmd));
    NSLog(@"第三个参数:%@",obj);
    NSLog(@"打印日志");
}

@end

