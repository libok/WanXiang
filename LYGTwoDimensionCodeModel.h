//
//  LYGTwoDimensionCodeModel.h
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYGTwoDimensionCodeModel : NSObject
{
    
}
@property(nonatomic,retain)NSDate   * createDate;
@property(nonatomic,assign)BOOL     isCreated;
@property(nonatomic,assign)BOOL     isSecret;
@property(nonatomic,assign)int      type;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * myType;
@property(nonatomic,assign)int      ID;
@property(nonatomic,copy) NSString * encryptedString;
@property(nonatomic,retain)UIImage * erweimaImage;

@end
