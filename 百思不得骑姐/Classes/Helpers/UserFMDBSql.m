//
//  UserFMDBSql.m
//  FMDBDatabase
//
//  Created by lanou3g on 15/10/8.
//  Copyright (c) 2015年 吕志伟. All rights reserved.
//

#import "UserFMDBSql.h"

@interface UserFMDBSql ()

@end

@implementation UserFMDBSql

/*
 
 FMDB有三个主要的类
 
 （1）FMDatabase
 
 一个FMDatabase对象就代表一个单独的SQLite数据库
 
 用来执行SQL语句
 
 
 
 （2）FMResultSet
 
 使用FMDatabase执行查询后的结果集
 
 
 
 （3）FMDatabaseQueue
 
 用于在多线程中执行多个查询或更新，它是线程安全的
 */

static FMDatabase *_db;

+ (UserFMDBSql *)shareUserFMDBSql
{
    static UserFMDBSql * FMDBSql = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        FMDBSql = [[UserFMDBSql alloc] init];
        
        [FMDBSql buildSqlite];
    });
    
    return FMDBSql;
}

- (void)buildSqlite
{
    NSString *doucumentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *str = [doucumentStr stringByAppendingString:@"/UserSql.sqlite"];
    
    _db = [FMDatabase databaseWithPath:str];
    
    if ([_db open]) {
        // AUTOINCREMENT(设置id为逐渐增长) 如果ID设置为逐渐，且设置为自动增长的话，那么把表中的数据删除后，重新插入新的数据，ID的编号不是从0开始，而是接着之前的ID进行编号。
        NSString *createStr =[NSString stringWithFormat:@"CREATE TABLE TableName(UDID integer PRIMARY KEY AUTOINCREMENT, username text, password text)"];
        
        BOOL res = [_db executeUpdate:createStr];
        
        if (res != YES) {
            NSLog(@"创建表失败");
        } else {
            NSLog(@"创建表成功");
        }
        [_db close];
    }
}

// 增加

- (void)insertIntoTable:(UserInfoModel *)user
{
    if([_db open])
    {
        
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO TableName (username, password) VALUES ('%@', '%@')",user.username,user.password];
        //这是FMDB裡很常用的指令，[FMDatabase_object executeUpdate:]后面用NSString塞入SQLite语法，就解决了
        //因为他的返回值是BOOL类型,所以我们用BOOL 类型的res接收一下
        
        BOOL res = [_db executeUpdate:insertSql1];
        
        if(res != YES)
        {
            NSLog(@"添加失败");
        }
        else
        {
            NSLog(@"添加成功");
        }
        
        [_db close];
    }
    else
    {
        NSLog(@"数据库打开失败");
    }

}

// 删除

- (void)deletaFromTable:(NSInteger)ADID
{
    if([_db open])
    {
        
        NSString *insertSql1= [NSString stringWithFormat:
                               @"DELETE FROM TableName WHERE UDID = %ld",ADID];
        
        BOOL res = [_db executeUpdate:insertSql1];
        
        if(res != YES)
        {
            NSLog(@"删除失败");
        }
        else
        {
            NSLog(@"删除成功");
        }
        
        [_db close];
    }
    else
    {
        NSLog(@"数据库打开失败");
    }

}

// 修改

- (void)upDataFromTbaleWhereName:(NSString *)name toID:(NSString *)ADID
{
    if([_db open])
    {
        
        NSString *insertSql1= [NSString stringWithFormat:
                               @"UPDATE TableName SET name = '%@' WHERE UDID = '%@'", name, ADID];
        
        BOOL res = [_db executeUpdate:insertSql1];
        
        if(!res)
        {
            NSLog(@"修改失败");
        }
        else
        {
            NSLog(@"修改成功");
        }
        
        [_db close];
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
}

// 查询

- (NSArray *)selectAll
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    if ([_db open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM TableName"];
        
        //取得特定的资料，则需使用FMResultSet接收传回的内容
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            
            NSString * name = [rs stringForColumn:@"username"];
            NSString * password = [rs stringForColumn:@"password"];
            
            NSInteger ADID = [rs intForColumnIndex:0];
            
            UserInfoModel *user = [[UserInfoModel alloc] init];
            
            user.UDID = ADID;
            user.username = name;
            user.password = password;
            
            [dataArray addObject:user];
        }
        [_db close];
        
        for (UserInfoModel *user in dataArray) {
        
        NSLog(@"全部数据===%ld%@%@",user.UDID, user.username, user.password);
        }
    }
    
    
    
    return dataArray;
}

- (NSArray *)selectFromTableWhereName:(NSString *)name
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    if ([_db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM TableName WHERE username = '%@'",name];
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            
            NSString * name = [rs stringForColumn:@"username"];
            NSString * password = [rs stringForColumn:@"password"];
            
            NSInteger ADID = [rs intForColumnIndex:0];
            
            UserInfoModel *user = [[UserInfoModel alloc] init];
            
            user.UDID = ADID;
            user.username = name;
            user.password = password;
            
            [dataArray addObject:user];
        }
        [_db close];
        
        for (UserInfoModel *user in dataArray) {
            
            NSLog(@"全部数据===%ld%@%@",user.UDID, user.username, user.password);
        }
    }
    return dataArray;
}


@end
