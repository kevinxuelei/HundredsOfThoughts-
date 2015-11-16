//
//  ShouCangViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/30.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "ShouCangViewController.h"
#import "SaveUserInfoFMDB.h"
#import "AllUserTableViewCell.h"
#import "UserModel.h"

@interface ShouCangViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.translucent = NO;
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, self.view.height) style:(UITableViewStylePlain)];
    tableV.delegate = self;
    tableV.dataSource = self;
    [tableV registerClass:[AllUserTableViewCell class] forCellReuseIdentifier:@"1"];

    [self.view addSubview:tableV];
    [self loadData];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    NSArray *array = [KSaveInfoFMDB selectAll];
    for (UserModel *model in array) {
        [_dataArray addObject:model];
    }
    [_tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"1"];
    }
    cell.textLabel.text = [self.dataArray[indexPath.section] name];
    cell.detailTextLabel.text = [self.dataArray[indexPath.section] text];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


@end
