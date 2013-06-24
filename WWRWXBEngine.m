//
//  WWRWXBEngine.m
//  wanxiangerweima
//
//  Created by mac on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#define REQUEST_PREQRLIST          10
#define REQUEST_YOOKORDERLIST      20
#define REQUEST_GETGIFTLIST        30
#define REQUEST_JOINSHOP           40
#define REQUEST_EBOOKFAVLIST       50
#define REQUEST_EBOOKDELFAVLIST    60
#define REQUEST_DELORDERODID       70
#define REQUEST_EBOOKMSG           80
#define REQUEST_EBOOKADDMSG        90
#define REQUEST_EBOOKDELFAVALLLIST 100
#import "WWRWXBEngine.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "WWRStatus.h"
#import "WWRPingZhengStatus.h"
#import "WWRHuiYuanKaStstus.h"
#import "WWRLiPinQuanStatus.h"
#import "WWREBookStatus.h"
#import "WWREBaoKanPingLunStatus.h"
@implementation WWRWXBEngine
@synthesize delegate = _delegate;

//获取优惠券列表
- (void)requestPreQRListUser:(int)u
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/goods/GetPreQRList.aspx?u=%d",SERVER_URL,u]]];
    request.delegate = self;
	request.tag = REQUEST_PREQRLIST;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
	
}
//请求会员列表
- (void)requestJoinShopPage:(int)p user:(int)u
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@//API/User/joinShop.aspx?p=%d&u=%d",SERVER_URL,p,u]]];
    request.delegate = self;
	request.tag = REQUEST_JOINSHOP;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
}

//获取礼品券列表
- (void)requestGetGiftListUser:(int)u
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/gift/List.aspx?u=%d",SERVER_URL,u]]];
    request.delegate = self;
	request.tag = REQUEST_GETGIFTLIST;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
}

//查看电子凭证
- (void)requestYoOKOrderListUser:(int)u
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/order/OKOrderList.aspx?u=%d",SERVER_URL,u]]];
    request.delegate = self;
	request.tag = REQUEST_YOOKORDERLIST;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
//    [request setCompletionBlock:^{
//        NSLog(@"%@",request.responseString);
//    }];
	request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
	
}

//删除未完成交易
- (void)requestDelorderODID:(int)o
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/order/delorder.aspx?id=%d",SERVER_URL,o]]];
    request.delegate = self;
	request.tag = REQUEST_DELORDERODID;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS; 
    [request startAsynchronous];
}

//请求e报刊收藏列表
- (void)requestEBookFavListUser:(int)u
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/book/FavList.aspx?u=%d&p=1",SERVER_URL,u]]];
    request.delegate = self;
	request.tag = REQUEST_EBOOKFAVLIST;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}

//删除e报刊收藏数据
- (void)requestEBookDelFavListUser:(int)b
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/book/DelFav.aspx?id=%d",SERVER_URL,b]]];
    request.delegate = self;
	request.tag = REQUEST_EBOOKDELFAVLIST;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}

//删除所有e报刊收藏
- (void)requestEBookDelFavAllListUser:(int)u
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/book/Delfavall.aspx?id=%d",SERVER_URL,u]]];
    request.delegate = self;
	request.tag = REQUEST_EBOOKDELFAVALLLIST;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}
+(void)requestEBookDelFavAllListUser:(int)u callbackfunction:(void (^)(bool isWin))function
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/book/Delfavall.aspx?id=%d",SERVER_URL,u]]];
    [request setCompletionBlock:^{
        SBJSON *json = [[SBJSON alloc] init];
        NSDictionary *dic = [json objectWithString:request.responseString error:nil];        
        NSLog(@"response %@",request.responseString);        
        NSDecimalNumber *no = [dic valueForKey:@"NO"];
        BOOL isSuccess = ([no intValue] != 0)?YES:NO;        
        //NSString *resultString = [dic objectForKey:@"Result"];
        function(isSuccess);
    }];
    [request setFailedBlock:^{
        NSLog(@"%@",request.responseString);
        function(FALSE);
    }];
    [request startAsynchronous];
}


//获取当前会刊个人评论
- (void)requestEBookMsgUser:(int)u bookID:(int)b
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/API/book/bookMsg.aspx?p=1&u=%d&bid=%d",SERVER_URL,u,b]]];
    request.delegate = self;
	request.tag = REQUEST_EBOOKMSG;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}

//添加会刊评论
- (void)requestAddBookMsgCon:(NSString *)contentStr user:(int)u bookID:(int)b
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Api/book/addbookMsg.aspx?con=%@&u=%d&did=%d",SERVER_URL,contentStr,u,b]]];
    request.delegate = self;
	request.tag = REQUEST_EBOOKADDMSG;
    //手动设置结束方法
    [request setDidFinishSelector:@selector(getTimelineFinised:)];
	[request setDidFailSelector:@selector(getTimelineFailed:)];
	request.timeOutSeconds = TIMEOUTSECONDS;
    [request startAsynchronous];
}

//请求完成调用方法
- (void)getTimelineFinised:(ASIHTTPRequest *)request
{
    SBJSON *json = [[SBJSON alloc] init];
    NSDictionary *dic = [json objectWithString:request.responseString error:nil];
	
	NSLog(@"response %@",request.responseString);
	
    NSDecimalNumber *no = [dic valueForKey:@"NO"];
	BOOL isSuccess = ([no intValue] != 0)?YES:NO;
	
    NSString *resultString = [dic objectForKey:@"Result"];
    NSArray *resultArray = [json objectWithString:resultString error:nil];
	
	switch (request.tag)
	{
		case REQUEST_PREQRLIST:
		{
			if (isSuccess)
			{
				
				NSLog(@"优惠券  %@",resultString);
				NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
				for (NSDictionary *dic in resultArray)
				{
					WWRStatus *status = [[WWRStatus alloc] initWithDictionary:dic];
					[tempArray addObject:status];
					[status release];
				}
				if ([_delegate respondsToSelector:@selector(getPreQRListSuccess:)])
				{
					
					[_delegate getPreQRListSuccess:tempArray];
					[tempArray release];
				}
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有返回优惠券信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
		}
			break;
		case REQUEST_YOOKORDERLIST:
		{
			if (isSuccess)
			{
				NSLog(@"电子凭证  %@",resultString);
				NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
				for (NSDictionary *dic in resultArray)
				{
					WWRPingZhengStatus *status = [[WWRPingZhengStatus alloc] initWithDictionary:dic];
					[tempArray addObject:status];
					[status release];
					
				}
				
				if ([_delegate respondsToSelector:@selector(getYoOKOrderListSuccess:)])
				{
					[_delegate getYoOKOrderListSuccess:tempArray];
					[tempArray release];
				}
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有返回电子凭证信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
			
		}
			break;
		case REQUEST_GETGIFTLIST:
		{
			if (isSuccess)
			{
				NSLog(@"礼品券  %@",resultString);			
				NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
				for (NSDictionary *dic in resultArray)
				{
					WWRLiPinQuanStatus *status = [[WWRLiPinQuanStatus alloc] initWithDictionary:dic];
					[tempArray addObject:status];
					[status release];
				}
				if ([_delegate respondsToSelector:@selector(getGiftListSuccess:)])
				{
					[_delegate getGiftListSuccess:tempArray];
					[tempArray release];
				}
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有返回礼品券信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
		}
			break;
		case REQUEST_JOINSHOP:
		{
			if (isSuccess)
			{
				NSLog(@"会员卡  %@",resultString);
				NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
				for (NSDictionary *dic in resultArray)
				{
					WWRHuiYuanKaStstus *status = [[WWRHuiYuanKaStstus alloc] initWithDictionary:dic];
					[tempArray addObject:status];
					[status release];
				}
				if ([_delegate respondsToSelector:@selector(getJoinShopSuccess:)])
				{
					
					[_delegate getJoinShopSuccess:tempArray];
					[tempArray release];
				}
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有返回会员卡信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
		}
			break;
		case REQUEST_EBOOKFAVLIST:
		{
			if (isSuccess)
			{
				
				NSLog(@"e报刊  %@",resultString);
				NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
				for (NSDictionary *dic in resultArray)
				{
					WWREBookStatus *status = [[WWREBookStatus alloc] initWithDictionary:dic];
					[tempArray addObject:status];
					[status release];
				}
				if ([_delegate respondsToSelector:@selector(getEBookFavListSuccess:)])
				{
					
					[_delegate getEBookFavListSuccess:tempArray];
					[tempArray release];
				}
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有返回e媒港信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
		}
			break;
		case REQUEST_EBOOKDELFAVLIST:
		{
			if (isSuccess)
			{
				NSLog(@"删除e报刊  %@",resultString);
				
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"e媒港信息删除成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
							
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有删除e媒港信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
			
		}
			break;
		case REQUEST_EBOOKDELFAVALLLIST:
		{
			if (isSuccess)
			{
				NSLog(@"删除所有e报刊  %@",resultString);
				
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"删除所有e媒港信息成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有删除e媒港信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
		}
			break;

		case REQUEST_DELORDERODID:
		{
			if (isSuccess)
			{
				//NSLog(@"删除未完成交易（删除未完成电子凭证）  %@",resultString);
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"未完成交易删除成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有删除未完成交易" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
			
		}
			break;
		case REQUEST_EBOOKMSG:
		{
			if (isSuccess)
			{
				
				NSLog(@"e媒港当前个人评论  %@",resultString);
				NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
				for (NSDictionary *dic in resultArray)
				{
					WWREBaoKanPingLunStatus *status = [[WWREBaoKanPingLunStatus alloc] initWithDictionary:dic];
					[tempArray addObject:status];
					[status release];
				}
				if ([_delegate respondsToSelector:@selector(getEBookMsgSuccess:)])
				{
					
					[_delegate getEBookMsgSuccess:tempArray];
					[tempArray release];
				}
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有返回当前会刊个人评论" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
		}
			break;
        case REQUEST_EBOOKADDMSG:
		{
			if (isSuccess)
			{
				NSLog(@"添加会刊评论 %@",resultString);
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"添加会刊评论成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
				
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"服务器没有添加会刊评论" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
				[alertView show];
				[alertView release];
			}
		}
			break;

		default:
			break;
	}
    
}
//请求失败调用方法
- (void)getTimelineFailed:(ASIHTTPRequest *)request
{
	switch (request.tag)
	{
        case REQUEST_PREQRLIST:
        {
            if ([_delegate respondsToSelector:@selector(getPreQRListFail:)])
            {
                [_delegate getPreQRListFail:request.error];
            }
			
        }
            break;
        case REQUEST_YOOKORDERLIST:
        {
			if ([_delegate respondsToSelector:@selector(getYoOKOrderListFail:)])
            {
                [_delegate getYoOKOrderListFail:request.error];
            }
        }
			break;
		case REQUEST_GETGIFTLIST:
        {
			if ([_delegate respondsToSelector:@selector(getGiftListFail:)])
            {
                [_delegate getGiftListFail:request.error];
            }
        }
            break; 
		case REQUEST_JOINSHOP:
        {
            if ([_delegate respondsToSelector:@selector(getJoinShopFail:)])
            {
                [_delegate getJoinShopFail:request.error];
            }
			
        }
            break;
		case REQUEST_EBOOKFAVLIST:
        {
            if ([_delegate respondsToSelector:@selector(getEBookFavListFail:)])
            {
                [_delegate getEBookFavListFail:request.error];
            }
			
        }
            break;
		case REQUEST_EBOOKDELFAVLIST:
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"删除e媒港收藏信息失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
			[alertView show];
			[alertView release];
		}
			break;
		case REQUEST_EBOOKDELFAVALLLIST:
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"删除所有e媒港收藏信息失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
			[alertView show];
			[alertView release];
		}
			break;

		case REQUEST_DELORDERODID:
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"删除未完成交易失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
			[alertView show];
			[alertView release];
		}
			break;
        case REQUEST_EBOOKMSG:
        {
            if ([_delegate respondsToSelector:@selector(getEBookMsgFail:)])
            {
                [_delegate getEBookMsgFail:request.error];
            }
			
        }
            break;
		case REQUEST_EBOOKADDMSG:
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"添加评论失败，是否要重新加载" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新加载",nil];
			[alertView show];
			[alertView release];
		}
			break;

        default:
            break;
    }
	
}


@end
