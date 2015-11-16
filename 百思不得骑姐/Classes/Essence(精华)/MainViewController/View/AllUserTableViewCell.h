//
//  AllUserTableViewCell.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/25.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellFrame.h"
#import "UserModel.h"
#import "KrVideoPlayerController.h"

@interface AllUserTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * profile_image;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * created_atLabel;
@property (nonatomic, strong) UILabel * text_Label;
//@property (nonatomic, strong) UIImageView * image1View;
@property (nonatomic, strong) UIButton * loveButton;
@property (nonatomic, strong) UIButton * hateButton;
@property (nonatomic, strong) UIButton * repostBtn;
@property (nonatomic, strong) UIButton * commentBtn;
@property (nonatomic, strong) UIImageView * webView1;

@property (nonatomic, strong) CellFrame * cellFrame;
@property (nonatomic, strong) KrVideoPlayerController *videoController;
@property (nonatomic, strong) UIButton * saveButton;

@end
