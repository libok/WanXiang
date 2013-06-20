//
//  LFESort.m
//  wanxiangerweima
//
//  Created by Evan on 13-4-24.
//
//

#import "LFESort.h"

@implementation LFESort


-(id)initWithDictionary:(NSDictionary *)aDic
{
    NSLog(@"%@",aDic);
    if (self = [super init])
    {
        self.merchantID = [aDic valueForKey:@"id"];
        self.aSortContents = [aDic valueForKey:@"sortContents"];
        self.aSortName = [aDic valueForKey:@"sortname"];
        self.aHuikanTime = [aDic valueForKey:@"huikantime"];
        self.aSortImg = [aDic valueForKey:@"sortimg"];
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[self alloc] initWithDictionary:aDic];
}
-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@ %@",self.aSortContents,self.aSortName,self.aSortImg];
}


@end
