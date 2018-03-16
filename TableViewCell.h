//
//  TableViewCell.h
//  WebViewDemo
//
//  Created by 宁 on 2017/9/10.
//  Copyright © 2017年 宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, copy) void(^WebHeightBlock)(CGFloat height);

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *redView;

@end
