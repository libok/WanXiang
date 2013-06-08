//
//  LPShouCang.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-17.
//
//

#import "LPShouCang.h"

@implementation LPShouCang
@synthesize title = _title;
@synthesize imgurl = _imgurl;
@synthesize goodid = _goodid;
@synthesize goodlist = _goodlist;
@synthesize ID = _ID;
@synthesize uid = _uid;
@synthesize addtime = _addtime;
@synthesize managerid = _managerid;
- (void)dealloc
{
    [_title release];
    [_imgurl release];
    [_goodlist release];
    [_goodid release];
    [_ID release];
    [_uid release];
    [_addtime release];
    [_managerid release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init]) {
        self.title = [aDic valueForKey:@"Title"];
        self.imgurl = [aDic valueForKey:@"imgurl"];
        self.goodid = [aDic valueForKey:@"goodsid"];
        self.ID = [aDic valueForKey:@"id"];
        self.uid = [aDic valueForKey:@"uid"];
        self.managerid = [aDic valueForKey:@"managerid"];
        self.goodlist = [aDic valueForKey:@"goodsid"];
        self.addtime = [aDic valueForKey:@"addtime"];
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[[self alloc] initWithDictionary:aDic] autorelease];
}

@end
