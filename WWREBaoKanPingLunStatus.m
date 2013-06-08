//
//  WWREBaoKanPingLunStatus.m
//  LPTest
//
//  Created by mac on 13-4-26.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWREBaoKanPingLunStatus.h"


@implementation WWREBaoKanPingLunStatus
@synthesize iD = _iD;
@synthesize uID = _uID;
@synthesize contents = _contents;
@synthesize addtime = _addtime;
@synthesize replaycon = _replaycon;
@synthesize userName = _userName;
@synthesize shopName = _shopName;
@synthesize reptime = _reptime;
@synthesize bookID = _bookID;
@synthesize managerID = _managerID;

+ (id)eBookMsgWithDictionary:(NSDictionary *)eBookMsgDictionary
{
	return [[[self alloc] initWithDictionary:eBookMsgDictionary] autorelease];
}
- (id)initWithDictionary:(NSDictionary *)eBookMsgDictionary
{
	if (self = [super init])
	{
		self.iD = [eBookMsgDictionary objectForKey:@"ID"];
		self.uID = [eBookMsgDictionary objectForKey:@"uid"];
		self.contents = [eBookMsgDictionary objectForKey:@"contents"];
		self.addtime = [eBookMsgDictionary objectForKey:@"addtime"];
		self.replaycon = [eBookMsgDictionary objectForKey:@"replaycon"];
		self.userName = [eBookMsgDictionary objectForKey:@"username"];
		self.shopName = [eBookMsgDictionary objectForKey:@"shopname"];
		self.reptime = [eBookMsgDictionary objectForKey:@"reptime"];
		self.bookID = [eBookMsgDictionary objectForKey:@"bookid"];
		self.managerID = [eBookMsgDictionary objectForKey:@"managerid"];
	}
	return self;
}


- (void)dealloc
{
	[_iD release];
	[_uID release];
	[_contents release];
	[_addtime release];
	[_replaycon release];
	[_userName release];
	[_shopName release];
	[_reptime release];
	[_bookID release];
	[_managerID release];
	[super dealloc];
}



@end
