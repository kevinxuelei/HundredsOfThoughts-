//
//  NewCardTableViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "NewCardTableViewController.h"
#import "NewAllViewController.h"
#import "NewPhotoViewController.h"
#import "NewSegmentViewController.h"
#import "NewVoiceViewController.h"

@interface NewCardTableViewController ()

@end

@implementation NewCardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _slideSwitchView = [[QCSlideSwitchView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeight)];
    _slideSwitchView.topScrollView.backgroundColor = [UIColor blackColor];
    _slideSwitchView.topScrollView.alpha = 0.3;
    [self.view addSubview:_slideSwitchView];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    NewAllViewController * homeVC = [[NewAllViewController alloc] init];
    homeVC.totalVC = self;
    self.all = homeVC;
    self.all.title = @"全部";
    
    NewPhotoViewController *photoVC = [[NewPhotoViewController alloc] init];
    photoVC.totalVC = self;
    self.photo = photoVC;
    self.photo.title = @"图片";
    
    NewSegmentViewController *segentVC = [[NewSegmentViewController alloc] init];
    segentVC.totalVC = self;
    self.segment = segentVC;
    self.segment.title = @"段子";
    
    NewVoiceViewController *rankingVC = [[NewVoiceViewController alloc] init];
    rankingVC.totalVC = self;
    self.voice = rankingVC;
    self.voice.title = @"声音";
    
    _slideSwitchView.slideSwitchViewDelegate =self;
    [self.slideSwitchView buildUI];
    
}

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return 4;
}
- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.all;
    } else if (number == 1) {
        return self.photo;
    } else if (number == 2) {
        return self.segment;
    }else if (number == 3) {
        return self.voice;
    }else {
        return nil;
    }
}

@end
