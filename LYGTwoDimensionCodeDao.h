//
//  LYGTwoDimensionCodeDao.h
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYGDataBaseUIlti.h"
#import "LYGTwoDimensionCodeModel.h"
@interface LYGTwoDimensionCodeDao : NSObject
+(void)insert:(LYGTwoDimensionCodeModel*)acode;
+(NSMutableArray*)getCodes:(BOOL)isCreated;
+(void)deleteacode:(LYGTwoDimensionCodeModel*)acode;
+(void)deleteCodes:(BOOL)isCreated;
@end
