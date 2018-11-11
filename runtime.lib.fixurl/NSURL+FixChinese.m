//
//  NSURL+FixChinese.m
//  runtime.lib.fixurl
//
//  Created by admin on 2018/11/11.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "NSURL+FixChinese.h"
#import <objc/runtime.h>

/**
HOOK钩子:当项目中调用了某个方法，我就能知道，而且能进行添加/修改新功能
    SEL1 --- IMP1
    SEL2 --- IMP2
hook 修改
    SEL1 --- IMP2
    SEL2 --- IMP1
 达到效果：不用通过新增方法或重载的方式，即可修复问题的方式。
 // 时机
 load方法：当项目编译时，将子类装载到内存的过程中，会load方法
 在load方法中，通过逆向工程HOOK勾住系统的原方法：保留原有实现，添加新的代码
 
 */
@implementation NSURL (FixChinese)

/**
 hook之后，交换方法，`[NSURL URLWithString:str];`导致函数调用递归，
 需要修改为自己搞自己方式:`[NSURL fixChinese:str];`
 */
+(NSURL *)fixChinese:(NSString *)str
{
    NSURL *url = [NSURL fixChinese:str];
    if (!url) {
        NSLog(@"汉字问题");
    }
    return url;
}

/**
 当编译装载该类时，会调用load方法，就可以使用hook操作
 hook修改为class动态添加方法
 `class_getInstanceMethod`/`class_getClassMethod`:获取方法的`SEL`
 `method_getImplementation`:方法的实现`IMP`
 `method_getTypeEncoding`: 获取方法的类型，char字符表示
 `class_addMethod`: 向对象当中添加方法的运行时函数。它所需的参数，即上述方法结构体当中的那三个值：Selector、方法实现和方法类型。
 `class_replaceMethod`: 替换对象当中的方法的IMP实现
 */
+ (void)load {
    NSLog(@"开始使用load钩子来修改方法的实现");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(URLWithString:);
        SEL swizzledSelector = @selector(fixChinese:);
        Method originalMethod = class_getClassMethod(class,originalSelector);
        Method swizzledMethod = class_getClassMethod(class,swizzledSelector);
        /// 动态添加方法
        IMP swizzledMethodImp = method_getImplementation(swizzledMethod);
        const char *types = method_getTypeEncoding(swizzledMethod);
        BOOL didAddMethod = class_addMethod(class, originalSelector,swizzledMethodImp,types);
        if (NO/*didAddMethod*/) {
            /**
             方法替换：不保留原有实现，添加全新功能
             SEL1 --- IMP2
             */
            class_replaceMethod(class,originalSelector,swizzledMethodImp,types);
        } else {
            /**
                方法交换：保留原有实现，添加新功能
                SEL1 --- IMP2
                SEL2 --- IMP1
            */
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

@end
