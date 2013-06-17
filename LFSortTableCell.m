//
//  LFSortTableCell.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-8.
//
//

#import "LFSortTableCell.h"

@implementation LFSortTableCell
@synthesize sortBgCell;
@synthesize sortImgView;
@synthesize sortNameLabel;
@synthesize sortContents;
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
    [sortBgCell release];
    [sortImgView release];
    [sortNameLabel release];
    [sortContents release];
    [_orderButton release];
    [super dealloc];
}
- (IBAction)downloadBtn:(id)sender
{
    
    
}
@end
