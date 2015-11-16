//
//  AllDetailViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "AllDetailViewController.h"
#import "AllUserTableViewCell.h"
#import "CellFrame.h"
#import "UserDetailModel.h"
#import "AllRemainingView.h"

@interface AllDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, copy) NSString *strD;
@end

@implementation AllDetailViewController

+ (instancetype)sharedViewController
{
    static AllDetailViewController *detail = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (detail == nil) {
            detail = [[AllDetailViewController alloc] init];
        }
    });
    return detail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.cellF.model.name;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(click:)];
    
}

- (void)click:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.cellF = nil;
        self.tableView.height = 0;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_cellF.model.richModel) {
        self.web = [[UIWebView alloc] initWithFrame:self.view.frame];
        [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_cellF.model.richModel.source_url]]];
        [self.view addSubview:_web];
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.navigationController.navigationBar.translucent = NO;
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, self.view.height) style:(UITableViewStylePlain)];
        tableV.delegate = self;
        tableV.dataSource = self;
        [tableV registerClass:[AllUserTableViewCell class] forCellReuseIdentifier:@"1"];
        //    [tableV setScrollEnabled:NO];
        self.tableView = tableV;
        [self.view addSubview:tableV];
        CGFloat x = 0;
        CGFloat y = _tableView.height;
        CGFloat  width = self.view.width + 20;
        //    CGFloat height = self.view.height - _tableView.height;
        CGFloat height = self.view.height - _cellF.cellHeight;
        self.allRView = [[AllRemainingView alloc] initWithFrame:CGRectMake(x, y, width,height)];
        self.allRView.strID = self.cellF.model.ID;
        //    [self.view addSubview:_allRView];
        self.tableView.tableFooterView = _allRView;
    }
}


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
    return self.cellF.cellHeight;
}


@end
