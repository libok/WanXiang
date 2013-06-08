//
//  LPPro.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-7.
//
//

#import "LPPro.h"

@implementation LPPro
@synthesize proID = _proID;
@synthesize proName = _proName;
- (void)dealloc
{
    [_proName release];
    [_proID release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init]) {
        NSString *str = [NSString stringWithFormat:@"%@",[aDic valueForKey:@"proID"]];
        self.proID = str;
        self.proName = [aDic valueForKey:@"proName"];

 
    }
    return self;
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[[self alloc] initWithDictionary:aDic ] autorelease];
}

@end
