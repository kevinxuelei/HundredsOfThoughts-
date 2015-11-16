//
//  UserDetailModel.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LittleUser.h"

@interface UserDetailModel : NSObject

@property (nonatomic,copy) NSString * content;
//@property (nonatomic,copy) NSString * ID;
//@property (nonatomic,copy) NSString * data_id;
//@property (nonatomic,copy) NSString * ctime;
//@property (nonatomic,copy) NSString * like_count;
//@property (nonatomic,copy) NSString * voiceuri;
//@property (nonatomic,copy) NSString * voicetime;
@property (nonatomic, strong) LittleUser * littleUser;

@end
