//
//  LygMyTableViewCell.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-13.
//
//

#import "LygMyTableViewCell.h"

@implementation LygMyTableViewCell

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
    [_label release];
    //[_label release];
    //[_imageView release];
    [_textView release];
    [_myContentImageView release];
    [super dealloc];
}
@end
