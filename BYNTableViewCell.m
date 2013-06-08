//
//  BYNTableViewCell.m
//  Test
//
//  Created by usr on 13-4-2.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNTableViewCell.h"


@implementation BYNTableViewCell

@synthesize bgImageView = _bgImageView;
@synthesize contentLabel = _contentLabel;

-(void)dealloc
{
	[_bgImageView release];
	[_contentLabel release];
	[super dealloc];
}


@end
