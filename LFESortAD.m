//
//  LFESortAD.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-24.
//
//

#import "LFESortAD.h"

@implementation LFESortAD

@synthesize adType;
@synthesize adContents;
@synthesize adContentsimg;

-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init])
    {

        self.adID = [aDic valueForKey:@"id"];
        self.adType = [aDic valueForKey:@"type"];
        self.adContents =[aDic valueForKey:@"contents"];
        self.adContentsimg=[aDic valueForKey:@"contentsimg"];
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
