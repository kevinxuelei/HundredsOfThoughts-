//
//  SaveUserInfoFMDB.h
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/30.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"


@interface SaveUserInfoFMDB : NSObject

+ (SaveUserInfoFMDB *)shareUserFMDBSql;

// 增加

- (void)insertIntoTable:(UserModel *)user;

// 删除

- (void)deletaFromTable:(NSInteger)ADID;

// 修改

- (void)upDataFromTbaleWhereName:(NSString *)name toID:(NSString *)ADID;

// 查询

- (NSArray *)selectAll;

//根据条件查询

- (NSArray *)selectFromTableWhereName:(NSString *)name;

@end
