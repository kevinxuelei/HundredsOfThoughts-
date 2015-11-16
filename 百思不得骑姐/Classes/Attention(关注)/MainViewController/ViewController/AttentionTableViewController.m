//
//  AttentionTableViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "AttentionTableViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface AttentionTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation AttentionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *islogin = [KUSERDefaults objectForKey:@"isLogin"];
    if ([islogin isEqualToString:@"0"]) {
        [self loadSubViews];
    }else{
        [self loadAttentionView];
    }
}
// 加载 关注页面
- (void)loadAttentionView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
// 加载 登陆注册界面
- (void)loadSubViews
{
    // 1.加载最上面文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15+64 , self.view.width - 40, 25)];
    label.text = @"快快登陆把，关注百思最in牛人";
//    label.textAlignment = UITextAlignmentCenter;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    // 2.加载imageView
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.x = (self.view.width - 190) /2;
    imageV.y = (self.view.height - 190) /2;
    imageV.size = CGSizeMake(190, 190);
    imageV.image = [UIImage imageNamed:@"header_cry_icon"];
    [self.view addSubview:imageV];
    
    CGFloat space = 25;
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.x = space;
    loginBtn.y = self.view.height - 50 - 44;
    loginBtn.width = (self.view.width - 75) / 2;
    loginBtn.height = 29;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"post-tag-participants-click-1"] forState:(UIControlStateNormal)];
    [loginBtn setTitle:@"登陆" forState:(UIControlStateNormal)];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(clickToLogin:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *registerBtn = [[UIButton alloc] init];
    registerBtn.x = CGRectGetMaxX(loginBtn.frame) + space;
    registerBtn.y = self.view.height - 50 - 44;
    registerBtn.width = loginBtn.width;
    registerBtn.height = 29;
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"Profile_unfollowBtnBg"] forState:(UIControlStateNormal)];
    [registerBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [registerBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(clickToRegister:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

// 登陆
- (void)clickToLogin:(UIButton *)sender
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];
}

// 注册
- (void)clickToRegister:(UIButton *)sender
{
    RegisterViewController *loginVC = [[RegisterViewController alloc] init];
    
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];
}


//UITableViewDataSource代理方法
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
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    return cell;
}

@end
