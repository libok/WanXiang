//
//  BYNJPDetailCell.m
//  wanxiangerweima
//
//  Created by usr on 13-4-23.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNJPDetailCell.h"


@implementation BYNJPDetailCell
@synthesize imgView = _imgView;
@synthesize titleLabel = _titleLabel;
@synthesize contentLabel = _contentLabel;
@synthesize addtimeLabel = _addtimeLabel;
@synthesize sortLabel = _sortLabel;
@synthesize urllinkLabel = _urllinkLabel;


-(void)dealloc
{
	[_imgView release];
	[_titleLabel release];
	[_contentLabel release];
	[_addtimeLabel release];
	[_sortLabel release];
	[_urllinkLabel release];
	[super dealloc];
}

@end
