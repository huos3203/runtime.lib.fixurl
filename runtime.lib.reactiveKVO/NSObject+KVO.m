//
//  NSObject+KVO.m
//  runtime.lib.reactiveKVO
//
//  Created by admin on 2018/11/11.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>
/**
 自定义KVO
 
 ARKt  CoreML
 
 1. 为调用者动态创建一个子类对象
 2. 改变方法调用者的类型
 3. 重写属性的set方法：setName
 oc中没有重载，只有重写
 重载仅存在真正的面向对象的编程：即方法名称相同，参数不同的
 
*/
@implementation NSObject (KVO)

-(void)hsg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [@"HSGKVO_" stringByAppendingString:oldName];
    const char *name = [newName UTF8String];
    Class newClass = objc_allocateClassPair([self class], name, 0);
    ///注册类
    objc_registerClassPair(newClass);
    ///改变方法的调用者的类型
    object_setClass(self, newClass);
    
    ///3. 给子类添加方法setName: 子类中是不存在父类中的set方法，当在调用时会到父类寻找set方法。
    class_addMethod(newClass, @selector(setName:), (IMP)setName, "");
    
    ///4 绑定观察者
    objc_setAssociatedObject(self, (__bridge const void *)@"", observer, OBJC_ASSOCIATION_ASSIGN);
}

void setName(id self ,SEL _cmd,NSString *newName){
    NSLog(@"%@",newName);
    ///1. 通过dict保存以前的name值
    id class = [self class];
    object_setClass(self, class_getSuperclass(class));
    objc_msgSend(self,@selector(setName:), newName);
    object_setClass(self, class);
    ///2. 保存修改之后的name值
    ///拿到观察者
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"");
    /**
     通知观察者:
     使用objc_msgSend 需要设置build settings
     `Enable strict checking of objc_msgSend call` = NO
     */
    objc_msgSend(observer,@selector(observeValueForKeyPath:ofObject:change:context:),@"name",self,nil,nil);
    
}
@end
