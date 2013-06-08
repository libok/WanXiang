//
//  LPCity.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-8.
//
//

#import <Foundation/Foundation.h>

@interface LPCity : NSObject <NSCoding>
{
    NSString *_proID;
    NSString *_cityID;
    NSString *_cityName;
}
@property(nonatomic,retain) NSString *proID;
@property(nonatomic,retain) NSString *cityID;
@property(nonatomic,copy) NSString *cityName;
+(id)initWithDictionary:(NSDictionary *)aDic;
-(id)initWithDictionary:(NSDictionary *)aDic;
@end
