//
//  ProvinceCityParser.m
//  wanxiangerweima
//
//  Created by Pengfei Shi on 13-7-4.
//
//

#import "ProvinceCityParser.h"
#import "LPPro.h"
#import "LPCity.h"
@implementation ProvinceCityParser
@synthesize provinceArray = _provinceArray;
@synthesize cityArray = _cityArray;
-(id)init
{
    if (self = [super init]) {
        NSDictionary *tempDic = [[NSUserDefaults standardUserDefaults] valueForKey:@"tempDic"];
        NSArray *proArray = [tempDic objectForKey:@"sheng"];
        NSMutableArray *mutProArray = [[[NSMutableArray alloc] init] autorelease];
        
        for (NSDictionary *temp in proArray)
        {
            [mutProArray addObject:[LPPro initWithDictionary:temp]];
        }
        
        self.provinceArray = mutProArray;
        NSMutableArray *mutCityArray = [[[NSMutableArray alloc] init] autorelease];
        NSArray *cityArray = [tempDic objectForKey:@"shi"];
        for (NSDictionary *temp in cityArray)
        {
            [mutCityArray addObject:[LPCity initWithDictionary:temp]];
        }
        self.cityArray = mutCityArray;
    }
    
    return self;
}
-(void)dealloc
{
    self.provinceArray = nil;
    self.cityArray = nil;
    [super dealloc];
}
-(NSString*)getProvinceName:(int)proviceValue
{
    for (LPPro* pro in self.provinceArray) {
        if ( [pro.proID intValue]== proviceValue) {
            return pro.proName;
        }
    }
    return nil;
}

-(NSString*)getCityName:(int)cityVale
{
    for (LPCity* city in self.cityArray) {
        if ( [city.cityID intValue]== cityVale) {
            return city.cityName;
        }
    }
    return nil;
}

-(int)getProviceIDByName:(NSString*)proviceName
{
    for (LPPro* pro in self.provinceArray) {
        if ( [pro.proName isEqualToString:proviceName]) {
            return [pro.proID intValue];
        }
    }
    return -1;
}

-(int)getCityIDByName:(NSString*)cityName
{
    for (LPCity* city in self.cityArray) {
        if ( [city.cityName isEqualToString:cityName]) {
            return [city.cityID intValue];
        }
    }
    return -1;
}


@end
