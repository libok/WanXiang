//
//  WWRLiPinQuanStatus.m
//  wanxiangerweima
//
//  Created by mac on 13-4-22.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRLiPinQuanStatus.h"


@implementation WWRLiPinQuanStatus
@synthesize iD = _iD;
@synthesize managerID = _managerID;
@synthesize managerName = _managerName;
@synthesize adress = _adress;
@synthesize remark = _remark;
@synthesize tag = _tag;
@synthesize contents = _contents;
@synthesize addTime = _addTime;
@synthesize endTime = _endTime;
@synthesize qRImg = _qRImg;
@synthesize title = _title;
@synthesize lid = _lid;
@synthesize uid = _uid;
@synthesize status = _status;

+ (id)liPinQuanWithDictionary:(NSDictionary *)liPinQuanDictionary
{
	
	return [[[self alloc]initWithDictionary:liPinQuanDictionary]autorelease];
}
- (id)initWithDictionary:(NSDictionary *)liPinQuanDictionary
{
	if ([super init])
	{
		self.iD = [liPinQuanDictionary objectForKey:@"id"];
		self.managerID = [liPinQuanDictionary objectForKey:@"managerid"];
		self.managerName = [liPinQuanDictionary objectForKey:@"managername"];
		self.adress = [liPinQuanDictionary objectForKey:@"adress"];
		self.remark = [liPinQuanDictionary objectForKey:@"remark"];
		self.tag = [liPinQuanDictionary objectForKey:@"tag"];
		self.contents = [liPinQuanDictionary objectForKey:@"contents"];
		self.addTime = [liPinQuanDictionary objectForKey:@"addtime"];
		self.endTime = [liPinQuanDictionary objectForKey:@"endtime"];
		self.qRImg = [liPinQuanDictionary objectForKey:@"QRimg"];
		self.title = [liPinQuanDictionary objectForKey:@"title"];
		self.lid = [liPinQuanDictionary objectForKey:@"lid"];
		self.uid = [liPinQuanDictionary objectForKey:@"uid"];
		self.status = [liPinQuanDictionary objectForKey:@"status"];
	}
	return self;
}

- (void)dealloc
{
	[_iD release];
	[_managerID release];
	[_managerName release];
	[_adress release];
	[_remark release];
	[_tag release];
	[_contents release];
	[_addTime release];
	[_endTime release];
	[_qRImg release];
	[_title release];
	[_lid release];
	[_uid release];
	[_status release];
	[super dealloc];
}

@end
