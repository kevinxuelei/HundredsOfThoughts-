//
//  AllRemainingCell.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserDetailModel;
@class LittleUser;

@interface AllRemainingCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *proFile_imageView;
@property (strong, nonatomic) IBOutlet UIImageView *sexImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *loveImageView;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) UserDetailModel * userDetail;

@end
