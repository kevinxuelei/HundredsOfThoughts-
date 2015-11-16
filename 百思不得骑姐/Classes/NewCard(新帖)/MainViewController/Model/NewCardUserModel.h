//
//  NewCardUserModel.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewCardUserModel : NSObject

@property (nonatomic,copy) NSString * username; // 用户名
@property (nonatomic,copy) NSString * sex;// 性别
@property (nonatomic,copy) NSString * introduction;// 个人介绍
@property (nonatomic,copy) NSString * profile_image;// 头像
@property (nonatomic,copy) NSString * profile_image_large;// 大头像
@property (nonatomic,copy) NSString * background_image;// 背景图片
@property (nonatomic,copy) NSString * follow_count;//赞的人数
@property (nonatomic,copy) NSString * fans_count; // 粉丝数量
//@property (nonatomic,copy) NSString * praise_count; //
@property (nonatomic,assign) NSInteger level; //等级
@property (nonatomic,copy) NSString * relationship; // 关注的人数
@property (nonatomic,assign) NSInteger  credit; //积分
@property (nonatomic,assign) NSInteger  tiezi_count; // 帖子数量
@property (nonatomic,copy) NSString * comment_count; //评论数量
@property (nonatomic,copy) NSString * share_count; // 分享数量


@end
