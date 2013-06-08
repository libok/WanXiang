//
//  LFReplyTableCell.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-16.
//
//

#import "LFReplyTableCell.h"

@implementation LFReplyTableCell
@synthesize messageBgimgView;
@synthesize usrNameLabel;
@synthesize messagetimeLabel;
@synthesize messagecontentsLabel;

@synthesize replyGgimgView;
@synthesize aNewReplyLabel;
@synthesize merchantNameLabel;
@synthesize replyTimeLabel;
@synthesize replyCotentsLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [messageBgimgView release];
    [usrNameLabel release];
    [messagetimeLabel release];
    [messagecontentsLabel release];
    [replyGgimgView release];
    [aNewReplyLabel release];
    [merchantNameLabel release];
    [replyTimeLabel release];
    [replyCotentsLabel release];
    [super dealloc];
}
@end
