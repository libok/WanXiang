//
//  BYNUserCenter.m
//  wanxiangerweima
//
//  Created by usr on 13-4-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNUserCenter.h"


@implementation BYNUserCenter
@synthesize newsID = _newsID;
@synthesize title = _title;
@synthesize contents = _contents;


-(id)initWithDictionary:(NSDictionary *)aboutUsDictionary
{
	if (self = [super init]) 
	{
		self.newsID = [aboutUsDictionary objectForKey:@"id"];
		self.title = [aboutUsDictionary objectForKey:@"Title"];
		self.contents = [aboutUsDictionary objectForKey:@"Contents"];
		
	}
	
	return self;
}

+ (id)aboutUsWithDictionary:(NSDictionary *)aboutUsDictionary
{
	return [[[self alloc] initWithDictionary:aboutUsDictionary] autorelease];
}



-(void)dealloc
{

	[_newsID release];
	[_title release];
	[_contents release];
	[super dealloc];
}

@end
