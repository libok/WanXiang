//
//  ProvinceCityParser.h
//  wanxiangerweima
//
//  Created by Pengfei Shi on 13-7-4.
//
//

#import <Foundation/Foundation.h>

@interface ProvinceCityParser : NSObject
{
    NSArray             *_provinceArray;
    NSArray             *_cityArray;
}

@property(nonatomic,retain) NSArray             *cityArray;
@property(nonatomic,retain) NSArray             *provinceArray;

-(NSString*)getProvinceName:(int)proviceValue;
-(NSString*)getCityName:(int)cityVale;
-(int)getProviceIDByName:(NSString*)proviceName;
-(int)getCityIDByName:(NSString*)cityName;
@end
