//
//  BYNUserCenterEngine.m
//  wanxiangerweima
//
//  Created by usr on 13-4-16.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#define UID_KEY        @"id"
#define QUESTION_KEY   @"question"
#define NEWSID_KEY     @"newsid"



#import "BYNUserCenterEngine.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "LYGAppDelegate.h"
#import "BYNUserCenter.h"
#import "BYNMember.h"
#import "BYNJPRecommend.h"
#import "BYNLogin.h"
#import "LYGAppDelegate.h"
//#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "NSString+MD5HexDigest.h"


@implementation BYNUserCenterEngine


#pragma mark -
#pragma mark 注册
+ (void)sendRegisterPhoneContent:(NSString *)phoneStr passwordContent:(NSString *)passwordStr  
	emailContent:(NSString *)emailStr 
	questionContent:(NSString *)questionStr 
	answerContent:(NSString *)answerStr  
	completionBlock:(void (^) (NSString *,int))aCompletionBlock
{
	
	//NSString * uuid = [(LYGAppDelegate*)([UIApplication sharedApplication].delegate) getuuid];
    NSString * uuid   = [LYGAppDelegate getUUID];
    passwordStr = [[passwordStr md5EncodeString] lowercaseString];
	NSString * str = [NSString stringWithFormat:@"%@/API/User/reg.aspx?u=%@&p=%@&ct=%d&clientid=%@&e=%@&q=%@&a=%@",SERVER_URL,phoneStr,passwordStr,1,uuid,emailStr,questionStr,answerStr];
	
	NSURL *url = [NSURL URLWithString:str];
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; 
	
	[request setCompletionBlock:^
	 {
		 //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc] init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 int num = [[dic objectForKey:@"NO"] intValue];		 
         NSString *msg = [dic objectForKey:@"Msg"];
	     [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"regist"];
		 
		 if (num == 0)
		 {
			 aCompletionBlock(msg,0);
			 
		 }
		 
		 else
		 {
			 
			 aCompletionBlock(msg,1);
		 }	
		 
	 }];
	
	[request setFailedBlock:^
	 {
		
		 
		 aCompletionBlock(nil,0);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];
	
	
}


#pragma mark -
#pragma mark 登录

+ (void)getLoginPhoneContent:(NSString *)phoneNumStr passwordContent:(NSString *)passwordStr completionBlock:(void (^) (NSDictionary *,int))completionBlock
{
	NSLog(@"%@ %@",phoneNumStr,passwordStr);
	//NSString * uuid = [(LYGAppDelegate*)([UIApplication sharedApplication].delegate) getuuid];	
    NSString * uuid   = [LYGAppDelegate getUUID];
    NSLog(@"%@",uuid);
    passwordStr = [[passwordStr md5EncodeString] lowercaseString];
	NSString * str = [NSString stringWithFormat:@"%@/API/User/login.aspx?u=%@&p=%@&ct=%d&clientid=%@",SERVER_URL,phoneNumStr,passwordStr,1,uuid];
    NSString * str2 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [NSURL URLWithString:str2];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];	
	[request setCompletionBlock:^
	 {
         //[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
         NSLog(@"%@",request.responseString);
         //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *contentStr = [dic objectForKey:@"Result"];
		 NSString *msg  = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"msg"];
		 if (num == 0) 
		 {
			 
			 completionBlock(nil,0);
			 
		 }
		 else 
		 {
			 
			 NSDictionary *resultDic = [json objectWithString:contentStr error:nil];
		     BYNLogin *login = [[BYNLogin alloc] initWithDictionary:resultDic];
			 login.ID = [resultDic objectForKey:@"id"];
			 login.pwd = [resultDic objectForKey:@"Pwd"];
			 login.group_id = [resultDic objectForKey:@"group_id"];
			 login.nick_name = [resultDic objectForKey:@"Nick_name"];
			 login.email = [resultDic objectForKey:@"email"];
			 login.clientID = [resultDic objectForKey:@"ClientID"];
			 login.phone = [resultDic objectForKey:@"Phone"];
			 		     
			 [login release];
				 
			 completionBlock(resultDic,1);
			 			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 //[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
		 completionBlock(nil,0);
	 }];	
	request.timeOutSeconds = 60;
	[request startAsynchronous];
	//[SVProgressHUD showWithStatus:@"Login..."];
    //[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
	
}


#pragma mark -
#pragma mark 找回密码（1）
+ (void)getFoundPwdPhoneContent:(NSString *)phoneNumStr  completionBlock:(void (^) (NSString *,int))completionBlock
{
	
	
	NSString * str = [NSString stringWithFormat:@"%@/api/user/findpwd.aspx?name=%@&step=1",SERVER_URL,phoneNumStr];
	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];	
	[request setCompletionBlock:^
	 {
         //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *contentStr = [dic objectForKey:@"Result"];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"findpwd"];
		 
		 if (num == 0) 
		 {
			 
			completionBlock(msg,0);
			 
		 }
		 else 
		 {
			 NSArray *result = [contentStr componentsSeparatedByString:@","];
			 NSString *questionStr = [result objectAtIndex:0];
			 NSString *uidStr = [result objectAtIndex:1];
			 [[NSUserDefaults standardUserDefaults] setValue:questionStr forKey:@"question"];
			 [[NSUserDefaults standardUserDefaults] setValue:uidStr forKey:@"uidStr"];
			
			 completionBlock(msg,1);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 completionBlock(nil,0);
		 
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}



#pragma mark -
#pragma mark 找回密码（2）
+ (void)getSafetyQuestionContent:(NSString *)answerStr completionBlock:(void (^) (NSString *,int))completionBlock
{
	int uid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"uidStr"] intValue];
	
	NSString * str = [NSString stringWithFormat:@"%@/api/user/findpwd.aspx?answer=%@&step=2&uid=%d",SERVER_URL,answerStr,uid];
	
	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
         //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"safetyquestion"];
		 
		 if (num == 0) 
		 {
			 
			 completionBlock(msg,0);
			 
		 }
		 else 
		 {
			 completionBlock(msg,1);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 
		 completionBlock(nil,0);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}

#pragma mark -
#pragma mark 找回密码（3）
+ (void)getResetPwdContent:(NSString *)pwdStr completionBlock:(void (^) (int,NSString *))completionBlock
{
	
	int uid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"uidStr"] intValue];
		
	NSString * str = [NSString stringWithFormat:@"%@/api/user/findpwd.aspx?step=3&uid=%d&pwd=%@",SERVER_URL,uid,pwdStr];	
	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
         //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"resetpwd"];
		 
		 if (num == 0) 
		 {
			 
			 completionBlock(0,msg);
			 
		 }
		 else 
		 {
			 completionBlock(1,msg);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 
		 completionBlock(0,nil);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}

#pragma mark -
#pragma mark 意见反馈
+ (void)getFeedbackContent:(NSString *)contentStr contactStr:(NSString *)phoneNumStr completionBlock:(void (^) (NSString *,int))completionBlock
{
	
	int uid= [LYGAppDelegate getSharedLoginedUserInfo].ID;
		
	NSString * str = [NSString stringWithFormat:@"%@/Api/yijian/Default.aspx?uid=%d&con=%@&phone=%@&name=%@",SERVER_URL,uid,contentStr,phoneNumStr,phoneNumStr];
	NSURL *url = [NSURL URLWithString:str];	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];	
	[request setCompletionBlock:^
	 {
         //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"feedback"];
		 //NSLog(@"------#####-----%@",msg);
		 if (num == 0) 
		 {
			 completionBlock(msg,0);
			 
		 }
		 else 
		 {
			 completionBlock(msg,1);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 
		 completionBlock(nil,0);
		 
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}


#pragma mark -
#pragma mark  关于我们
+ (void)getAboutUSContent:(void (^) (NSArray *,int))completionBlock
{
	
	NSString * str = [NSString stringWithFormat:@"%@/API/News/List.aspx",SERVER_URL];
	NSURL *url = [NSURL URLWithString:str];	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
		 //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 NSString *num = [dic objectForKey:@"NO"];
		 NSString *contentStr = [dic objectForKey:@"Result"];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"aboutus"];
		 
		 
		 if (0 == [num intValue]) 
		 {
			 
			 completionBlock(nil,0);
			 
		 }
		 else 
		 {
			 NSArray *resultArray = [json objectWithString:contentStr error:nil];
			 NSMutableArray *tempArray = [[NSMutableArray alloc] init];
			 for (NSDictionary *dic in resultArray)
			 {
				 BYNUserCenter *aboutUs = [[BYNUserCenter alloc] initWithDictionary:dic];
				 [tempArray addObject:aboutUs];
				 [aboutUs release];
							 
			 }
             
			 completionBlock(tempArray,1);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 completionBlock(nil,0);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}


#pragma mark -
#pragma mark  关于我们----详细
+ (void)getSoftwareUsedContentWithID:(NSString *)aID completionBlock:(void (^) (NSString *,int))completionBlock
{
	
	NSString * str = [NSString stringWithFormat:@"%@/API/News/GetContent.aspx?id=%@",SERVER_URL,aID];
	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
		 //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 NSString *num = [dic objectForKey:@"NO"];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"aboutus"];
		 
		 
		 if (0 == [num intValue]) 
		 {
			 
			 completionBlock(msg,0);
			 
		 }
		 else 
		 {
			
			 completionBlock(msg,1);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 completionBlock(nil,0);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}



#pragma mark -
#pragma mark  软件设置

+ (void)switchPushSetting:(int)currentValue completionBlock:(void (^) (int,NSString *))completionBlock
{
	
	int uid= [LYGAppDelegate getSharedLoginedUserInfo].ID;
	
	NSString * str = [NSString stringWithFormat:@"%@/API/User/Ispush.aspx?uid=%d&value=%d",SERVER_URL,uid,currentValue];

	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];

	[request setCompletionBlock:^
	 {
		 //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
	 
		 int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"msg"];
		 //NSLog(@"-----%@",msg);
		 
		 if (num == 0) 
		 {
			 completionBlock(0,msg);
		 
		 }
		 else 
		 {
			 
			 completionBlock(1,msg);
		 
		 }
		 
	 }];

	[request setFailedBlock:^
	 {
	 
		 completionBlock(0,request.responseString);
	 }];

	request.timeOutSeconds = 60;
	[request startAsynchronous];
	
}



#pragma mark -
#pragma mark 会员管理
+ (void)getMemberInfo:(void (^) (NSArray *,int))completionBlock
{
	
	int uid= [LYGAppDelegate getSharedLoginedUserInfo].ID;
       	
	NSString * str = [NSString stringWithFormat:@"%@/API/User/joinShop.aspx?p=0&u=%d",SERVER_URL,uid];
	NSURL *url = [NSURL URLWithString:str];	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
		 //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 NSString *num = [dic objectForKey:@"NO"];
		 NSString *contentStr = [dic objectForKey:@"Result"];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"member"];
		 
		 if (0 == [num intValue]) 
		 {
			 
			 completionBlock(nil,0);
			 
		 }
		 else 
		 {
						 
			 NSArray *resultArray = [json objectWithString:contentStr error:nil];
			 NSMutableArray *tempArray = [[NSMutableArray alloc] init];
			 for (NSDictionary *dic in resultArray)
			 {
				 BYNMember *member = [[BYNMember alloc] initWithDictionary:dic];
				 [tempArray addObject:member];
				 [member release];
				 
			 }
			 
			 completionBlock(tempArray,1);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 completionBlock(nil,0);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}

#pragma mark -
#pragma mark 会员管理---注销会员

+(void)logoutMemberSettingWithID:(NSString *)aSuid completionBlock:(void (^) (int,NSString *))completionBlock
{
	
	
	NSString * str = [NSString stringWithFormat:@"%@/Api/shop/DelShopUser.aspx?id=%@",SERVER_URL,aSuid];
	
	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
		 //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 int num = [[dic objectForKey:@"NO"] intValue];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"logout"];
		 
		 if (num == 0) 
		 {
			 completionBlock(0,msg);
			 
		 }
		 else 
		 {
			 
			 completionBlock(1,msg);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 
		 completionBlock(0,request.responseString);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];
	
}


#pragma mark -
#pragma mark  精品推荐
+ (void)getjpDetailContentSearch:(NSString *)searchStr  completionBlock:(void (^) (NSArray *,int))completionBlock
{
	NSString *str;
	if ([searchStr isEqualToString:@""]|| searchStr == nil) 
	{
		 str = [NSString stringWithFormat:@"%@/api/app/List.aspx?c=0",SERVER_URL];
	}
	else
	{
		str = [NSString stringWithFormat:@"%@/api/app/List.aspx?c=0&key=%@",SERVER_URL,searchStr];
	}
	
	NSURL *url = [NSURL URLWithString:str];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	
	[request setCompletionBlock:^
	 {
		 //NSLog(@"------ %@",request.responseString);
		 SBJSON *json = [[SBJSON alloc]init];
		 NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		 
		 NSString *num = [dic objectForKey:@"NO"];
		 NSString *contentStr = [dic objectForKey:@"Result"];
		 NSString *msg = [dic objectForKey:@"Msg"];
		 [[NSUserDefaults standardUserDefaults] setValue:msg forKey:@"msg"];
		 if (0 == [num intValue]) 
		 {			 
			 completionBlock(nil,0);			 
		 }
		 else 
		 {
			 NSArray *resultArray = [json objectWithString:contentStr error:nil];
			 NSMutableArray *tempArray = [[NSMutableArray alloc] init];
			 for (NSDictionary *dic in resultArray)
			 {
				 BYNJPRecommend *jpRecommend = [[BYNJPRecommend alloc] initWithDictionary:dic];
				 [tempArray addObject:jpRecommend];
				 [jpRecommend release];
								 
			 }
             
			 completionBlock(tempArray,1);
			 
		 }
		 
	 }];
	
	[request setFailedBlock:^
	 {
		 completionBlock(nil,0);
	 }];
	
	request.timeOutSeconds = 60;
	[request startAsynchronous];	
	
}

@end
