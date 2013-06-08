//
//  LPShangjiaCell.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-20.
//
//

#import "LPShangjiaCell.h"

@implementation LPShangjiaCell
@synthesize title = _title;
@synthesize location= _location;
@synthesize telephone = _telephone;
@synthesize qq = _qq;
@synthesize info = _info;
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
    [_title release];
    [_location release];
    [_telephone release];
    [_qq release];
    [_info release];
    [super dealloc];
}
@end
