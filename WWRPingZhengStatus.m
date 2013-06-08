//
//  WWRPingZhengStatus.m
//  wanxiangerweima
//
//  Created by mac on 13-4-8.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRPingZhengStatus.h"
#import "LYGAppDelegate.h"

@implementation WWRPingZhengStatus

@synthesize iD = _iD;
@synthesize updateTime = _updateTime;
@synthesize zhiFuNO = _zhiFuNO;
@synthesize managerID = _managerID;
@synthesize goodID = _goodID;
@synthesize odID = _odID;
@synthesize orderID = _orderID;
@synthesize imgURL = _imgURL;
@synthesize addTime = _addTime;
@synthesize goodsID = _goodsID;
@synthesize uID = _uID;
@synthesize status = _status;
@synthesize price = _price;
@synthesize title = _title;
@synthesize orderNO = _orderNO;


+ (id)dianZiPingZhengWithDictionary:(NSDictionary *)dianZiPingZhengDictionary
{
	return [[[self alloc] initWithDictionary:dianZiPingZhengDictionary] autorelease];
}
- (id)initWithDictionary:(NSDictionary *)dianZiPingZhengDictionary
{
	if (self = [super init])
	{
		self.iD = [dianZiPingZhengDictionary objectForKey:@"id"];
		self.updateTime = [dianZiPingZhengDictionary objectForKey:@"updatetime"];
		self.zhiFuNO = [dianZiPingZhengDictionary objectForKey:@"zhifuNO"];
		self.managerID = [dianZiPingZhengDictionary objectForKey:@"managerid"];
		self.goodID = [dianZiPingZhengDictionary objectForKey:@"goodid"];
		self.odID = [dianZiPingZhengDictionary objectForKey:@"ODID"];
		self.orderID = [dianZiPingZhengDictionary objectForKey:@"orderid"];
		self.imgURL = [dianZiPingZhengDictionary objectForKey:@"imgurl"];
        self.addTime     = [[[LYGAppDelegate getTimeDate:[dianZiPingZhengDictionary objectForKey:@"addtime"]] description] substringToIndex:19];
        
		//self.addTime = [dianZiPingZhengDictionary objectForKey:@"addtime"];
        //NSLog(@"%@",self.addTime);
		self.goodsID = [dianZiPingZhengDictionary objectForKey:@"goodsid"];
		self.uID = [dianZiPingZhengDictionary objectForKey:@"uid"];
		self.status = [dianZiPingZhengDictionary objectForKey:@"status"];
		self.price = [dianZiPingZhengDictionary objectForKey:@"price"];
		self.title = [dianZiPingZhengDictionary objectForKey:@"Title"];
		self.orderNO = [dianZiPingZhengDictionary objectForKey:@"orderNO"];
	
	}
	return self;
	
}


- (void)dealloc
{
	[_iD release];
	[_updateTime release];
	[_zhiFuNO release];
	[_odID release];
	[_orderID release];
	[_managerID release];
	[_uID release];
	[_addTime release];
	[_goodID release];
	[_goodsID release];
	[_imgURL release];
	[_status release];
	[_price release];
	[_title release];
	[_orderNO release];
	
	[super dealloc];
}


@end
