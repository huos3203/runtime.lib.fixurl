//
//  LazyMethodController.m
//  runtime.lib.lazyMethod
//
//  Created by admin on 2018/11/11.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "LazyMethodController.h"
#import "Person.h"
@interface LazyMethodController ()

@end

@implementation LazyMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    Person *person = [[Person alloc] init];
    [person performSelector:@selector(eat:) withObject:@"汉堡王皇堡"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
