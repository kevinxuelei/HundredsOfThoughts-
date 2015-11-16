//
//  MySetViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/30.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "MySetViewController.h"

@interface MySetViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self loadTableView];


}

- (void)loadTableView
{
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
    //    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"111"];
}

#pragma mark UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else{
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"字体大小";
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"转发时收藏";
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"摇一摇夜间模式";
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"离线下载";
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"清除缓存";
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        cell.textLabel.text = @"帮助";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end