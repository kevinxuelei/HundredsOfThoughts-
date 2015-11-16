//
//  AllVedioViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "AllVedioViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "KrVideoPlayerController.h"

@interface AllVedioViewController ()
@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@end

@implementation AllVedioViewController

+ (instancetype)sharedViewController
{
    static AllVedioViewController *detail = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (detail == nil) {
            detail = [[AllVedioViewController alloc] init];
        }
    });
    return detail;
}


- (void)playVideo{
    NSURL *url = [NSURL URLWithString:self.nameUrl];
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 52, self.view.width, self.view.height - 52)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}
//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool{
    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}



- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self playVideo];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 32)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [self.view addSubview:view];
    UIButton *button = [[UIButton alloc] init];
    button.x = 20;
    button.y = 0;
    button.width = 32;
    button.height = 32;
    [button setImage:[UIImage imageNamed:@"show_image_back_icon"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clicked) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:button];
    
}

- (void)clicked
{
    [self dismissViewControllerAnimated:YES completion:^{
//        self.cellF = nil;
        [self.videoController stop];
    }];
}


@end
