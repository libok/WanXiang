//
//  LSBengine.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-2.
//
//

#import <Foundation/Foundation.h>
#import "LPPro.h"
#import "LPCity.h"
#import "ShopViewController.h"
 @interface LSBengine : NSObject
{
    id   _delegate;
}
@property(nonatomic,assign) id  delegate;
+(void)hasNotFinishedTrade:(int)status callbackfunction:(void (^)(NSMutableArray *))function;
+(void)getUserInfo:(int)aMangerID callbackfunction:(void (^)(ShopInfo*))function;
+(void)getGoodsArry:(int)aMangerID callbackfunction:(void (^)(NSArray*))function;
+(void)deletOfMyCollection:(int)x callBackFunction:(void (^)(BOOL result))function;
+(void)orderAtOnce:(int)mangerID good:(int)goodID  content:(NSString *)astr callbackFunction:(void (^)(NSString* msg))aFunction;
-(BOOL)isLogin;
-(void)readURl;
-(void)requestAd:(LPCity *)aCity;
-(void)requestCategory;
-(void)requestSingleCommodit:(int)aId;
-(void)requestCommodity:(int)p class:(int)c index:(int)aIndex;
-(void)requestCommodityDatil:(int)p category:(int)c;
-(void)requestshoucangU:(int)u s:(int)s g:(int)g;
-(void)requestDidshoucang:(int)u;
-(void)requestDeleshouCang:(int)favId;
-(void)requestYHQ:(int)u managerID:(int)s commodityID:(int)g;
-(void)reQuestHY:(int)u managerID:(int)s;
-(void)requestShangjiaInfo:(int)s;
-(void)requestSearch:(NSString *)aStr;
@end

@protocol LSBengineDelegate <NSObject>
//得到省份 城市
-(void)getProvinceArray:(NSArray *)aArray;
-(void)getCityArray:(NSArray *)aArray;
@end
@protocol LSBengineCategoryDelegate <NSObject>
//得到商品类别
-(void)getCategory:(NSArray *)aArray;
-(void)getcategoryFail:(NSError *)aError;
@end

@protocol LSBengineAdDelegate <NSObject>

//得到商城主页广告
-(void)getAdSuccess:(NSArray *)aArray;
-(void)getAdFail:(NSError *)aError;

@end
@protocol LSBenginecommodityDelegate <NSObject>
//得到全部商品
-(void)getCommoditySuccess:(NSArray *)aArray;
-(void)getcommodityFail:(NSError *)aError;

@end
//得到单个商品
@protocol LsbengineSingDelegate <NSObject>

-(void)getSingleCommomditySuccess:(NSDictionary *)aDic;
-(void)getsinglecommomdityFail:(NSError *)aError;

@end
@protocol LSBengineCommodityDatilDelegate <NSObject>
//得到商品详情
-(void)getCommodityDatilSuccess:(NSArray *)aArray;
-(void)getCommodityDatilFail:(NSError *)aError;
@end
@protocol LSBengineShouCangDelegate <NSObject>

//得到收藏列表
-(void)getShouCangTableViewSuccess:(NSArray *)aArray;
-(void)getshoucangtableviewFail:(NSError *)aError;
@end
@protocol lsbengineShangpingDelegate <NSObject>

-(void)getShangpinInfoSuccess:(NSDictionary *)aDic;
-(void)getshangpininfoFail:(NSError *)aError;


@end
@protocol LSBEnginescing <NSObject>

-(void)getmes:(NSDictionary *)adic;

@end
