//
//  MyTableView.m
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-10.
//
//

#import "MyTableView.h"

@implementation MyTableView

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

- (IBAction)buttonClick:(id)sender {
    int x = ((UIButton*)sender).tag;
    //[self.delegate setindex:x];LP
    self.oneBlock(x);
}
- (void)dealloc {
    [_myInDicatorView release];
    [super dealloc];
}
@end
