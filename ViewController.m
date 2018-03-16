//
//  ViewController.m
//  WebViewDemo
//
//  Created by 宁 on 2017/9/7.
//  Copyright © 2017年 宁. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "NextViewController.h"

@interface ViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) NSArray *desc_image_array;

@end

@implementation ViewController

- (void)gotoNext {
    NextViewController *nvc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
//    [button addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, FWIDTH, FHEIGHT - 40)];
    [self.view addSubview:_scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FWIDTH, 180)];
    imageView.image = [UIImage imageNamed:@"demo"];
    [_scrollView addSubview:imageView];
    
    _wkWebView = [[WKWebView alloc] init];
    _wkWebView.navigationDelegate = self;
    // 禁止webView向下拉动
    _wkWebView.scrollView.bounces = false;
    _wkWebView.scrollView.scrollEnabled = NO;
    _wkWebView.frame = CGRectMake(0, 180, FWIDTH, FHEIGHT - 180);
    //NSString *urlString = [NSString stringWithFormat:@"http://www.jianshu.com/p/6bbcc438b188"];
    NSString *urlString = [NSString stringWithFormat:@"https://www.baidu.com"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_wkWebView loadRequest:request];
    [_scrollView addSubview:_wkWebView];
    
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_redView];
    
    UIView *endView = [[UIView alloc] initWithFrame:CGRectMake(0, FHEIGHT - 40, FWIDTH, 40)];
    endView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:endView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //监听WKWebView的滑动
    [_wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _wkWebView.scrollView && [keyPath isEqualToString:@"contentSize"]) {
        UIScrollView *scrView = _wkWebView.scrollView;
        _wkWebView.frame = CGRectMake(0, 180, FWIDTH, scrView.contentSize.height);
        _redView.frame = CGRectMake(0, _wkWebView.frame.size.height + _wkWebView.frame.origin.y, FWIDTH, 100);
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, scrView.contentSize.height + 100 + 180);
        NSLog(@"*****%.1f",scrView.contentSize.height);
    }
    NSLog(@"泥石流你是蓝山咖啡蓝山咖啡的斯诺克南斯拉夫可能三闾大夫");
}

- (void)dealloc {
    [_wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
