//
//  BYNJPDetailCell.m
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNJPDetailCell.h"


@implementation BYNJPDetailCell



-(void)dealloc
{
	[_imgView2 release];
	[_titleLabel release];
	[_contentLabel release];
	[_addtimeLabel release];
	[_sortLabel release];
	[_urllinkLabel release];
	[super dealloc];
}

@end
