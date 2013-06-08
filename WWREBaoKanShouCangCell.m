//
//  WWREBaoKanShouCangCell.m
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWREBaoKanShouCangCell.h"

@implementation WWREBaoKanShouCangCell

@synthesize leftImageView = _leftImageView;
@synthesize fgxImageView = _fgxImageView;
@synthesize detailTextView = _detailTextView;
@synthesize titleTextView = _titleTextView;
@synthesize dateLabel = _dateLabel;

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
	//防止删除按钮出现在textview的上面，盖住textview的内容
	if ((state &UITableViewCellStateShowingDeleteConfirmationMask)==UITableViewCellStateShowingDeleteConfirmationMask)
	{
		//点击删除按钮之前的frame(改变textview的宽度)
		self.titleTextView.frame = CGRectMake(102, 0, 130, 34);
		self.detailTextView.frame = CGRectMake(102, 27, 134, 63);
	}
	else 
	{
		//恢复点击删除按钮之前的frame（此处的值与自定义cell上的值一致）
		self.titleTextView.frame = CGRectMake(102, 0, 218, 34);
		self.detailTextView.frame = CGRectMake(102, 27, 218, 63);
	}
	
}

- (void)dealloc 
{
	[_leftImageView release];
	[_fgxImageView release];
	[_dateLabel release];
	[_detailTextView release];
	[_titleTextView release];
    [super dealloc];
}


@end
