//
//  LYGTwoDimensionCodeDao.m
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGTwoDimensionCodeDao.h"
#import "LYGDataBaseUIlti.h"
#import "LYGTwoDimensionCodeDao.h"
#import "FMDatabaseAdditions.h"
#import "LYGTwoDimensionCodeModel.h"

@implementation LYGTwoDimensionCodeDao
+(BOOL)createTable
{
    FMDatabase * db = [LYGDataBaseUIlti getSharedDB];
    if ([db open]) {
        BOOL sqlresult = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS TWODIMENSIONCODE (id integer primary key,type integer,createDate date,isCreated bool,isSecret bool,content text,encryptedString text,myType text)"];
        [db close];
        return sqlresult;
    }
    return NO;
    
}
+(void)insert:(LYGTwoDimensionCodeModel*)acode
{
    acode.createDate = [NSDate date];    
    BOOL result = [self createTable];
    if (result == NO) {
        return;
    }
    FMDatabase * db = [LYGDataBaseUIlti getSharedDB];    
    [db open];
    [db setShouldCacheStatements:YES];
    NSLog(@"444%@",acode);
    
    result = [db executeUpdate:@"insert into TWODIMENSIONCODE (type,createDate,isCreated,isSecret,content,encryptedString,myType) values (?,?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",acode.type],acode.createDate,[NSString stringWithFormat:@"%d",acode.isCreated],[NSString stringWithFormat:@"%d",acode.isSecret],acode.content,acode.encryptedString,acode.myType];
    [db clearCachedStatements];
    [db close];
}
+(NSMutableArray*)getCodes:(BOOL)isCreated
{
    FMDatabase * db = [LYGDataBaseUIlti getSharedDB];
    [self createTable];
    [db open];
    [db setShouldCacheStatements:YES];
    [db executeQuery:@""];
    FMResultSet * resultset = nil;
    NSMutableArray * xxxx = [[NSMutableArray alloc]init];
    resultset = [db executeQuery:@"select * from TWODIMENSIONCODE where isCreated=? order by id DESC",[NSString stringWithFormat:@"%d",isCreated]];
    while ([resultset next]) {
        LYGTwoDimensionCodeModel * amode = [[LYGTwoDimensionCodeModel alloc]init];
        amode.createDate  = [resultset dateForColumn:@"createDate"];
        NSTimeZone * zone = [NSTimeZone systemTimeZone];
        NSInteger xxx  = [zone secondsFromGMT];
        amode.createDate  = [amode.createDate dateByAddingTimeInterval:xxx];
        amode.isSecret    = [resultset boolForColumn:@"isSecret"];
        amode.content     = [[[resultset stringForColumn:@"content"] componentsSeparatedByString:@""] objectAtIndex:0];
        amode.ID          = [resultset intForColumn:@"ID"];
        amode.type        = [resultset intForColumn:@"type"];
		amode.myType        = [resultset stringForColumn:@"myType"];
        amode.encryptedString = [resultset stringForColumn:@"encryptedString"];
        [xxxx addObject:amode];
        [amode release];        
    }
    [db clearCachedStatements];
    [db close];
    return xxxx;
}
+(void)deleteacode:(LYGTwoDimensionCodeModel*)acode
{
    FMDatabase * db = [LYGDataBaseUIlti getSharedDB];
    [self createTable];
    [db open];
    [db executeUpdate:@"delete from TWODIMENSIONCODE where id=?",[NSString stringWithFormat:@"%d",acode.ID]];
    [db close];
}
+(void)deleteCodes:(BOOL)isCreated
{
    FMDatabase * db = [LYGDataBaseUIlti getSharedDB];
    //[self createTable];
    [db open];
    [db executeUpdate:@"delete  from TWODIMENSIONCODE where isCreated=?",[NSString stringWithFormat:@"%d",isCreated]];
    [db clearCachedStatements];
    [db close];
}

@end
