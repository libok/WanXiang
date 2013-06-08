//
//  UICustomButton.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-5-27.
//
//

#import "UICustomButton.h"

@implementation UICustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_label1 release];
    [_label2 release];
    [_label3 release];
    [_myImageView release];
    [super dealloc];
}
@end
