//
//  LPCommodity.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-11.
//
//

#import "LPCommodity.h"

@implementation LPCommodity
@synthesize yhprice;
@synthesize ID = _ID;
@synthesize managerId = _managerId;
@synthesize title = _title;
@synthesize pClassID = _pClassID;
@synthesize classId = _classId;
@synthesize price = _price;
@synthesize price2 = _price2;

@synthesize info = _info;
@synthesize sheng;
@synthesize shi;
@synthesize xuinfo = _xuinfo;
@synthesize click;
@synthesize imgurl = _imgurl;
@synthesize addtime = _addtime;
@synthesize isok;
@synthesize attr = _attr;
@synthesize imgList = _imgList;
@synthesize buytype;
@synthesize isbuy;
@synthesize isjoin;
@synthesize isyd;
- (void)dealloc
{
    [_title release];
    [_info release];
    [_ID release];
    [_managerId release];
    [_pClassID release];
    [_classId release];
    [_xuinfo release];
    [_imgurl release];
    [_price release];
    [_price2 release];
    [_addtime release];
    [_attr release];
    [_imgList release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)aDic
{
    NSLog(@"%@",aDic);
    if (self = [super init]) {
        self.yhprice = [[aDic valueForKey:@"yhprice"] intValue];
        self.ID = [aDic valueForKey:@"id"];
        self.managerId = [aDic valueForKey:@"managerid"];
        self.title = [aDic valueForKey:@"Title"];
        if (!self.title || self.title.length == 0) {
            self.title = [aDic valueForKey:@"goodname"];
        }
        self.classId = [aDic valueForKey:@"ClassId"];
        self.pClassID = [aDic valueForKey:@"PClassID"];
        self.price = [aDic valueForKey:@"price"];
        self.price2 = [aDic valueForKey:@"price2"];
        self.buytype = [[aDic valueForKey:@"buytype"] intValue];
        self.info = [aDic valueForKey:@"info"];
        self.sheng = [[aDic valueForKey:@"sheng"] intValue];
        self.shi = [[aDic valueForKey:@"shi"] intValue];
        self.xuinfo = [aDic valueForKey:@"xuinfo"];
        self.click = [[aDic valueForKey:@"Click"] intValue];
        self.imgurl = [aDic valueForKey:@"imgurl"];

        self.addtime = [aDic valueForKey:@"addtime"];
        self.isok = [[aDic valueForKey:@"IsOk"] intValue];
        self.attr = [aDic valueForKey:@"Attr"];
        self.imgList = [aDic valueForKey:@"imglist"];
        self.isyd = [[aDic valueForKey:@"isyd"] intValue];
        self.isbuy  = [[aDic valueForKey:@"isbuy"] intValue];
        self.isjoin = [[aDic valueForKey:@"isjoin"] intValue];
        self.attr   = [aDic valueForKey:@"Attr"];
        self.shangjia = [aDic valueForKey:@"shangjia"];
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[[self alloc] initWithDictionary:aDic] autorelease];
}

@end
