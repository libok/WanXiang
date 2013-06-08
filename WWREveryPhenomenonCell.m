//
//  WWREveryPhenomenonCell.m
//  wanxiangerweima
//
//  Created by mac on 13-4-2.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWREveryPhenomenonCell.h"

@implementation WWREveryPhenomenonCell
@synthesize ePCellLabel = _ePCellLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc 
{
	[_ePCellLabel release];
    [_numLabel release];
    [super dealloc];
}


@end
