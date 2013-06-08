//
//  LPWareModel.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-26.
//
//

#import <Foundation/Foundation.h>

@interface LPWareModel : NSObject
{
    NSString *_price;
    NSString *_price1;
    NSString *_yhprice;
    int _number;
    int _size;
    NSString *_title;
    NSString *_info;
    NSArray *_imgList;
}
@property(nonatomic,retain) NSArray *imgList;
@property(nonatomic,retain) NSString *price;
@property(nonatomic,retain) NSString *price1;
@property(nonatomic,retain) NSString *yhprice;
@property(nonatomic,assign) int number;
@property(nonatomic,assign) int size;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *info;
-(id)initWithDictionary:(NSDictionary *)adic number:(int)aNumb size:(int)aSize;
+(id)initWithDictionary:(NSDictionary *)adic number:(int)aNumb size:(int)aSize;
@end
