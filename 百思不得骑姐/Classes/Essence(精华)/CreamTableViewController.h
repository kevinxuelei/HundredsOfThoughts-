//
//  CreamTableViewController.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"
#import "AllViewController.h"
#import "PhotoViewController.h"
#import "SegmentViewController.h"
#import "RankingViewController.h"
@class AllViewController;
@class SegmentViewController;
@class RankingViewController;
@class PhotoViewController;
@interface CreamTableViewController : UIViewController<QCSlideSwitchViewDelegate>

@property (nonatomic, strong) QCSlideSwitchView *slideSwitchView;

@property(nonatomic,assign)AllViewController *essence;
@property(nonatomic,strong)PhotoViewController *newest;
@property(nonatomic,strong)SegmentViewController *through;
@property(nonatomic,strong)RankingViewController *through1;

@end
