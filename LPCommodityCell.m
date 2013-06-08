//
//  LPCommodityCell.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-11.
//
//

#import "LPCommodityCell.h"

@implementation LPCommodityCell
@synthesize imgView = _imgView;
@synthesize infoLabel = _infoLabel;
@synthesize price2 = _price2;
@synthesize price = _price;
@synthesize classLabel = _classLabel;

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
    [_infoLabel release];
    [_price release];
    [_price2 release];
    [_classLabel release];
    [super dealloc];
}
@end
