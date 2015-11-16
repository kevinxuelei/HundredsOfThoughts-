//
//  NewCardTableViewController.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"
@class NewAllViewController;
@class NewPhotoViewController;
@class NewSegmentViewController;
@class NewVoiceViewController;

@interface NewCardTableViewController : UIViewController<QCSlideSwitchViewDelegate>
@property (nonatomic, strong) QCSlideSwitchView * slideSwitchView;

@property (nonatomic, assign) NewAllViewController *all;
@property (nonatomic, assign) NewPhotoViewController * photo;
@property (nonatomic, assign) NewSegmentViewController * segment;
@property (nonatomic, assign) NewVoiceViewController * voice;


@end
