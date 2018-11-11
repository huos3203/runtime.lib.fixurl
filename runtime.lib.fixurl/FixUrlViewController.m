//
//  FixUrlViewController.m
//  runtime.fix.url
//
//  Created by admin on 2018/11/10.
//  Copyright © 2018年 huoshuguang. All rights reserved.
//

#import "FixUrlViewController.h"
#import <WebKit/WebKit.h>
#import "NSURL+FixChinese.h"
@interface FixUrlViewController ()

@end

@implementation FixUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    NSURL *baidu = [NSURL URLWithString:@"https://www.baidu.com/西藏"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:baidu];
    [webview loadRequest:request];
    [self.view addSubview:webview];
}

@end
