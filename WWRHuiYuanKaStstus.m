//
//  WWRHuiYuanKaStstus.m
//  wanxiangerweima

//

#import "WWRHuiYuanKaStstus.h"


@implementation WWRHuiYuanKaStstus
@synthesize managerID = _managerID;
@synthesize userID = _userID;
@synthesize point = _point;
@synthesize iD = _iD;
@synthesize nickName = _nickName;
@synthesize sortName = _sortName;
@synthesize phone = _phone;
@synthesize adress = _adress;
@synthesize suid = _suid;
@synthesize sortContents = _sortContents;
@synthesize huikantime = _huikantime;
@synthesize sortImg = _sortImg;
@synthesize groupID = _groupID;

+ (id)huiYuanKaWithDictionary:(NSDictionary *)huiYuanKaDictionary
{
	return [[[self alloc] initWithDictionary:huiYuanKaDictionary] autorelease];
}
- (id)initWithDictionary:(NSDictionary *)huiYuanKaDictionary
{
	if (self = [super init])
	{
		self.managerID = [huiYuanKaDictionary objectForKey:@"mangerid"];
		self.userID = [huiYuanKaDictionary objectForKey:@"userId"];
		self.point = [huiYuanKaDictionary objectForKey:@"Point"];
		self.iD = [huiYuanKaDictionary objectForKey:@"id"];
		self.nickName = [huiYuanKaDictionary objectForKey:@"NickName"];
		self.sortName = [huiYuanKaDictionary objectForKey:@"sortname"];
		self.phone = [huiYuanKaDictionary objectForKey:@"phone"];
		self.adress = [huiYuanKaDictionary objectForKey:@"adress"];
		self.suid = [huiYuanKaDictionary objectForKey:@"suid"];
		self.sortContents = [huiYuanKaDictionary objectForKey:@"sortContents"];
		self.huikantime = [huiYuanKaDictionary objectForKey:@"huikantime"];
		self.sortImg = [huiYuanKaDictionary objectForKey:@"sortimg"];
		self.groupID = [huiYuanKaDictionary objectForKey:@"groupid"];
	}
	return self;
	
}

- (void)dealloc
{
	[_managerID release];
	[_userID release];
	[_point release];
	[_iD release];
	[_nickName release];
	[_sortName release];
	[_phone release];
	[_adress release];
	[_suid release];
	[_sortContents release];  
	[_huikantime release];
	[_sortImg release];
    [_groupID release];
	[super dealloc];
}

@end
