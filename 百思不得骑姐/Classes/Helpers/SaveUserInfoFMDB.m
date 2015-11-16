//
//  SaveUserInfoFMDB.m
//  百思不得骑姐
//
//  Created by lanou3g on 15/10/30.
//  Copyright (c) 2015年 lanlou3g.com 蓝欧科技. All rights reserved.
//

#import "SaveUserInfoFMDB.h"
#import "UserModel.h"

@implementation SaveUserInfoFMDB

static FMDatabase *_db;

+ (SaveUserInfoFMDB *)shareUserFMDBSql
{
    static SaveUserInfoFMDB * FMDBSql = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        FMDBSql = [[SaveUserInfoFMDB alloc] init];
        
        [FMDBSql buildSqlite];
    });
    
    return FMDBSql;
}







- (void)buildSqlite
{
    NSString *doucumentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *str = [doucumentStr stringByAppendingString:@"/SaveSql.sqlite"];
    NSLog(@"%@",str);
    _db = [FMDatabase databaseWithPath:str];
    
    if ([_db open]) {
        // AUTOINCREMENT(设置id为逐渐增长) 如果ID设置为逐渐，且设置为自动增长的话，那么把表中的数据删除后，重新插入新的数据，ID的编号不是从0开始，而是接着之前的ID进行编号。
        NSString *createStr =[NSString stringWithFormat:@"CREATE TABLE SaveName(text text, profile_image text,created_at text,love text,hate text,comment text,repost text,name text,image1 text,voiceuri text,voicetime text,richtxt text,bimageuri text,videouri text,ID text,cellH float,width text,height text,is_gif text,richModel blob, user_id text)"];
        
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

- (void)insertIntoTable:(UserModel *)user
{
    if([_db open])
    {
        
        NSString *insertSql1= [NSString stringWithFormat:
                               @"INSERT INTO SaveName (text, profile_image,created_at,love,hate,comment,repost,name,image1,voiceuri,voicetime,richtxt,bimageuri,videouri,ID,cellH,width,height,is_gif,richModel,user_id) VALUES ('%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%f','%@','%@','%@','%@','%@')",user.text,user.profile_image,user.created_at,user.love,user.hate,user.comment,user.repost,user.name,user.image1,user.voiceuri,user.voicetime,user.richtxt,user.bimageuri,user.videouri, user.ID,user.cellH,user.width,user.height,user.is_gif,user.richModel,user.user_id];
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

- (void)deletaFromTable:(NSInteger)name
{
    if([_db open])
    {
        
        NSString *insertSql1= [NSString stringWithFormat:
                               @"DELETE FROM SaveName WHERE name = %ld",name];
        
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
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM SaveName"];
        
        //取得特定的资料，则需使用FMResultSet接收传回的内容
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            
            NSString * text = [rs stringForColumn:@"text"];
            NSString * profile_image = [rs stringForColumn:@"profile_image"];
            NSString * created_at = [rs stringForColumn:@"created_at"];
            NSString * love = [rs stringForColumn:@"love"];
            NSString * hate = [rs stringForColumn:@"hate"];
            NSString * comment = [rs stringForColumn:@"comment"];
            NSString * repost = [rs stringForColumn:@"repost"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * image1 = [rs stringForColumn:@"image1"];
            NSString * voiceuri = [rs stringForColumn:@"voiceuri"];
            NSString * voicetime = [rs stringForColumn:@"voicetime"];
            NSString * richtxt = [rs stringForColumn:@"richtxt"];
            NSString * bimageuri = [rs stringForColumn:@"bimageuri"];
            NSString * videouri = [rs stringForColumn:@"videouri"];
            NSString * ID = [rs stringForColumn:@"ID"];
//            CGFloat  cellH = [rs stringForColumn:@"cellH"];
            CGFloat cellH = [rs doubleForColumn:@"cellH"];
            NSString * width = [rs stringForColumn:@"width"];
            NSString * height = [rs stringForColumn:@"height"];
            NSString * is_gif = [rs stringForColumn:@"is_gif"];
            NSString * user_id = [rs stringForColumn:@"user_id"];
            
            UserModel *user = [[UserModel alloc] init];
            user.text = text;
            user.profile_image = profile_image;
            user.created_at = created_at;
            user.love = love;
            user.hate = hate;
            user.comment = comment;
            user.repost = repost;
            user.name = name;
            user.image1 = image1;
            user.voiceuri = voiceuri;
            user.voicetime = voicetime;
            user.richtxt = richtxt;
            user.bimageuri = bimageuri;
            user.videouri = videouri;
            user.ID = ID;
            user.cellH = cellH;
            user.width = width;
            user.height = height;
            user.is_gif = is_gif;
            user.user_id = user_id;

            [dataArray addObject:user];
        }
        [_db close];
        
        for (UserModel *users in dataArray) {
            NSLog(@"全部数据===%@",users.text);
        }
    }
    return dataArray;
}

- (NSArray *)selectFromTableWhereName:(NSString *)name
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    if ([_db open]) {
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM SaveName WHERE username = '%@'",name];
        
        //取得特定的资料，则需使用FMResultSet接收传回的内容
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            
            NSString * text = [rs stringForColumn:@"text"];
            NSString * profile_image = [rs stringForColumn:@"profile_image"];
            NSString * created_at = [rs stringForColumn:@"created_at"];
            NSString * love = [rs stringForColumn:@"love"];
            NSString * hate = [rs stringForColumn:@"hate"];
            NSString * comment = [rs stringForColumn:@"comment"];
            NSString * repost = [rs stringForColumn:@"repost"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * image1 = [rs stringForColumn:@"image1"];
            NSString * voiceuri = [rs stringForColumn:@"voiceuri"];
            NSString * voicetime = [rs stringForColumn:@"voicetime"];
            NSString * richtxt = [rs stringForColumn:@"richtxt"];
            NSString * bimageuri = [rs stringForColumn:@"bimageuri"];
            NSString * videouri = [rs stringForColumn:@"videouri"];
            NSString * ID = [rs stringForColumn:@"ID"];
            //            CGFloat  cellH = [rs stringForColumn:@"cellH"];
            CGFloat cellH = [rs doubleForColumn:@"cellH"];
            NSString * width = [rs stringForColumn:@"width"];
            NSString * height = [rs stringForColumn:@"height"];
            NSString * is_gif = [rs stringForColumn:@"is_gif"];
            NSString * user_id = [rs stringForColumn:@"user_id"];
            
            UserModel *user = [[UserModel alloc] init];
            user.text = text;
            user.profile_image = profile_image;
            user.created_at = created_at;
            user.love = love;
            user.hate = hate;
            user.comment = comment;
            user.repost = repost;
            user.name = name;
            user.image1 = image1;
            user.voiceuri = voiceuri;
            user.voicetime = voicetime;
            user.richtxt = richtxt;
            user.bimageuri = bimageuri;
            user.videouri = videouri;
            user.ID = ID;
            user.cellH = cellH;
            user.width = width;
            user.height = height;
            user.is_gif = is_gif;
            user.user_id = user_id;
            
            [dataArray addObject:user];
        }
        [_db close];
        
        for (UserModel *users in dataArray) {
            NSLog(@"全部数据===%@",users.text);
        }
    }
    return dataArray;
}



@end
