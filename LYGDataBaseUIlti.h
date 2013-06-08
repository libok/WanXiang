//
//  LYGDataBaseUIlti.h
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface LYGDataBaseUIlti : NSObject
+(FMDatabase*)getSharedDB;
+(NSString *)dbFilePath;
+(NSString*)getsandbox;
@end
