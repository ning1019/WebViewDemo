//
//  TableViewCell.m
//  WebViewDemo
//
//  Created by 宁 on 2017/9/10.
//  Copyright © 2017年 宁. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()<WKNavigationDelegate>

@property (nonatomic, assign) CGFloat webViewHeight;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatview];
    }
    return self;
}
- (void)creatview{
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 180)];
    _headImageView.image = [UIImage imageNamed:@"demo"];
    [self.contentView addSubview:_headImageView];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 180, 375, 10)];
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:_webView];
    
    NSString *urlString = [NSString stringWithFormat:@"https://www.sina.com.cn"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    _redView = [[UIView alloc] initWithFrame:CGRectMake(0, _webView.frame.origin.y + _webView.frame.size.height, 375, 100)];
    _redView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_redView];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    
  }

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _webView.scrollView && [keyPath isEqualToString:@"contentSize"]) {
        _webViewHeight = _webView.scrollView.contentSize.height;
        _webView.frame = CGRectMake(0, 180, 375, _webViewHeight);
        _redView.frame = CGRectMake(0, _webView.frame.origin.y + _webView.frame.size.height, 375, 100);
        NSLog(@"========%lf",_webViewHeight);
        if (_WebHeightBlock) {
            _WebHeightBlock(_webViewHeight);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
