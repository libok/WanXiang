//
//  LFTextTableCell.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-15.
//
//

#import "LFTextTableCell.h"

@implementation LFTextTableCell
@synthesize cotentsBgImgView;
@synthesize titleLabel;
@synthesize datelineLabel;
@synthesize ADimgView;
@synthesize contentsTextView;

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
    [cotentsBgImgView release];
    [titleLabel release];
    [datelineLabel release];
    [ADimgView release];
    [contentsTextView release];
    [super dealloc];
}
@end
