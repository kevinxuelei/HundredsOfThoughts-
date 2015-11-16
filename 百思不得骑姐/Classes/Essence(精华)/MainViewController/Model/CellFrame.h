//
//  CellFrame.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/25.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface CellFrame : NSObject


// 用户头像
@property (nonatomic, assign)CGRect  profile_imageFrame;
// 用户名
@property (nonatomic, assign) CGRect nameFrame;
// 发表时间frame
@property (nonatomic, assign) CGRect created_atFrame;
// 文本frame
@property (nonatomic, assign) CGRect textFrame;
// 图片frame
@property (nonatomic, assign) CGRect webViewFrame;
// 图片frame1
//@property (nonatomic, assign) CGRect image1Frame;
// 赞
@property (nonatomic, assign) CGRect loveButtonFrame;
// 讨厌
@property (nonatomic, assign) CGRect hateButtonFrame;
// 转发
@property (nonatomic, assign) CGRect repostBtnFrame;
// 评论
@property (nonatomic, assign) CGRect commentBtnFrame;
// cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) UserModel * model;


@end
