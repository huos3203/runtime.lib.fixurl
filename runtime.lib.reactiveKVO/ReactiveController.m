//
//  ReactiveController.m
//  runtime.lib.reactiveKVO
//
//  Created by admin on 2018/11/11.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "ReactiveController.h"
#import "Person.h"
@interface ReactiveController ()

@end

@implementation ReactiveController
{
    Person *_p;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    Person *p = [[Person alloc] init];
    /**
     KVO原生的响应式编程
     kvo键值观察底层的实现原理:使用runtime，动态的为p对象创建子类：NSKVONotifing_Person
     */
    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    _p = p;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"观察到了%@对象的%@属性变化为了%@",object,keyPath,change);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int a = 0;
    a++;
    _p.name = [NSString stringWithFormat:@"%d",a];
    
}

@end

