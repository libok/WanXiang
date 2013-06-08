//
//  LFMakeAMsgCell.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-16.
//
//

#import "LFMakeAMsgCell.h"

@implementation LFMakeAMsgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.superview.bounds];
        imgView.image = [UIImage imageNamed:@"会刊6-商家回复背景.png"];
        [self.superview addSubview:imgView];
            
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
