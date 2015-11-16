//
//  MainTabBarController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "MainTabBarController.h"
#import "CreamTableViewController.h"
#import "NewCardTableViewController.h"
#import "AttentionTableViewController.h"
#import "MyTableViewController.h"
#import "SendViewController.h"
#import "PLTabBar.h"

@interface MainTabBarController ()<PLTabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建tabbarItem
    [self setUpViewController:[[CreamTableViewController alloc] init] title:@"精华" imageName:@"tabBar_essence_iconN"  selectimage:@"tabBar_essence_click_iconN"];
    [self setUpViewController:[[NewCardTableViewController alloc] init] title:@"新帖" imageName:@"tabBar_new_iconN"  selectimage:@"tabBar_new_click_iconN"];
    [self setUpViewController:[[AttentionTableViewController alloc] init] title:@"关注" imageName:@"tabBar_friendTrends_icon" selectimage:@"tabBar_friendTrends_click_iconN"];
    [self setUpViewController:[[MyTableViewController alloc] init] title:@"我" imageName:@"tabBar_me_icon" selectimage:@"tabBar_me_click_iconN"];
    
    // 添加+按钮
    [self setupCenterAddButton];
}


- (void)setUpViewController:(UIViewController *)tableVC title:(NSString *)title imageName:(NSString *)image selectimage:(NSString *)iamgeSel
{
    tableVC.tabBarItem.title = title;
    tableVC.tabBarItem.image = [UIImage imageNamed:image];
    tableVC.tabBarItem.selectedImage = [UIImage imageNamed:iamgeSel];
    UINavigationController *naviNC = [[UINavigationController alloc] initWithRootViewController:tableVC];
    tableVC.navigationItem.title = title;
    [self addChildViewController:naviNC];
}

- (void)setupCenterAddButton
{
    // 创建自定义tabbar
    PLTabBar *customTabBar = [[PLTabBar alloc] init];
    customTabBar.tabBarDelegate = self;
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

#pragma mark - PLTabBarDelegate
- (void)tabBarDidClick:(PLTabBar *)tabBar
{
    // 弹出控制器
    SendViewController *send = [[SendViewController alloc] init];
    [self presentViewController:send animated:YES completion:^{
    }];
    NSLog(@"点击了");
}


@end
