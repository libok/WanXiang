//
//  BYNMemberManagementCell.m
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNMemberManagementCell.h"


@implementation BYNMemberManagementCell

@synthesize memberLabel = _memberLabel;
@synthesize cancelBtn = _cancelBtn;


- (void)dealloc 
{
	[_memberLabel release];
	[_cancelBtn release];
    [super dealloc];
}


@end
