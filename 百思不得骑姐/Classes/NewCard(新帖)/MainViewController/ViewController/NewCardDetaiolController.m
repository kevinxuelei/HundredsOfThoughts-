//
//  NewCardDetaiolController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "NewCardDetaiolController.h"
#import "NewCardDetailView.h"
#import "NewCardView.h"

@interface NewCardDetaiolController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NewCardView *onew;

@end

@implementation NewCardDetaiolController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.navigationController.navigationBar.translucent = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.cellF.model.name;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(click:)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    if (self.cellF.model.richModel) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_cellF.model.richModel.source_url]]];
        [self.view addSubview:_webView];
    }else{
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView setScrollEnabled:NO];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[AllUserTableViewCell class] forCellReuseIdentifier:@"1"];
        NewCardDetailView  *view = [[[NSBundle mainBundle] loadNibNamed:@"NewCardDetailView" owner:nil options:nil] lastObject];
//        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, self.view.width, 350);
        _tableView.tableHeaderView = view;
        
        CGFloat x = 0;
        CGFloat y = _tableView.height+350;
        CGFloat  width = self.view.width;
        //    CGFloat height = self.view.height - _tableView.height;
//        CGFloat height = self.view.height - _cellF.cellHeight;
        CGFloat height = 200;
        self.onew = [[NewCardView alloc] initWithFrame:CGRectMake(x, y, width,height)];
        self.onew.strID = self.cellF.model.ID;
        //    [self.view addSubview:_allRView];
        self.tableView.tableFooterView = _onew;
        
    }
    
}

- (void)click:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.cellF = nil;
//        self.tableView.height = 0;
    }];
}

#pragma  mark UITableViewDataSource 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[AllUserTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"1"];
    }
    cell.cellFrame = self.cellF;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.tableView.height = self.cellF.cellHeight;
    return self.cellF.cellHeight + 44;
}


@end
