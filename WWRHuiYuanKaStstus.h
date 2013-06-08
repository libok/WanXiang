//
//  WWRHuiYuanKaStstus.h
//  wanxiangerweima
//
//  Created by mac on 13-4-19.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWRHuiYuanKaStstus : NSObject 
{
	NSString  *_managerID;
	NSString  *_userID;
	NSString  *_point;
	NSString  *_iD;
	NSString  *_nickName;
	NSString  *_sortName;
	NSString  *_phone;
	NSString  *_adress;
	NSString  *_suid;
	NSString  *_sortContents;  
	NSString  *_huikantime;
	NSString  *_sortImg;
	NSString  *_groupID;

}

@property (nonatomic,copy) NSString  *managerID;
@property (nonatomic,copy) NSString  *userID;
@property (nonatomic,copy) NSString  *point;
@property (nonatomic,copy) NSString  *iD;
@property (nonatomic,copy) NSString  *nickName;
@property (nonatomic,copy) NSString  *sortName;
@property (nonatomic,copy) NSString  *phone;
@property (nonatomic,copy) NSString  *adress;
@property (nonatomic,copy) NSString  *suid;
@property (nonatomic,copy) NSString  *sortContents;
@property (nonatomic,copy) NSString  *huikantime;
@property (nonatomic,copy) NSString  *sortImg;
@property (nonatomic,copy) NSString  *groupID;

+ (id)huiYuanKaWithDictionary:(NSDictionary *)huiYuanKaDictionary;
- (id)initWithDictionary:(NSDictionary *)huiYuanKaDictionary;

@end
