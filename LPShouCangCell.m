//
//  LPShouCangCell.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-17.
//
//

#import "LPShouCangCell.h"

@implementation LPShouCangCell
@synthesize imgView = _imgView;
@synthesize titleLabel = _titleLabel;

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
    [_imgView release];
    [_titleLabel release];
    [super dealloc];
}
@end
