//
//  LSBengine.m
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-2.
//
//
#define REQUEST_AD 10
#define REQUEST_COMMODITY 20
#define REQUEST_COMMODITY_DATIL 30
#define REQUEST_GOODSCLASS 40
#define REQUEST_SHOUCANG 50
#define REQUEST_DIDSC 60
#define REQUEST_DELE 70
#define REQUEST_YHQ 80
#define REQUEST_HY 90
#define REQUEST_SINGLE 100
#define REQUEST_SHANGPIN 110
#define REQUEST_SEARCH 120
#define PROVINCE_URL @"http://119.161.221.204:801/API/city/sheng.aspx"
#import "LSBengine.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "LPAd.h"
#import "LPCommodity.h"
#import "LPGoogsClass.h"
#import "LYGAppDelegate.h"
#import "LPShouCang.h"
#import "BYNLoginViewController.h"
#import "LYGAppDelegate.h"
#import "MBProgressHUD.h"
#import "LYGEveryPhenomenonStreetViewController.h"
#import "ShopViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManager.h>
#import "LYGAppDelegate.h"
@interface LSBengine (privateMothd)
-(void)saveData:(NSDictionary *)aDic;
@end
@implementation LSBengine
@synthesize delegate = _delegate;
//获取未完成交易
+(void)orderAtOnce:(int)mangerID good:(int)goodID  content:(NSString *)astr callbackFunction:(void (^)(NSString* msg))aFunction
{
    int uid = [LYGAppDelegate getuid];
    NSString * str = [NSString stringWithFormat:@"%@/API/goods/yu.aspx?u=%d&s=%d&g=%d&con=%@",SERVER_URL,uid,mangerID,goodID,astr];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:str]];
    [request setCompletionBlock:^{
        //int result = [LYGAppDelegate getAsihttpResult:request.responseString];
        NSString * xx = [LYGAppDelegate getAsihttpResultMsg:request.responseString];
        aFunction(xx);
    }];
    [request setFailedBlock:^{
        aFunction(@"未能订购成功");
    }];
    [request startAsynchronous];
}



//API/goods/yu.aspx?u=**&s=**&g=**&con=**
//U 用户id
//s 商家id
//g 产品id
+(void)hasNotFinishedTrade:(int)status callbackfunction:(void (^)(NSMutableArray*))function
{
    int ID = [LYGAppDelegate getuid];
    NSString * string = [NSString stringWithFormat:@"%@/API/Order/OrderList.aspx?status=%d&u=%d",SERVER_URL,status,ID];
    __block NSMutableArray * mutablearry = [[NSMutableArray alloc]init];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:string]];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        NSString *timeLineString = request.responseString;
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:timeLineString error:nil];
        NSDecimalNumber *no = [dic valueForKey:@"NO"];
        NSString *adString = [dic objectForKey:@"Result"];
        NSArray *adArray = [json objectWithString:adString error:nil];
        BOOL isSuccess = ([no intValue] != 0)?YES:NO;
        if (!isSuccess) {
            function(nil);
            [mutablearry release];
            return;
        }
        for (NSDictionary * dict in adArray) {
            NSLog(@"%@",dict);
            LPShouCang * temp = [[LPShouCang alloc]initWithDictionary:dict];
            [mutablearry addObject:temp];
            [temp release];
        }
        function(mutablearry);
        [mutablearry autorelease];
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
}
//获得商户信息
+(void)getUserInfo:(int)aMangerID callbackfunction:(void (^)(ShopInfo*))function
{
    NSString * string = [NSString stringWithFormat:@"%@/API/shop/GetShop.aspx?s=%d",SERVER_URL,aMangerID];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:string]];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        NSString *timeLineString = request.responseString;
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:timeLineString error:nil];
        NSDecimalNumber *no = [dic valueForKey:@"NO"];
        NSString *adString = [dic objectForKey:@"Result"];
        NSDictionary * dict = [json objectWithString:adString error:nil];
        BOOL isSuccess = ([no intValue] != 0)?YES:NO;
        if (!isSuccess) {
            function(nil);
            return;
        }
        ShopInfo * shop = [[ShopInfo alloc]initWithDict:dict];
        function(shop);
        //function(mutablearry);
        [shop autorelease];
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
}

+(void)getGoodsArry:(int)aMangerID callbackfunction:(void (^)(NSArray*))function
{
    NSString * string = [NSString stringWithFormat:@"%@/API/Goods/goodsByShop.aspx?s=%d",SERVER_URL,aMangerID];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:string]];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        NSString *timeLineString = request.responseString;
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:timeLineString error:nil];
        NSDecimalNumber *no = [dic valueForKey:@"NO"];
        NSString *adString = [dic objectForKey:@"Result"];
        NSMutableArray * mutablearry = [[NSMutableArray alloc]init];
        NSArray *adArray = [json objectWithString:adString error:nil];
        BOOL isSuccess = ([no intValue] != 0)?YES:NO;
        if (!isSuccess) {
            function(nil);
            [mutablearry release];
            return;
        }
        for (NSDictionary * dict in adArray) {
            LPCommodity* temp = [[LPCommodity alloc]initWithDictionary:dict];
            [mutablearry addObject:temp];
            [temp release];
        }
        function(mutablearry);
        [mutablearry autorelease];

    }];
    [request setFailedBlock:^{
        function(nil);

        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
}


-(BOOL)isLogin
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *tempDic = [userDefault valueForKey:@"tempDic"];
    if (tempDic) {
        return YES;
    }
    return NO;
    
}
-(void)saveData:(NSDictionary *)aDic
{
    [[NSUserDefaults standardUserDefaults] setValue:aDic forKey:@"tempDic"];
    [[NSUserDefaults standardUserDefaults ] synchronize];
}
-(void)dealloc
{
    if (_requestArry) {
        for (ASIHTTPRequest *request in _requestArry) {
            [request cancel];
        }
    }
    
    [_requestArry release];
    [super dealloc];
}
-(void)readURl
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:PROVINCE_URL]];
    [_requestArry addObject:request];
    [request setCompletionBlock:^{
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString error:nil];
        NSString *temp = [dic valueForKey:@"Result"];
        NSDictionary *tempDic = [json objectWithString:temp error:nil];
        NSArray *proArray = [tempDic objectForKey:@"sheng"];
        NSMutableArray *mutProArray = [[[NSMutableArray alloc] init] autorelease];
        [self saveData:tempDic];
        for (NSDictionary *temp in proArray)
        {
            [mutProArray addObject:[LPPro initWithDictionary:temp]];
        }
        if ([_delegate respondsToSelector:@selector(getProvinceArray:)])
        {
            [_delegate getProvinceArray:mutProArray];
        }
        NSMutableArray *mutCityArray = [[[NSMutableArray alloc] init] autorelease];
        NSArray *cityArray = [tempDic objectForKey:@"shi"];
        for (NSDictionary *temp in cityArray)
        {
            [mutCityArray addObject:[LPCity initWithDictionary:temp]];
        }
        if ([_delegate respondsToSelector:@selector(getCityArray:)])
        {
            [_delegate getCityArray:mutCityArray];
        }
        
    }];
    [request startAsynchronous];
}
+(void)deletOfMyCollection:(int)x callBackFunction:(void (^)(BOOL result))function
{
    int uid = [LYGAppDelegate getuid];
    NSString * urlstr = nil;
    switch (x) {
        case 0:
        {
            urlstr = [NSString stringWithFormat:@"/Api/book/Delfavall.aspx?id=%d",uid];
        }
            break;
        case 2:
        {
            urlstr = [NSString stringWithFormat:@"/API/order/delorder.aspx?uid=%d&ids=all&T=2",uid];
        }
            break;
        case 1:
        {
            urlstr = [NSString stringWithFormat:@"/API/order/delorder.aspx?uid=%d&ids=all&T=1",uid];
        }
            break;

            
        default:
            break;
    }
    NSString * urlString2 = [SERVER_URL stringByAppendingString:urlstr];
    NSLog(@"%@",urlString2);
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString2]];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        int x = [LYGAppDelegate getAsihttpResult:request.responseString];
        function(x);
    }];
    [request setFailedBlock:^{
        function(NO);
        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
}

+(void)deletnotfinished:(int)x callBackFunction:(void (^)(BOOL result))function
{

    NSString * urlString2 = [NSString stringWithFormat:@"%@/API/order/delorder.aspx?id=%d&T=2",SERVER_URL,x];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:urlString2]];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        int x = [LYGAppDelegate getAsihttpResult:request.responseString];
        function(x);
    }];
    [request setFailedBlock:^{
        function(NO);
        NSLog(@"%@",request.responseString);
    }];
    [request startAsynchronous];
}

-(void)requestCategory
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GoodsClass.aspx",SERVER_URL]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_GOODSCLASS;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}
-(void)requestAd:(LPCity *)aCity atype:(int)type
{
    if (aCity == nil) {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/AD/wxad.aspx?sheng=17&shi=187&C=%d&p=1",SERVER_URL,type]]];
        [_requestArry addObject:request];
        request.delegate = self;
        request.tag = REQUEST_AD;
        //手动设置结束方法
        [request setDidFinishSelector:@selector(getTimelineFinised:)];
        [request setDidFailSelector:@selector(getTimelineFailed:)];
        request.timeOutSeconds = TIMEOUTSECONDS; 
        [request startAsynchronous];    
    }
    else
    {
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/AD/wxad.aspx?sheng=%d&shi=%d&C=%d&p=%d",SERVER_URL,[aCity.proID intValue],[aCity.cityID intValue],type,1]]];
        request.delegate = self;
        request.tag = REQUEST_AD;
        //手动设置结束方法
        [request setDidFinishSelector:@selector(getTimelineFinised:)];
        [request setDidFailSelector:@selector(getTimelineFailed:)];
        request.timeOutSeconds = TIMEOUTSECONDS; 
        [request startAsynchronous];
    }
}
- (void)getTimelineFinised:(ASIHTTPRequest *)request
{
    NSString *timeLineString = request.responseString;
    SBJSON *json = [[SBJSON alloc] init];
    NSDictionary *dic = [json objectWithString:timeLineString error:nil];
    NSDecimalNumber *no = [dic valueForKey:@"NO"];
    NSString *adString = [dic objectForKey:@"Result"];
    NSArray *adArray = [json objectWithString:adString error:nil];
    BOOL isSuccess = ([no intValue] != 0)?YES:NO;
    switch (request.tag) {
        case REQUEST_AD:
        {
            if (isSuccess)
            {
                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic in adArray)
                {
                    LPAd *ad = [[LPAd alloc] initWithDictionary:dic];
                    [tempArray addObject:ad];
                    [ad release];
                }
                if ([_delegate respondsToSelector:@selector(getAdSuccess:)])
                {
                    
                    [_delegate getAdSuccess:tempArray];
                    [tempArray release];
                    tempArray = nil;
                }
                
            }
            else
            {
                LYGEveryPhenomenonStreetViewController * temp = self.delegate;
                //[temp.adArray release];
                 temp.adArray = nil;
                [temp.tableView reloadData];
                //[MBProgressHUD hideHUDForView:temp.view animated:YES];
                //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:[dic valueForKey:@"Msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [_delegate getAdFail:nil];
                //[alertView show];
                //[alertView release];
                
            }
        }
            break;
        case REQUEST_SINGLE:
        {
            
            if (isSuccess)
            {
                NSDictionary *dic = (NSDictionary *)adArray;
                if ([_delegate respondsToSelector:@selector(getSingleCommomditySuccess:)]) {
                    [_delegate getSingleCommomditySuccess:dic];
                }
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:[dic valueForKey:@"Msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [alertView show];
                [alertView release];
                
            }
            
        }
            break;
            
        case REQUEST_COMMODITY:
        {
            
            if (isSuccess)
            {
                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic in adArray)
                {
                    LPCommodity *commodity = [[LPCommodity alloc] initWithDictionary:dic];
                    [tempArray addObject:commodity];
                    [commodity release];                  
                    
                }
                
                if ([_delegate respondsToSelector:@selector(getCommoditySuccess:)])
                {                    
                    [_delegate getCommoditySuccess:tempArray];
                    [tempArray release];
                }                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"没有信息" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [alertView show];
                [alertView release];
                [_delegate getCommoditySuccess:nil];
            }
            
        }
            break;
        case REQUEST_COMMODITY_DATIL:
        {
            if (isSuccess)
            {
                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic in adArray)
                {
                    LPCommodity *commodity = [[LPCommodity alloc] initWithDictionary:dic];
                    NSLog(@"%@",commodity.attr);
                    [tempArray addObject:commodity];
                    [commodity release];
                    
                }
                
                if ([_delegate respondsToSelector:@selector(getCommodityDatilSuccess:)])
                {
                    
                    [_delegate getCommodityDatilSuccess:tempArray];
                    [tempArray release];
                }
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:[dic valueForKey:@"Msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [alertView show];
                [alertView release];
                
            }
            
        }
            break;
        case REQUEST_GOODSCLASS:
        {
            if (isSuccess)
            {
                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *temp1Array = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in adArray)
                {
                    int a = [[dic valueForKey:@"parent_id"] intValue];
                    NSLog(@"-----------------%@",[dic valueForKey:@"class_list"] );
                    if(a == 0)
                    {
                        [tempArray addObject:dic];
                        
                    }
                    
                    else
                    {
                        [temp1Array addObject:dic];
                    }
                    
                    
                }
                for (NSDictionary *dic in tempArray)
                {
                    NSMutableArray *subArray = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSDictionary *dic1 in temp1Array)
                    {
                        if ([[dic valueForKey:@"id"] intValue] == [[dic1 valueForKey:@"parent_id"] intValue])
                        {
                            [subArray addObject:dic1];
                        }
                    }
                    [dic setValue:subArray forKey:@"subClass"];
                    [subArray release];
                }
                if ([_delegate respondsToSelector:@selector(getCategory:)]) {
                    [_delegate getCategory:tempArray];
                    [temp1Array release];
                    [tempArray release];
                }
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:[dic valueForKey:@"Msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [alertView show];
                [alertView release];
                
            }
            
        }
            break;
        case REQUEST_SHOUCANG:
        {   
            
                if ([_delegate respondsToSelector:@selector(getmes:)]) {
                    [_delegate getmes:dic];
                }
            
            
        }
            break;
        case REQUEST_DIDSC:
        {
 
                if (isSuccess)
                {
                    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
                    for (NSDictionary *dic in adArray)
                    {
                        LPShouCang *shouCang = [[LPShouCang alloc] initWithDictionary:dic];
                        [tempArray addObject:shouCang];
                        [shouCang release];
                        
                        
                    }
                    
                    if ([_delegate respondsToSelector:@selector(getShouCangTableViewSuccess:)])
                    {
                        
                        [_delegate getShouCangTableViewSuccess: tempArray];
                        [tempArray release];
                    }
                    

            }else
            {
                if ([_delegate respondsToSelector:@selector(getShouCangTableViewSuccess:)])
                {
                    
                    [_delegate getShouCangTableViewSuccess:nil];
                    //[tempArray release];
                }

            }
            
            
        }
            break;
        case REQUEST_DELE:
        {
            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message: [dic valueForKey:@"Msg"]delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//            [alertView show];
//            [alertView release];
            
        }
            break;
        case REQUEST_YHQ:
        {
            LoginedUserInfo * log = [LYGAppDelegate getSharedLoginedUserInfo];
            if (log.ID == -1)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:[dic valueForKey:@"Msg"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
            }
            

            

        }
            break;
        case REQUEST_HY:
        {
            
            LoginedUserInfo * log = [LYGAppDelegate getSharedLoginedUserInfo];
            if (log.ID == -1)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:@"请先登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:[dic valueForKey:@"Msg"] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
            }
            
            
        }
            break;
        case REQUEST_SHANGPIN:
        {
            if (isSuccess)
            {
                
                
                NSDictionary *dic =  [json objectWithString:adString error:nil];
                
                if ([_delegate respondsToSelector:@selector(getShangpinInfoSuccess:)])
                {
                    
                    [_delegate getShangpinInfoSuccess:dic];
                    
                }
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message: [dic valueForKey:@"Msg"]delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [alertView show];
                [alertView release];
                
            }
            
        }
            break;
        case REQUEST_SEARCH:
        {
            
            
            if (isSuccess)
            {
                NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic in adArray)
                {
                    LPCommodity *commodity = [[LPCommodity alloc] initWithDictionary:dic];
                    [tempArray addObject:commodity];
                    [commodity release];
                    
                    
                }
                
                if ([_delegate respondsToSelector:@selector(getCommoditySuccess:)])
                {

                    [_delegate getCommoditySuccess:tempArray];
                    [tempArray release];
                }
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"没有此商品" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [alertView show];
                [alertView release];
                
            }
            
            
            
            
        }
            break;
            
        default:
            break;
    }
    
}
- (void)getTimelineFailed:(ASIHTTPRequest *)request
{
    switch (request.tag) {
        case REQUEST_AD:
        {
            if ([_delegate respondsToSelector:@selector(getAdFail:)])
            {
                [_delegate getAdFail:request.error];
            }
            
        }
            break;
        case REQUEST_COMMODITY:
        {
            if ([_delegate respondsToSelector:@selector(getcommodityFail:)])
            {
                [_delegate getcommodityFail:request.error];
            }
            
        }
            break;
        case REQUEST_COMMODITY_DATIL:
        {
            if ([_delegate respondsToSelector:@selector(getcommodityFail:)])
            {
                [_delegate getCommodityDatilFail:request.error];
            }
            
        }
            break;
        case REQUEST_GOODSCLASS:
        {
            if ([_delegate respondsToSelector:@selector(getcategoryFail:)])
            {
                [_delegate getcategoryFail:request.error];
            }
            
        }
            break;
        case REQUEST_DIDSC:
        {
            if ([_delegate respondsToSelector:@selector(getshoucangtableviewFail:)])
            {
                [_delegate getshoucangtableviewFail: request.error];
            }
            
        }
            break;
        case REQUEST_SINGLE:
        {
            if ([_delegate respondsToSelector:@selector(getsinglecommomdityFail:)])
            {
                [_delegate getsinglecommomdityFail:request.error];
            }
            
        }
            break;
            
        case REQUEST_SEARCH:
        {
            //                if ([_delegate respondsToSelector:@selector(getsinglecommomdityFail:)])
            //                {
            //                    [_delegate getsinglecommomdityFail:request.error];
            //                }
            NSLog(@"-------------%@",request.error);
        }
            break;
            
            
        default:
            break;
    }
    
}
-(void)requestSingleCommodit:(int)aId
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GetGoods.aspx?id=%d",SERVER_URL,aId]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_SINGLE;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
    [request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
    
}



-(void)requestCommodity:(int)p class:(int)c index:(int)aIndex
{
    //API/Goods/GoodsList.aspx?p=1&c=1&djd=&dwd=
    CLLocationCoordinate2D xx = [LYGAppDelegate getlocation];
    ASIHTTPRequest * request = nil;
    switch (aIndex) {
        case 0:
        {
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GoodsList.aspx?c=%d&djd=%f&dwd=%f",SERVER_URL,c,xx.longitude,xx.latitude]]];
            [_requestArry addObject:request];

        }
            break;
        case 1:
        {
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GoodsList.aspx?c=%d",SERVER_URL,c]]];
            [_requestArry addObject:request];
        }
            break;
            
        default:
            break;
    }
    //ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/GoodsList.aspx?c=%d&djd=%f&dwd=%f",SERVER_URL,c,xx.longitude,xx.latitude]]];
    request.delegate = self;
    request.tag = REQUEST_COMMODITY;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
    
}
-(void)requestCommodityDatil:(int)p category:(int)c
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/goodsByShop.aspx?p=%d&s=%d",SERVER_URL,p,c]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_COMMODITY_DATIL;
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
    
}
-(void)requestshoucangU:(int)u s:(int)s g:(int)g
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/AddFav.aspx?u=%d&s=%d&g=%d",SERVER_URL,u,s,g]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_SHOUCANG;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}
-(void)requestDidshoucang:(int)u
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/FavGoodsList.aspx?u=%d",SERVER_URL,u]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_DIDSC;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
    
}
-(void)requestDeleshouCang:(int)favId
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/Goods/DelFav.aspx?favid=%d",SERVER_URL,favId]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_DELE;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
    
}
-(void)requestYHQ:(int)u managerID:(int)s commodityID:(int)g
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/goods/preqr.aspx?u=%d&s=%d&g=%d",SERVER_URL,u,s,g]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_YHQ;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}
-(void)reQuestHY:(int)u managerID:(int)s
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/shop/JoinShopUser.aspx?u=%d&s=%d",SERVER_URL,u,s]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_HY;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
    
}
-(void)requestShangjiaInfo:(int)s
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/shop/GetShop.aspx?s=%d",SERVER_URL,s]]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_SHANGPIN;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];    
}
-(void)requestSearch:(NSString *)aStr
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/API/goods/search.aspx?k=%@",SERVER_URL,aStr ];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_requestArry addObject:request];
    request.delegate = self;
    request.tag = REQUEST_SEARCH;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
    
}

@end
