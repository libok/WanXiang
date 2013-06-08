//
//  LFESortAD.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-24.
//
//

#import "LFESortAD.h"

@implementation LFESortAD
//@synthesize adID = _adID;
//@synthesize adTitle = _adTitle;
//@synthesize adImgUrl = _adImgUrl;
//@synthesize adIsshow = _adIsshow;
-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init])
    {
        self.adID = [aDic valueForKey:@"id"];
        self.adTitle = [aDic valueForKey:@"title"];
        self.adImgUrl = [aDic valueForKey:@"file_path"];
        self.adIsshow = [aDic valueForKey:@"isshow"];
        
//        NSLog(@"file_path %@",self.adImgUrl);
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[self alloc]initWithDictionary:aDic];
}
@end
