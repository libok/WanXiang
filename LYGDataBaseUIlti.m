//
//  LYGDataBaseUIlti.m
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGDataBaseUIlti.h"
#import "FMDatabase.h"
static FMDatabase * DB = nil;
@implementation LYGDataBaseUIlti
+(NSString *)dbFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"database.sqlite"];
    
    return filePath;
}
+(NSString*)getsandbox
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
+(FMDatabase*)getSharedDB
{
    @synchronized(self)
    {
        if (!DB) {
            DB = [[FMDatabase databaseWithPath:[self dbFilePath]] retain];
        }
    }
    return DB;
}




@end
