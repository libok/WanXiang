//
//  WWRYHLFatherCell.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRYHLFatherCell.h"

@implementation WWRYHLFatherCell

@synthesize typeImageView = _typeImageView;
@synthesize erWeiMaImageView = _erWeiMaImageView;
@synthesize goodNameLabel = _goodNameLabel;
@synthesize goodTypeLabel = _goodTypeLabel;
@synthesize goodStateLabel = _goodStateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc 
{
	[_typeImageView release];
	[_erWeiMaImageView release];
	[_goodNameLabel release];
	[_goodTypeLabel release];
	[_goodStateLabel release];
    [super dealloc];
}


@end
