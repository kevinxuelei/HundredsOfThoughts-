//
//  CreamTableViewController.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "CreamTableViewController.h"


@interface CreamTableViewController ()

@end

@implementation CreamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self load_slideSwitchView];
    

}

- (void)load_slideSwitchView
{
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
    
    AllViewController * homeVC = [[AllViewController alloc] init];
    homeVC.totalVC = self;
    self.essence = homeVC;
    self.essence.title = @"全部";
    
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    photoVC.totalVC = self;
    self.newest = photoVC;
    self.newest.title = @"图片";
    
    SegmentViewController *segentVC = [[SegmentViewController alloc] init];
    segentVC.totalVC = self;
    self.through = segentVC;
    self.through.title = @"段子";
    
    RankingViewController *rankingVC = [[RankingViewController alloc] init];
    rankingVC.totalVC = self;
    self.through1 = rankingVC;
    self.through1.title = @"排行";
    
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
        return self.essence;
    } else if (number == 1) {
        return self.newest;
    } else if (number == 2) {
        return self.through;
    }else if (number == 3) {
        return self.through1;
    }else {
        return nil;
    }
}



@end