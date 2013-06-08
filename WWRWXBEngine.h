//
//  WWRWXBEngine.h
//  wanxiangerweima
//
//  Created by mac on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWRWXBEngine : NSObject
{
	id   _delegate;
	int  d;

}
@property(nonatomic,assign) id  delegate;

//请求优惠券列表
- (void)requestPreQRListUser:(int)u;
//请求会员列表
- (void)requestJoinShopPage:(int)p user:(int)u;
//请求礼品券列表
- (void)requestGetGiftListUser:(int)u;
//查看电子凭证
- (void)requestYoOKOrderListUser:(int)u;
//删除未完成交易
- (void)requestDelorderODID:(int)o;
//请求e报刊收藏列表
- (void)requestEBookFavListUser:(int)u;
//删除e报刊收藏数据
- (void)requestEBookDelFavListUser:(int)b;
//删除所有e报刊收藏
- (void)requestEBookDelFavAllListUser:(int)u;
//获取当前会刊个人评论
- (void)requestEBookMsgUser:(int)u bookID:(int)b;
//添加会刊评论
- (void)requestAddBookMsgCon:(NSString *)contentStr user:(int)u bookID:(int)b;
+(void)requestEBookDelFavAllListUser:(int)u callbackfunction:(void (^)(bool isWin))function;

@end

//获取优惠券列表
@protocol WWRWXBEnginePreQRListDelegate <NSObject>

-(void)getPreQRListSuccess:(NSArray *)aArray;
-(void)getPreQRListFail:(NSError *)aError;

@end

//获取会员卡列表
@protocol WWRWXBEngineJoinShopDelegate <NSObject>

-(void)getJoinShopSuccess:(NSArray *)aArray;
-(void)getJoinShopFail:(NSError *)aError;

@end

//获取礼品券列表
@protocol WWRWXBEngineGetGiftListDelegate <NSObject>

-(void)getGiftListSuccess:(NSArray *)aArray;
-(void)getGiftListFail:(NSError *)aError;

@end

//查看电子凭证
@protocol WWRWXBEngineYoOKOrderListDelegate <NSObject>

-(void)getYoOKOrderListSuccess:(NSMutableArray *)aArray;
-(void)getYoOKOrderListFail:(NSError *)aError;

@end

//获得e报刊收藏列表
@protocol WWRWXBEngineEBookFavListDelegate <NSObject>

-(void)getEBookFavListSuccess:(NSMutableArray *)aArray;
-(void)getEBookFavListFail:(NSError *)aError;

@end

//获得e报刊当前个人评论
@protocol WWRWXBEngineEBookMsgDelegate <NSObject>

-(void)getEBookMsgSuccess:(NSArray *)aArray;
-(void)getEBookMsgFail:(NSError *)aError;

@end

