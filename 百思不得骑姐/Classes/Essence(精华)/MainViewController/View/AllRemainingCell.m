//
//  AllRemainingCell.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "AllRemainingCell.h"
#import "UIImageView+WebCache.h"
#import "UserDetailModel.h"
#import "LittleUser.h"

@interface AllRemainingCell ()

@end

@implementation AllRemainingCell

- (void)setUserDetail:(UserDetailModel *)userDetail
{
    
    _userDetail = userDetail;
    [self.proFile_imageView sd_setImageWithURL:[NSURL URLWithString:_userDetail.littleUser.profile_image]];
    self.proFile_imageView.layer.cornerRadius = 15;
    self.proFile_imageView.layer.masksToBounds = YES;
    if ([userDetail.littleUser.sex isEqualToString:@"m"]) {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    self.usernameLabel.text = userDetail.littleUser.username;
    self.loveImageView.image = [UIImage imageNamed:@"contributeDingN"];
    self.contentLabel.text = userDetail.content;
    
}

@end
