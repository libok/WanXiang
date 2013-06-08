//
//  LPCity.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-8.
//
//

#import "LPCity.h"
#define KPRO_Key     @"proIDKey"
#define kCITY_IDKey  @"cityIDKey"
#define KCITY_NAME   @"cityNameKey"
 

@implementation LPCity
@synthesize proID = _proID;
@synthesize cityID = _cityID;
@synthesize cityName = _cityName;
- (void)dealloc
{
    [_proID release];
    [_cityID release];
    [_cityName release];
    [super dealloc];
}
+(id)initWithDictionary:(NSDictionary *)aDic
{
    return [[[self alloc] initWithDictionary:aDic] autorelease];
}
-(id)initWithDictionary:(NSDictionary *)aDic
{
    if (self = [super init]) {
        NSString *str = [NSString stringWithFormat:@"%@",[aDic valueForKey:@"proID"]];
        self.proID = str;
        self.cityID = [NSString stringWithFormat:@"%@",[aDic valueForKey:@"cityID"]];
        self.cityName = [aDic valueForKey:@"cityName"];
    }
    return self;
}
//对象序列化的方法,把对象的所有属性编码到本地
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_proID forKey:KPRO_Key];
	[aCoder encodeObject:_cityID forKey:kCITY_IDKey];
    [aCoder encodeObject:_cityName forKey:KCITY_NAME];
}

//对象反序列化的方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
	if(self = [super init])
	{
        self.proID = [aDecoder decodeObjectForKey:KPRO_Key];
		self.cityID = [aDecoder decodeObjectForKey:kCITY_IDKey];
        self.cityName = [aDecoder decodeObjectForKey:KCITY_NAME];
	}
	
	return self;
}

@end
