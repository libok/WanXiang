//
//  WWRStatus.h
//  wanxiangerweima
//
//  Created by mac on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWRStatus : NSObject 
{
	NSString  *_iD;
	NSString  *_uID;
	NSString  *_managerID;
	NSString  *_goodID;
	NSString  *_gID;
	NSString  *_imgURl;
	NSString  *_addTime;
	NSString  *_type;
	NSString  *_status;
	NSString  *_okTime;
	NSString  *_isShow;
	NSString  *_title;  
	NSString  *_shangJia;
	NSString  *_precontent;
	NSString  *_useTime;
	NSString  *_adress;
	NSString  *_jianJie;

}

@property (nonatomic,copy) NSString  *iD;
@property (nonatomic,copy) NSString  *uID;
@property (nonatomic,copy) NSString  *managerID;
@property (nonatomic,copy) NSString  *goodID;
@property (nonatomic,copy) NSString  *gID;
@property (nonatomic,copy) NSString  *imgURl;
@property (nonatomic,copy) NSString  *addTime;
@property (nonatomic,copy) NSString  *type;
@property (nonatomic,copy) NSString  *status;
@property (nonatomic,copy) NSString  *okTime;
@property (nonatomic,copy) NSString  *isShow;
@property (nonatomic,copy) NSString  *title;
@property (nonatomic,copy) NSString  *shangJia;
@property (nonatomic,copy) NSString  *precontent;
@property (nonatomic,copy) NSString  *useTime;
@property (nonatomic,copy) NSString  *adress;
@property (nonatomic,copy) NSString  *jianJie;
@property (nonatomic,copy) NSString  *url;
@property (nonatomic,copy) NSString  *content;
@property (nonatomic,copy) NSString  *contents;
+ (id)youHuiQuanWithDictionary:(NSDictionary *)youHuiQuanDictionary;
- (id)initWithDictionary:(NSDictionary *)youHuiQuanDictionary;


@end
