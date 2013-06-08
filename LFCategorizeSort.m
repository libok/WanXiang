//
//  LFCategorizeSort.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-26.
//
//

#import "LFCategorizeSort.h"

@implementation LFCategorizeSort

 
-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init])
    {
        self.aId = [aDic valueForKey:@"id"];
        self.title = [aDic valueForKey:@"title"];
        self.sortUid = [aDic valueForKey:@"uid"];
        self.sort  = [aDic valueForKey:@"sort"];
    }
    return self;
}

+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[self alloc] initWithDictionary:aDic];
}
-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@ ",self.aId,self.sortUid];
}
-(id)copyWithZone:(NSZone *)zone
{
    LFCategorizeSort * temp  = [[LFCategorizeSort alloc]init];
    temp.aId = self.aId;
    temp.title = self.title;
    temp.sort  = self.sort;
    temp.sortUid = self.sortUid;
    return temp;
}
@end
