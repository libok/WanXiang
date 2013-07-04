//
//  WWRStatus.m
//  wanxiangerweima
//
//  Created by mac on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRStatus.h"


@implementation WWRStatus
@synthesize iD = _iD;
@synthesize uID = _uID;
@synthesize managerID = _managerID;
@synthesize goodID = _goodID;
@synthesize gID = _gID;
@synthesize imgURl = _imgURl;
@synthesize addTime = _addTime;
@synthesize type = _type;
@synthesize status = _status;
@synthesize okTime = _okTime;
@synthesize isShow = _isShow;
@synthesize title = _title;
@synthesize shangJia = _shangJia;
@synthesize precontent = _precontent;
@synthesize useTime = _useTime;
@synthesize adress = _adress;
@synthesize jianJie = _jianJie;
@synthesize meetTime;
@synthesize meetAdd;
@synthesize meetCon;


+ (id)youHuiQuanWithDictionary:(NSDictionary *)youHuiQuanDictionary
{
    NSLog(@"%@",youHuiQuanDictionary);
	return [[[self alloc] initWithDictionary:youHuiQuanDictionary] autorelease];
}

- (id)initWithDictionary:(NSDictionary *)youHuiQuanDictionary
{
    NSLog(@"%@",youHuiQuanDictionary);
	if (self = [super init])
	{
		self.iD = [youHuiQuanDictionary objectForKey:@"id"];
		self.uID = [youHuiQuanDictionary objectForKey:@"uid"];
		self.managerID = [youHuiQuanDictionary objectForKey:@"manageriD"];
		self.goodID = [youHuiQuanDictionary objectForKey:@"goodid"];
		self.gID = [youHuiQuanDictionary objectForKey:@"gid"];
		self.imgURl = [youHuiQuanDictionary objectForKey:@"imgurl"];
        if (self.imgURl == nil || self.imgURl.length == 0) {
            self.imgURl = [youHuiQuanDictionary objectForKey:@"qrimg"];
        }
		self.addTime = [youHuiQuanDictionary objectForKey:@"addtime"];
		self.type = [youHuiQuanDictionary objectForKey:@"type"];
		self.status = [youHuiQuanDictionary objectForKey:@"Status"];
		self.okTime = [youHuiQuanDictionary objectForKey:@"OKtime"];
		self.isShow = [youHuiQuanDictionary objectForKey:@"isshow"];
		self.title = [youHuiQuanDictionary objectForKey:@"title"];
        if (self.title == nil || self.title.length == 0) {
            self.title = [youHuiQuanDictionary objectForKey:@"shangjia"];
        }

		self.shangJia = [youHuiQuanDictionary objectForKey:@"shangjia"];
		self.precontent = [youHuiQuanDictionary objectForKey:@"precontent"];
		self.useTime = [youHuiQuanDictionary objectForKey:@"usetime"];
		self.adress = [youHuiQuanDictionary objectForKey:@"adress"];
		self.jianJie = [youHuiQuanDictionary objectForKey:@"jianjie"];
		self.url     = [youHuiQuanDictionary objectForKey:@"imgurl"];
        if (self.url == nil || self.url.length == 0) {
            self.url = [youHuiQuanDictionary objectForKey:@"qrimg"];
        }
        self.content = [youHuiQuanDictionary objectForKey:@"content"];
        self.contents = [youHuiQuanDictionary objectForKey:@"contents"];
        
        self.meetTime = [[youHuiQuanDictionary objectForKey:@"shijian"] isEqual:[NSNull null]]?@"":[youHuiQuanDictionary objectForKey:@"shijian"];
        self.meetAdd =[[youHuiQuanDictionary objectForKey:@"address"] isEqual:[NSNull null]]?@"":[youHuiQuanDictionary objectForKey:@"address"];
        self.meetCon = [[youHuiQuanDictionary objectForKey:@"phone"] isEqual:[NSNull null]]?@"":[youHuiQuanDictionary objectForKey:@"phone"];
	}
	return self;
}


- (void)dealloc
{
	[_iD release];
	[_uID release];
	[_managerID release];
	[_goodID release];
	[_gID release];
	[_imgURl release];
	[_addTime release];
	[_type release];
	[_status release];
	[_okTime release];
	[_isShow release];
	[_title release];
	[_shangJia release];
	[_precontent release];
	[_useTime release];
	[_adress release];
	[_jianJie release];
	
	[super dealloc];
}



@end
