//
//  NextViewController.m
//  WebViewDemo
//
//  Created by 宁 on 2017/9/8.
//  Copyright © 2017年 宁. All rights reserved.
//

#import "NextViewController.h"
#import "TableViewCell.h"

@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, assign) CGFloat webHeight;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    _mainTableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return _webHeight + 100 + 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"webCell"];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"webCell"];
    }
    cell.backgroundColor = [UIColor redColor];
    cell.WebHeightBlock = ^(CGFloat height) {
        _webHeight = height;
        NSLog(@"+++++++++++++++++++%lf",_webHeight);
        [_mainTableView reloadData];
    };
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
