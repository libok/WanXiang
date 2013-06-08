//
//  LPAdCell.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-9.
//
//

#import "LPAdCell.h"

@implementation LPAdCell
 
@synthesize imgView = _imgView;
@synthesize titleLabel  = _titleLabel;
@synthesize contentTextView = _contentTextView;
@synthesize classLabel = _classLabel;
@synthesize label = _label;

- (void)dealloc {
    [_imgView release];
    [_titleLabel release];
    [_contentTextView release];
    [_classLabel release];
    [_label release];
    [super dealloc];
}

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

@end
