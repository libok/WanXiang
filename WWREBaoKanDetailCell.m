//
//  WWREBaoKanDetailCell.m
//  LPTest
//
//  Created by mac on 13-4-26.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWREBaoKanDetailCell.h"


@implementation WWREBaoKanDetailCell

@synthesize userName = _userName;
@synthesize userMessageDate = _userMessageDate;
@synthesize userMessage = _userMessage;
@synthesize goodAnswerDate = _goodAnswerDate;
@synthesize goodAnswer =_goodAnswer;

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


- (void)dealloc 
{
	[_userName release];
	[_userMessageDate release];
	[_userMessage release];
	[_goodAnswerDate release];
	[_goodAnswer release];
	
    [_view1 release];
    [_view2 release];
    [super dealloc];
}


@end
