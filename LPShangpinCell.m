//
//  LPShangpinCell.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-20.
//
//

#import "LPShangpinCell.h"

@implementation LPShangpinCell
@synthesize yhprice = _yhprice;
@synthesize yhprice2 = _yhprice2;
@synthesize price = _price;
@synthesize price2 = _price2;
@synthesize commodity1 = _commodity1;
@synthesize commodity21 = _commodity21;
@synthesize imgView1 = _imgView1;
@synthesize imgView2 = _imgView2;

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
    [_yhprice release];
    [_price release];
    [_commodity1 release];
    [_yhprice2 release];
    [_price2 release];
    [_commodity21 release];
    [_imgView1 release];
    [_imgView2 release];
    [super dealloc];
}
@end
