//
//  MyTableViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "MyTableViewController.h"
#import "MySetViewController.h"
#import "DownLoadViewController.h"
#import "ShouCangViewController.h"
#import "LoginViewController.h"
#import "UserFMDBSql.h"
#import "UserInfoModel.h"

@interface MyTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self loadTableView];
    
}
- (void)loadTableView
{
    UIBarButtonItem *barSet = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine-setting-icon"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSet:)];
    
    UIBarButtonItem *barAtLight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine-moon-icon-click"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickAtLight:)];
    
    self.navigationItem.rightBarButtonItems = @[barSet,barAtLight];
    
    
    
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [self.view addSubview:_myTableView];
//    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"111"];
}
#pragma mark button点击方法
- (void)clickSet:(UIBarButtonItem *)btn
{
    MySetViewController *set = [[MySetViewController alloc] init];
    [self.navigationController pushViewController:set animated:YES];
}

- (void)clickAtLight:(UIBarButtonItem *)sender
{
    NSLog(@"点击黑夜");
}


#pragma mark UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"111"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        NSString *str = [KUSERDefaults objectForKey:@"isLogin"];
        if ([str isEqualToString:@"0"]) {
            cell.textLabel.text = @"登陆/注册";
        }else if([str isEqualToString:@"1"]){
            NSArray *array = [KUSERFMDB selectAll];
            UserInfoModel *model = [array lastObject];
            cell.textLabel.text = model.username;
        }
        
        
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"我的收藏";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [KUSERDefaults objectForKey:@"isLogin"];
    if (indexPath.section == 1) {
        DownLoadViewController *down = [[DownLoadViewController alloc] init];
        [self.navigationController pushViewController:down animated:YES];
    }
    if (indexPath.section == 2) {
        if ([str isEqualToString:@"1"]) {
            ShouCangViewController *shou = [[ShouCangViewController alloc] init];
            [self.navigationController pushViewController:shou animated:YES];
        }else{
            LoginViewController *login = [[LoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:^{
                
            }];
        }
    }
    if (indexPath.section == 0) {
        if ([str isEqualToString:@"0"]) {
            LoginViewController *login = [[LoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:^{
                
            }];
        }
    }
    
}

@end