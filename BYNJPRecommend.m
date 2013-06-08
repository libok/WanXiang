//
//  BYNJPRecommend.m
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNJPRecommend.h"


@implementation BYNJPRecommend
@synthesize ID = _ID;
@synthesize classname = _classname;
@synthesize jpID = _jpID;
@synthesize imgUrl = _imgUrl;
@synthesize name = _name;
@synthesize contents = _contents;
@synthesize addtime = _addtime;
@synthesize urllink = _urllink;
@synthesize sort = _sort;

-(id)initWithDictionary:(NSDictionary *)jpDictionary
{
	if (self = [super init]) 
	{
		self.ID = [jpDictionary objectForKey:@"id"];
		self.classname = [jpDictionary objectForKey:@"classname"];
		self.jpID = [jpDictionary objectForKey:@"id"];
		self.imgUrl = [jpDictionary objectForKey:@"imgurl"];
		self.name = [jpDictionary objectForKey:@"name"];
		self.contents = [jpDictionary objectForKey:@"contents"];
		self.addtime = [jpDictionary objectForKey:@"addtime"];
		self.sort = [jpDictionary objectForKey:@"sort"];
		self.urllink =[jpDictionary objectForKey:@"urllink"];
	}
	
	return self;
}

+ (id)jpWithDictionary:(NSDictionary *)jpDictionary
{
	return [[[self alloc] initWithDictionary:jpDictionary] autorelease];
}



-(void)dealloc
{
	
	[_ID release];
	[_classname release];
	[_jpID release];
	[_imgUrl release];
	[_name release];
	[_contents release];
	[_addtime release];
	[_sort release];
	[_urllink release];
	[super dealloc];
}

@end
