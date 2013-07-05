//
//  LYGTwoDimensionCodeModel.m
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGTwoDimensionCodeModel.h"

@implementation LYGTwoDimensionCodeModel
@synthesize      createDate = _createDate;
@synthesize      myType = _myType;
@synthesize      isSecret   = _isSecret;
@synthesize       isCreated = _isCreated;
@synthesize      erweimaImage = _erweimaImage;
@synthesize            type = _type;
@synthesize         content = _content;
@synthesize              ID = _ID;
@synthesize encryptedString = _encryptedString;
-(NSString*)description
{
    NSString * string  = [NSString stringWithFormat:@"%d %@ %d %d %@ %@ %@",self.type,self.createDate,self.isSecret,self.isCreated,self.erweimaImage,self.content,self.encryptedString];
    return string;
}
@end
