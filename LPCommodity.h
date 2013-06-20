//
//  LPCommodity.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-11.
//
//

#import <Foundation/Foundation.h>

@interface LPCommodity : NSObject
{
    int yhprice;
    NSString *_ID;
    NSString *_managerId;
    NSString *_title;
    NSString *_pClassID;
    NSString *_classId;
    NSString *_price;
    NSString *_price2;
    int buytype;
    NSString *_info;
    int sheng;
    int shi;
    NSString *_xuinfo;
    int click;
    NSString *_imgurl;
    NSString *_addtime;
    int isok;
    NSString *_attr;
    NSString *_imgList;
    int isyd;
    int isjoin;
    int isbuy;
    
}
@property(nonatomic,assign) int yhprice;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *managerId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *pClassID;
@property(nonatomic,retain) NSString *classId;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *price2;
@property(nonatomic,assign) int buytype;
@property(nonatomic,retain) NSString *info;
@property(nonatomic,assign) int sheng;
@property(nonatomic,assign) int shi;
@property(nonatomic,copy) NSString *xuinfo;
@property(nonatomic,assign) int click;
@property(nonatomic,copy) NSString *imgurl;
@property(nonatomic,copy) NSString *addtime;
@property(nonatomic,assign) int isok;
@property(nonatomic,copy) NSString *attr;
@property(nonatomic,copy) NSString *imgList;
@property(nonatomic,assign) int isyd;
@property(nonatomic,assign) int isjoin;
@property(nonatomic,assign) int isbuy;
@property(nonatomic,copy)   NSString * attribute;
@property(nonatomic,copy)   NSString * shangjia;
-(id)initWithDictionary:(NSDictionary *)aDic;
+(id)initWithDictionary:(NSDictionary *)aDic;

@end
