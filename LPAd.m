//
//  LPAd.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-9.
//
//

#import "LPAd.h"

@implementation LPAd


- (void)dealloc
{
    [_imgurl release];
    [_title release];
    [_contents release];
    [_name release];
    [_addtime release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init]) {
        self.ID = [[aDic valueForKey:@"id"] intValue];
        self.imgurl = [aDic valueForKey:@"imgurl"];
        self.title = [aDic valueForKey:@"title"];
        self.contents = [aDic valueForKey:@"contents"];
        self.classID = [[aDic valueForKey:@"ClassID"] intValue];
        self.sheng = [[aDic valueForKey:@"sheng"] intValue];
        self.shi = [[aDic valueForKey:@"shi"] intValue];
        self.managerid = [[aDic valueForKey:@"managerid"] intValue];
        self.name = [aDic valueForKey:@"name"];
        NSString * str = [aDic valueForKey:@"addtime"];
        self.shopname  = [aDic valueForKey:@"shopname"];
        NSArray  * arry = [str componentsSeparatedByString:@"("];
        NSArray  * arry2 = [[arry objectAtIndex:0]componentsSeparatedByString:@")"];
        self.addtime = [arry2 objectAtIndex:0];
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[[self alloc] initWithDictionary:aDic] autorelease];
}
@end
