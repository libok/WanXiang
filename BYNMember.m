//
//  BYNMember.m
//  wanxiangerweima
//
//  Created by usr on 13-4-20.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//



#import "BYNMember.h"


@implementation BYNMember
@synthesize uID = _uID;
@synthesize name = _name;
@synthesize suid = _suid;

-(id)initWithDictionary:(NSDictionary *)memberDictionary
{
	if (self = [super init]) 
	{
		self.uID = [memberDictionary objectForKey:@"id"];
		self.name = [memberDictionary objectForKey:@"NickName"];
		self.suid = [memberDictionary objectForKey:@"suid"];		
	}
	
	return self;
}

+ (id)memberWithDictionary:(NSDictionary *)memberDictionary
{
	return [[[self alloc] initWithDictionary:memberDictionary] autorelease];
}


-(void)dealloc
{
	[_uID release];
	[_name release];
	[_suid release];
	[super dealloc];
}




@end
