//
//  LGWeiBoViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-5.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGWeiBoViewController.h"
#import "ASIFormDataRequest.h"
#import "SBJSON.h"
#import "MBProgressHUD.h"
#define CLIENT_KEY     @"2506984097"
#define CLIENT_SECRET  @"3454aa2b1fb3c87f4571f345022b1f16"
#define REDIRECT_URL   @"http://www.zhiyou100.com/"

#define ACCESS_TOKEN_KEY @"access_token"
#define EXPIRES_IN_KEY   @"expires_in"

#define AUTHORIZE_URL  @"https://api.weibo.com/oauth2/authorize"

@implementation LGWeiBoViewController

@synthesize myCode = _myCode,myToken = _myToken,flag = _flag,openid = _openid;
@synthesize weiboTextView = _weiboTextView;
@synthesize weiboImageView = _weiboImageView,beijingImageView = _beijingImageView;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	if ([self.flag isEqualToString:@"xinlang"]) 
	{
		_titleLabel.text = @"分享到新浪微博";
		if (!self.myToken) 
		{
			NSLog(@"my code is %@",self.myCode);
			[self getAccessToken:self.myCode];
		}
	}
	else
	{
		_titleLabel.text = @"分享到腾讯微博";
		
		if (!self.myToken) 
		{
			[self gettengxunToken:self.myCode];
		}		
	}

	self.weiboTextView.scrollEnabled = NO;
	self.weiboTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction) FaBiao
{
	[self.weiboTextView resignFirstResponder];
	
	if ([self.flag isEqualToString:@"xinlang"]) 
	{
		if (![self.weiboTextView.text isEqualToString:@""]) 
		{
			ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://upload.api.weibo.com/2/statuses/upload.json"]];
			
			[request setPostValue:self.myToken forKey:@"access_token"];
			//微博内容
			NSString *str = self.weiboTextView.text;
			[request setPostValue:[NSString stringWithFormat:@"%@",str] forKey:@"status"];
			
			//地理坐标  自动获取当前坐标
			//[request setPostValue:@"" forKey:@"lat"];
			//[request setPostValue:@"" forKey:@"long"];
			
			NSData *data = [UIImageJPEGRepresentation(self.weiboImageView.image, 1.0) retain];
			[request addData:data forKey:@"pic"];
			
			request.delegate = self;
			//[SVProgressHUD showWithStatus:@"微博发表中"];
            [MBProgressHUD showHUDAddedTo:self.view message:@"微博发表中" animated:YES];
			[request setDidFinishSelector:@selector(Successed:)];
			[request setDidFailSelector:@selector(Filed:)];
			request.timeOutSeconds = TIMEOUTSECONDS;
			
			[request startAsynchronous];
		}		
	}
	else 
	{
		//发表腾讯微博
		
		NSString *urlString = [NSString stringWithFormat:@"https://open.t.qq.com/api/t/add_pic?oauth_consumer_key=801371833&access_token=%@&openid=%@&clientip=10.0.0.172&oauth_version=2.a&scope=all",self.myToken,self.openid];
		
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
		[request setPostValue:@"json" forKey:@"format"];
		[request setPostValue:self.weiboTextView.text forKey:@"content"];
		[request setPostValue:@"25.097336280247237" forKey:@"latitude"];
		[request setPostValue:@"121.69024586677551" forKey:@"longitude"];
		
		NSData *data = [UIImageJPEGRepresentation(self.weiboImageView.image, 1.0) retain];
		[request addData:data forKey:@"pic"];
		
		request.delegate = self;
		//[SVProgressHUD showWithStatus:@"微博发表中"];
		[MBProgressHUD showHUDAddedTo:self.view message:@"微博发表中" animated:YES];
		[request setDidFinishSelector:@selector(Successed:)];
		[request setDidFailSelector:@selector(Filed:)];
		request.timeOutSeconds = TIMEOUTSECONDS;
		
		[request startAsynchronous];		
	}
}

#pragma mark -
#pragma mark ASIFormDataRequest 代理
- (void) Successed:(ASIHTTPRequest *)request
{
	//[SVProgressHUD dismiss];
    //MBProgressHUD showHUDAddedTo:self.view message:<#(NSString *)#> animated:<#(BOOL)#>
   // [MBProgressHUD showHUDAddedTo:self.view message:@"微博发表成功" animated:YES];
    
    NSLog(@"______________   %@",request.responseString);
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    SBJSON *json = [[SBJSON alloc] init];
    NSDictionary *dic = [json objectWithString:request.responseString error:nil];
    
    
    if ([self.flag isEqualToString:@"xinlang"])
	{
		
        if (![dic objectForKey:@"error"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"微博发表成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"微博发表失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }

    }
	else
    {
        if ([[dic objectForKey:@"errcode"] intValue] == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"微博发表成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"微博发表失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            [alertView release];
        }

    
    }
    
    
       
    
}
- (void) Filed:(ASIHTTPRequest *)request
{
	//[SVProgressHUD showErrorWithStatus:@"微博发表失败"];
    //[MBProgressHUD showHUDAddedTo:self.view message:@"微博发表失败" animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"微博发表失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
    [alertView release];
}


- (void)getAccessToken:(NSString *)aCode
{
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]];
	
	[request setPostValue:CLIENT_KEY forKey:@"client_id"];
	[request setPostValue:CLIENT_SECRET forKey:@"client_secret"];
	[request setPostValue:@"authorization_code" forKey:@"grant_type"];
	[request setPostValue:aCode forKey:@"code"];
	[request setPostValue:REDIRECT_URL forKey:@"redirect_uri"];
	request.delegate = self;
	
	[request startAsynchronous];	
}

- (void)gettengxunToken:(NSString *)aCode
{
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://open.t.qq.com/cgi-bin/oauth2/access_token?"]];
	[request setPostValue:@"801371833" forKey:@"client_id"];
	[request setPostValue:@"7d01ae6047e522b71a5a1e6ef5414000" forKey:@"client_secret"];
	[request setPostValue:@"authorization_code" forKey:@"grant_type"];
	[request setPostValue:aCode forKey:@"code"];
	[request setPostValue:@"http://www.wanxiangwang.net" forKey:@"redirect_uri"];
	request.delegate = self;
	[request startAsynchronous];	
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
	if ([self.flag isEqualToString:@"xinlang"])
	{
		//创建一个json 对象，用于解析返回的json 数据，
		SBJSON *json = [[SBJSON alloc] init];
		//返回一个字典
		NSDictionary *dic = [json objectWithString:request.responseString error:nil];
		NSString *errorString = [dic objectForKey:@"error"];
		NSString *accessToken = [dic objectForKey:@"access_token"];
		[json release];
		NSLog(@"my accessToken is %@",accessToken);
		
		if (errorString || !accessToken)
		{
			NSLog(@"获取token失败");
		}
		else 
		{
			self.myToken = accessToken;
			[self saveAccessToken:dic];
		}		
	}
	else 
	{
		//腾讯
		
		NSString *xAccessToken = [[request.responseString componentsSeparatedByString:@"="] objectAtIndex:1];
		NSString *accessToken = [[xAccessToken componentsSeparatedByString:@"&"] objectAtIndex:0];
		NSString *xOpenid = [[request.responseString componentsSeparatedByString:@"="] objectAtIndex:4];
		NSString *openId = [[xOpenid componentsSeparatedByString:@"&"] objectAtIndex:0];
		
		self.myToken = accessToken;
		self.openid = openId;
		
		[self savetengxunAccessToken:accessToken and:openId];		
	}

}


- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSLog(@"%@",request.error);
}

- (void) saveAccessToken:(NSDictionary *)aDic
{
	NSString *accessToken = [aDic objectForKey:@"access_token"];
	NSString *expiresIn = [aDic objectForKey:@"expires_in"];
	
	//获取当前时间加上[expiresIn doubleValue]token 生命期的时间
	NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
	
	[[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:ACCESS_TOKEN_KEY];
	[[NSUserDefaults standardUserDefaults] setValue:expiresDate forKey:EXPIRES_IN_KEY];
	
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) savetengxunAccessToken:(NSString *)accessToken and:(NSString *)openId
{	
	NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:7*24*60*60.0];
	
	[[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:@"tengxunToken"];
	[[NSUserDefaults standardUserDefaults] setValue:expiresDate forKey:@"tengxunDate"];
	[[NSUserDefaults standardUserDefaults] setValue:openId forKey:@"tengxunopenid"];
	
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text   
{   
    if (range.location>=50)    
    {   
		self.weiboTextView.text = [self.weiboTextView.text substringToIndex:20];
			
		if ([text isEqualToString:@"\n"])
		{
			NSLog(@"失去第一响应");
			[self.weiboTextView resignFirstResponder];
		}		
		
		return  NO;   
    }   
    else    
    {   
		if ([text isEqualToString:@"\n"])
		{
			[self.weiboTextView resignFirstResponder];
		}
		
        return YES;   
    }
}   

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
	self.weiboTextView.frame = CGRectMake(70, 120, 179, 134);
	self.beijingImageView.frame = CGRectMake(68, 118, 183, 140);
	//self.weiboImageView.hidden = YES;
	
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
	self.weiboTextView.frame = CGRectMake(70, 285, 179, 134);
	self.beijingImageView.frame = CGRectMake(68, 282, 183, 140);
	//self.weiboImageView.hidden = NO;	
	
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[_myCode release];
	[_myToken release];
	[_flag release];
	[_openid release];
	[_weiboTextView release];
	[_weiboImageView release];
	[_beijingImageView release];
    [super dealloc];
}


@end
