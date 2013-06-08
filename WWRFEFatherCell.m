//
//  WWRFEFatherCell.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRFEFatherCell.h"

@implementation WWRFEFatherCell

@synthesize erWeiMaImageView = _erWeiMaImageView;
@synthesize goodDetailTextView = _goodDetailTextView;
@synthesize dateLabel = _dateLabel;
@synthesize usedStateLabel = _usedStateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)didTransitionToState:(UITableViewCellStateMask)state
{
	if ((state &UITableViewCellStateShowingDeleteConfirmationMask)==UITableViewCellStateShowingDeleteConfirmationMask)
	{
		self.goodDetailTextView.frame = CGRectMake(72, 1, 150, 49);
		self.usedStateLabel.frame = CGRectMake(180, 45, 62, 30);
	}
	else 
	{
		self.goodDetailTextView.frame = CGRectMake(72, 1, 245, 49);
		self.usedStateLabel.frame = CGRectMake(243, 45, 62, 30);
	}
	
}

- (void)dealloc 
{
	[_erWeiMaImageView release];
	[_dateLabel release];
	[_goodDetailTextView release];
	[_usedStateLabel release];
    [super dealloc];
}


@end
