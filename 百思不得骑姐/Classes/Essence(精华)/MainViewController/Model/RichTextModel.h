//
//  RichTextModel.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RichTextModel : NSObject

@property (nonatomic,copy) NSString * type; //类型
@property (nonatomic,copy) NSString * source_url; // 地址
@property (nonatomic,copy) NSString * title;// 标题
@property (nonatomic,copy) NSString * desc; // 解释
@property (nonatomic,copy) NSString * img_url; //图片
@property (nonatomic,copy) NSString * text; // 文本

@end
