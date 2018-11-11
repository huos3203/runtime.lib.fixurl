//
//  NSKVONotifing_Person.m
//  runtime.lib.reactiveKVO
//
//  Created by admin on 2018/11/11.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "NSKVONotifing_Person.h"
/**
 KVO原生的响应式编程
 kvo键值观察底层的实现原理:使用runtime，
 1. 动态的为p对象创建子类：NSKVONotifing_Person
 2. 并重写监听属性的set方法
 3. 改变p的对象类型，改为子类的类型即NSKVONotifing_Person类型
 知道KVO原生的原理，尝试使用runtime编写一个自己的KVO
 */
@implementation NSKVONotifing_Person

-(void)setName:(NSString *)name
{
    [self willChangeValueForKey:@"name"];
    [super setName:name];
    [self didChangeValueForKey:@"name"];
}
@end
