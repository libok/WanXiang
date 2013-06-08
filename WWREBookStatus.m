//
//  WWREBookStatus.m
//  wanxiangerweima
//
//  Created by mac on 13-4-24.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWREBookStatus.h"
#import "LYGAppDelegate.h"

@implementation WWREBookStatus

+ (id)eBookWithDictionary:(NSDictionary *)eBookDictionary
{
	return [[[self alloc]initWithDictionary:eBookDictionary]autorelease];
}
- (id)initWithDictionary:(NSDictionary *)eBookDictionary
{
	if ([super init])
	{
		self.iD = [eBookDictionary objectForKey:@"id"];
		self.uID = [eBookDictionary objectForKey:@"uid"];
		self.bookID = [eBookDictionary objectForKey:@"bookid"];
		self.favBookID = [eBookDictionary objectForKey:@"favbookid"];
		self.title = [eBookDictionary objectForKey:@"title"];
		self.img = [eBookDictionary objectForKey:@"img"];
		self.contents = [eBookDictionary objectForKey:@"contents"];
		//self.addTime = [eBookDictionary objectForKey:@"addtime"];
        self.addTime   = [LYGAppDelegate getTimeDate:[eBookDictionary objectForKey:@"addtime"]];
	}
	return self;
}


- (void)dealloc
{
	[_iD release];
	[_uID release];
	[_bookID release];
	[_favBookID release];
	[_title release];
	[_img release];
	[_contents release];
	[_addTime release];
	
	[super dealloc];
}


@end
