//
//  BYNLogin.m
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNLogin.h"


@implementation BYNLogin
@synthesize ID = _ID;
@synthesize pwd = _pwd;
@synthesize group_id = _group_id;
@synthesize nick_name = _nick_name;
@synthesize email = _email;
@synthesize clientID = _clientID;
@synthesize phone = _phone;

-(id)initWithDictionary:(NSDictionary *)userInfoDictionary
{
	if (self = [super init]) 
	{
		self.ID = [userInfoDictionary objectForKey:@"id"];
		self.nick_name = [userInfoDictionary objectForKey:@"NickName"];
		self.pwd = [userInfoDictionary objectForKey:@"Pwd"];
		self.group_id = [userInfoDictionary objectForKey:@"group_id"];
		self.email = [userInfoDictionary objectForKey:@"email"];
		self.clientID = [userInfoDictionary objectForKey:@"ClientID"];
		self.phone = [userInfoDictionary objectForKey:@"Phone"];
		
	}
	
	return self;
	
}
+ (id)userInfoWithDictionary:(NSDictionary *)userInfoDictionary
{
	return [[[self alloc] initWithDictionary:userInfoDictionary] autorelease];
}

-(void)dealloc
{
	[_ID release];
	[_pwd release];
	[_group_id release];
	[_nick_name release];
	[_email release];
	[_clientID release];
	[_phone release];
	[super dealloc];
}

@end
