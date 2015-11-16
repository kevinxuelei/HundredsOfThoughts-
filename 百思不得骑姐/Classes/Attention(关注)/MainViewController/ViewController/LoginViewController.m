//
//  LoginViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserFMDBSql.h"
#import "UserInfoModel.h"


@interface LoginViewController ()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, strong) UIView *registerView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    
    [self loadSubViews];

}

- (void)loadSubViews
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:view];
    self.loginView = view;
    
    self.imageV = [[UIImageView alloc] initWithFrame:self.view.frame];
    _imageV.image = [UIImage imageNamed:@"login_register_background"];
    [_loginView addSubview:_imageV];
    _imageV.userInteractionEnabled = YES;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    loginBtn.x = 0;
    loginBtn.y = 20;
    loginBtn.width = 44;
    loginBtn.height = 44;
    [loginBtn setImage:[UIImage imageNamed:@"shoot_cancel_normal"] forState:(UIControlStateNormal)];
//    [loginBtn setTitle:@"登陆" forState:(UIControlStateNormal)];
    [loginBtn addTarget:self action:@selector(cancel:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView addSubview:loginBtn];
    
    UIButton *btn = [self addButton:CGRectMake(self.view.width - 60, 20, 60, 44) title:@"注册账号" imageName:nil target:self action:@selector(registerLogin:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.loginView addSubview:btn];
    
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.x = 15;
    phoneField.y = 80;
    phoneField.width = self.view.width - 2*15;
    phoneField.height = 44;
    phoneField.placeholder = @"手机号";
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.backgroundColor = [UIColor whiteColor];
    phoneField.textColor = [UIColor blackColor];
    phoneField.layer.cornerRadius = 10;
    self.phoneField = phoneField;
    [self.loginView addSubview:phoneField];
    
    UITextField *passwordField = [[UITextField alloc] init];
    passwordField.x = 15;
    passwordField.y = 122 + 10;
    passwordField.width = self.view.width - 2*15;
    passwordField.height = 44;
    passwordField.placeholder = @"密码";
    passwordField.layer.cornerRadius = 10;
    passwordField.backgroundColor = [UIColor whiteColor];
    passwordField.textColor = [UIColor blackColor];
    self.passwordField = passwordField;
    [self.loginView addSubview:passwordField];
    
    UIButton *loginToNextBtn = [self addButton:CGRectMake(15, 190, passwordField.width, 44) title:@"登陆" imageName:nil target:self action:@selector(loginToNextView:) forControlEvents:(UIControlEventTouchUpInside)];
    [loginToNextBtn setBackgroundImage:[UIImage imageNamed:@"jie-favoritePopupButton"] forState:(UIControlStateNormal)];
    [self.loginView addSubview:loginToNextBtn];
    
}

// 返回
- (void)cancel:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// 添加button方法
- (UIButton *)addButton:(CGRect )rects title:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *button = [[UIButton alloc] init];
    button.frame = rects;
    [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button addTarget:target action:action forControlEvents:controlEvents];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    return button;
}

// 注册
- (void)registerLogin:(UIButton *)sender
{
    RegisterViewController *regi =  [[RegisterViewController alloc] init];
    [self presentViewController:regi animated:YES completion:^{
        
    }];
}

// 登陆按钮
- (void)loginToNextView:(UIButton *)sender
{
    NSLog(@"开始登陆");
    NSString *str = [KUSERDefaults  objectForKey:@"isLogin"];
    if ([str isEqualToString:@"0"]) {
        [self pipeiPhone:self.phoneField.text];
        
        if ([self.phoneField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号或者密码不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }else{
            
            if ([str isEqualToString:@"0"]) {
                NSArray *dataA = [KUSERFMDB selectFromTableWhereName:self.phoneField.text];
                for (UserInfoModel *model in dataA) {
                    if ([model.username isEqualToString:self.phoneField.text] && [model.password isEqualToString:self.passwordField.text]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        [alert show];
                    }
                    
                    [KUSERDefaults setObject:@"1" forKey:@"isLogin"];
                }
            }
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    // 使用正则判断页面
}

// 匹配电话号码
- (void)pipeiPhone:(NSString *)str
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:str];
    BOOL res2 = [regextestcm evaluateWithObject:str];
    BOOL res3 = [regextestcu evaluateWithObject:str];
    BOOL res4 = [regextestct evaluateWithObject:str];
    
    if (res1 || res2 || res3 || res4 )
    {
        NSLog(@"yes");
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码不匹配!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        NSLog(@"no");
    }
   
}


@end
