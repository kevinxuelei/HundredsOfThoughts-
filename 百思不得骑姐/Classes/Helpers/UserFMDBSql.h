//
//  UserFMDBSql.h
//  FMDBDatabase
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 吕志伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserFMDBSql : NSObject

+ (UserFMDBSql *)shareUserFMDBSql;

// 增加

- (void)insertIntoTable:(UserInfoModel *)user;

// 删除

- (void)deletaFromTable:(NSInteger)ADID;

// 修改

- (void)upDataFromTbaleWhereName:(NSString *)name toID:(NSString *)ADID;

// 查询

- (NSArray *)selectAll;

//根据条件查询

- (NSArray *)selectFromTableWhereName:(NSString *)name;


@end
