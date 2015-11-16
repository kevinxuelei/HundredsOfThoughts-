//
//  UserModel.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/25.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RichTextModel.h"

@interface UserModel : NSObject

@property (nonatomic,copy) NSString * text; // 标题
@property (nonatomic,copy) NSString * profile_image;// 用户头像
@property (nonatomic,copy) NSString * created_at; // 发表时间
@property (nonatomic,copy) NSString * love; // 点赞的
@property (nonatomic,copy) NSString * hate; // 讨厌的
@property (nonatomic,copy) NSString * comment; // 评论的
@property (nonatomic,copy) NSString * repost; // 转发
@property (nonatomic,copy) NSString * voiceuri; // 音频url
@property (nonatomic,copy) NSString * voicetime; // 声音时长
@property (nonatomic,copy) NSString * richtxt; // 富文本
@property (nonatomic,copy) NSString * bimageuri; // 大图片
@property (nonatomic,copy) NSString * name;// 用户名
@property (nonatomic,copy) NSString * videouri; //视频url
@property (nonatomic,copy) NSString * ID;

@property (nonatomic, assign) CGFloat cellH;

@property (nonatomic,copy) NSString * image1;

@property (nonatomic,copy) NSString * width; // 图片宽
@property (nonatomic,copy) NSString * height; // 图片高

@property (nonatomic,copy) NSString * is_gif; //是否是gif
@property (nonatomic, strong) RichTextModel * richModel;
@property (nonatomic,copy) NSString * user_id;

@end
