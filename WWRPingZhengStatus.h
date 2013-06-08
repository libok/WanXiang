//
//  WWRPingZhengStatus.h
//  wanxiangerweima
//
//  Created by mac on 13-4-8.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWRPingZhengStatus : NSObject 
{
	NSString    *_iD;
	NSString    *_updateTime;
	NSString    *_zhiFuNO;
	NSString    *_odID;
	NSString    *_orderID;
	NSString    *_managerID;
	NSString    *_uID;
	NSString    *_status;
	NSString    *_addTime;
	NSString    *_price;
	NSString    *_goodID;
	NSString    *_goodsID;
	NSString    *_title;
	NSString    *_imgURL;
	NSString    *_orderNO;

}

@property (nonatomic,copy) NSString  *iD;
@property (nonatomic,copy) NSString  *updateTime;
@property (nonatomic,copy) NSString  *zhiFuNO;
@property (nonatomic,copy) NSString  *odID;
@property (nonatomic,copy) NSString  *orderID;
@property (nonatomic,copy) NSString  *managerID;
@property (nonatomic,copy) NSString  *uID;
@property (nonatomic,copy) NSString  *status;
@property (nonatomic,copy) NSString  *addTime;
@property (nonatomic,copy) NSString  *price;
@property (nonatomic,copy) NSString  *goodID;
@property (nonatomic,copy) NSString  *goodsID;
@property (nonatomic,copy) NSString  *title;
@property (nonatomic,copy) NSString  *imgURL;
@property (nonatomic,copy) NSString  *orderNO;


+ (id)dianZiPingZhengWithDictionary:(NSDictionary *)dianZiPingZhengDictionary;
- (id)initWithDictionary:(NSDictionary *)dianZiPingZhengDictionary;

@end
