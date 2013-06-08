//
//  LPGoogsClass.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-15.
//
//

#import "LPGoogsClass.h"

@implementation LPGoogsClass
@synthesize ID;
@synthesize title = _title;
@synthesize parent_id;
@synthesize class_layer;
@synthesize class_list = _class_list;
@synthesize imgurl = _imgurl;
@synthesize remark = _remark;
- (void)dealloc
{
    [_title release];
    [_class_list release];
    [_imgurl release];
    [_remark release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init]) {
        self.ID = [[aDic valueForKey:@"id"] intValue];
        self.title = [aDic valueForKey:@"Title"];
        NSString *str = [aDic valueForKey:@"parent_id"];
        self.parent_id = [str intValue];
        self.class_layer = [[aDic valueForKey:@"class_layer"] intValue];
        self.class_list = [aDic valueForKey:@"class_list"];
        self.imgurl = [aDic valueForKey:@"img_url"];
        self.remark = [aDic valueForKey:@"remark"];
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[[self alloc] initWithDictionary:aDic] autorelease];
}

@end
