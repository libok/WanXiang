//
//  LPWareModel.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-26.
//
//

#import "LPWareModel.h"

@implementation LPWareModel
@synthesize price = _price;
@synthesize price1 = _price1;
@synthesize yhprice = _yhprice;
@synthesize info = _info;
@synthesize title = _title;
@synthesize number = _number;
@synthesize size = _size;
@synthesize imgList = _imgList;
- (void)dealloc
{
    [_imgList release];
    [_title release];
    [_info release];
    [_price1 release];
    [_price release];
    [_yhprice release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)adic number:(int)aNumb size:(int)aSize
{
    if (self = [super init]) {
        self.imgList = [adic valueForKey:@"imglist"];
        self.price = [NSString stringWithFormat:@"%@",[adic valueForKey:@"price"] ];
        self.price1 = [NSString stringWithFormat:@"%@", [adic valueForKey:@"price1"] ];
        self.yhprice = [NSString stringWithFormat:@"%@",[adic valueForKey:@"yhprice"]];
        self.info = [NSString stringWithFormat:@"%@",[adic valueForKey:@"info"] ];
        self.title = [NSString stringWithFormat:@"%@",[adic valueForKey:@"Title"] ];
        self.number = aNumb;
        self.size = aSize;
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)adic number:(int)aNumb size:(int)aSize
{
    return [[[self alloc] initWithDictionary:adic] autorelease];
}

@end
