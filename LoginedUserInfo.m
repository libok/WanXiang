//
//  LoginedUserInfo.m
//  wanxiangerweima
//
//  Created by  on 13-4-23.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LoginedUserInfo.h"

@implementation LoginedUserInfo
@synthesize ID = _ID;
@synthesize pwd = _pwd;
@synthesize group_id = _group_id;
@synthesize nick_name = _nick_name;
@synthesize email = _email;
@synthesize clientID = _clientID;
@synthesize phone = _phone;


-(void)dealloc
{
	[_pwd release];
	[_nick_name release];
	[_group_id release];
	[_email release];
	[_clientID release];
	[_phone release];
	[super dealloc];
}

@end
