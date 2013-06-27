//
//  LGSettingViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LJLCodeCreateViewController.h"
#import "LGWeiBoViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"
#import "ZBarSDK.h"
#import "QRCodeGenerator.h"
#import "NSString+Base64.h"
#import "SBJSON.h"
#import "LYGTwoDimensionCodeModel.h"
#import "LYGTwoDimensionCodeDao.h"
#import "LYGAppDelegate.h"
#import "QRCodeGenerator.h"
#import "MBProgressHUD.h"

#define CLIENT_KEY     @"2506984097"
#define REDIRECT_URL   @"http://www.zhiyou100.com/"
#define ACCESS_TOKEN_KEY @"access_token"
#define AUTHORIZE_URL  @"https://api.weibo.com/oauth2/authorize"
#define EXPIRES_IN_KEY   @"expires_in"

@implementation LJLCodeCreateViewController

@synthesize imageCropper = _imageCropper;
@synthesize erweimaImageView = _erweimaImageView;
@synthesize contentStr = _contentStr;
@synthesize share = _share;
@synthesize codeType = _codeType;
@synthesize urlString = _urlString,myType = _myType;
@synthesize mySwitch  = _mySwitch;
@synthesize oneModel  = _oneModel;
@synthesize currentColor = _currentColor;
@synthesize infoImage;
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	//NSLog(@"2222%@",self.contentStr);
    [super viewDidLoad];
    self.currentColor = [UIColor blackColor];
    self.erweimaImageView.image = [QRCodeGenerator qrImageForString:self.contentStr imageSize:self.erweimaImageView.bounds.size.width color:[UIColor blackColor]];
    _oneModel                   = [[LYGTwoDimensionCodeModel alloc]init];
    _oneModel.type              = self.codeType;
	_oneModel.myType            = self.myType;
    _oneModel.isCreated         = YES;
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    _oneModel.content    = [self.contentStr stringByAddingPercentEscapesUsingEncoding:enc];
    _oneModel.content    = self.contentStr;
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    const char* cstring = [self.contentStr cStringUsingEncoding:enc];
//    _oneModel.content     = [NSString  stringWithCString:cstring encoding:enc];
}


- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}

//****把一张图片画到另一张图片上面，添加二维码中间个性码的原理（中间图片的大小控制在28.5一下可以被有效识别，大于识别率会降低）
- (UIImage *) image:(UIImage *)aImage
{
	return [self mergeImage:_erweimaImageView.image topImage:aImage];
}

- (UIImage *) mergeImage:(UIImage *)backImage topImage:(UIImage *)topImage
{
    //合并图片的方法
	
	//背景图片的大小
	CGSize finalSize = {192,192};
	//前景图的大小
 	UIGraphicsBeginImageContext(finalSize);
	
	//把下面的画在上面的，注意顺序
	[backImage drawInRect:CGRectMake(0,0,finalSize.width,finalSize.height)];
	[topImage drawInRect:CGRectMake(82.25,82.25,28.5,28.5)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	return newImage;

}



- (IBAction)changeColor:(UIButton*)sender 
{
    if (sender.backgroundColor == self.currentColor) {
        return;
    }
    UIImage *image = nil;    
    self.currentColor = sender.backgroundColor;
    if (self.mySwitch.on) {
        image = [QRCodeGenerator qrImageForString:self.oneModel.encryptedString imageSize:192 color:self.currentColor];
    }else
    {
        image = [QRCodeGenerator qrImageForString:self.oneModel.content imageSize:192 color:self.currentColor];
    }
    
    if (infoImage)
    {
        
        self.erweimaImageView.image = [self mergeImage:image topImage:infoImage];
    }
    else
    {
        self.erweimaImageView.image = image;
    }

}

- (UIImage *) aimage
{
	//合并图片的方法
	//背景图片的大小
	CGSize finalSize = {192,192};
	//前景图的大小
	CGSize hatSize = [_erweimaImageView.image size];
	UIGraphicsBeginImageContext(finalSize);
	UIImage *saveImage = [UIImage imageNamed:@"主页背景1.png"];
	//把下面的画在上面的，注意顺序
	[saveImage drawInRect:CGRectMake(0,0,hatSize.width,hatSize.height)];
	[_erweimaImageView.image drawInRect:CGRectMake(0,0,hatSize.width,hatSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	return newImage;
}
-(NSString*)getEncrytedString:(NSString*)responseString
{
    NSString * str1 = SERVER_URL;
    NSString * str2 = [str1 stringByAppendingString:DECIPERURLSTRING];
    NSArray * arry  = [responseString componentsSeparatedByString:@"/"];
    NSString * stringID = [[[arry lastObject] componentsSeparatedByString:@"."] objectAtIndex:0];
    return  [str2 stringByAppendingFormat:@"%d&id=%@",self.codeType,stringID];
}

- (IBAction) isEnciphermented
{
	if (_mySwitch.on == YES) 
	{
        NSLog(@"%@",self.urlString);
        
        //Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//        if (reach.currentReachabilityStatus == NotReachable) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"您好像没联网" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
//            [_mySwitch setOn:NO animated:YES];
//            return;
//        }
        BOOL isAailble = [LYGAppDelegate netWorkIsAvailable];
        if (!isAailble) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            _mySwitch.on = NO;
            return;
        }

        
        ASIHTTPRequest * request = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSLog(@"%@",self.urlString);
        request.timeOutSeconds = TIMEOUTSECONDS;
        __block LJLCodeCreateViewController * codeCreate = self;        
		[request setCompletionBlock:^{        
            NSLog(@"xxxx  %@",request.responseString);
            SBJSON * json = [[SBJSON alloc]init];
            NSError * error = nil;
            NSDictionary * dict = [json objectWithString:request.responseString error:&error];
            NSString * returnsult = [dict objectForKey:@"NO"];
            [json release];
            int a = [returnsult intValue];
            if (a == 0) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"加密失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                [codeCreate.mySwitch setOn:NO];
                [request release];
                return;
            }
            NSLog(@"%@",request.responseString);
            codeCreate.oneModel.encryptedString      = [codeCreate getEncrytedString:[dict objectForKey:@"Result"]];
            codeCreate.oneModel.isSecret             = YES;
            codeCreate.oneModel.erweimaImage         = [QRCodeGenerator qrImageForString:codeCreate.oneModel.encryptedString imageSize:400 color:self.currentColor];
            codeCreate.erweimaImageView.image     = codeCreate.oneModel.erweimaImage; 
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        [request setFailedBlock:^{
            NSLog(@"ffffffff%@",request.responseString);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络好像出了点问题" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [codeCreate.mySwitch setOn:NO];
            [request release];
        }];
        request.timeOutSeconds = TIMEOUTSECONDS;
        [request startAsynchronous];
		//[SVProgressHUD showWithStatus:@"正在进行网络加密"];
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [MBProgressHUD showHUDAddedTo:self.view message:@"正在进行网络加密" animated:YES];
        
	}
	else 
	{
        UIImage *image = [QRCodeGenerator qrImageForString:self.contentStr imageSize:self.erweimaImageView.bounds.size.width color:self.currentColor];
        if (infoImage)
        {
            
            self.erweimaImageView.image = [self mergeImage:image topImage:infoImage];
        }
        else
        {
            self.erweimaImageView.image = image;
        }
    }
}

- (IBAction) gexingshengma
{
	if (_mySwitch.on == YES) 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络加密无法添加个性码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else 
	{
		UIImagePickerController *imageController = [[UIImagePickerController alloc] init];
        imageController.allowsEditing = YES;
		//判断当前设备是否有摄像头，或者相册
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
		{
			imageController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		}
		
		imageController.delegate = self;
		//[self presentModalViewController:imageController animated:YES];
        [self presentViewController:imageController animated:YES completion:nil];
	}
}

- (IBAction) share:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	if (btn.tag == 111) 
	{
		weiboleixing = @"xinlang";
		NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN_KEY];

		if (token) 
		{
			NSDate *nowdate = [NSDate date];
			NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:EXPIRES_IN_KEY];
			switch ([nowdate compare:date]) 
			{
				case NSOrderedSame:
				{
					//NSLog(@"same");
					[self isRequest];
					break;
				}
				case NSOrderedAscending: 
				{
					//NSLog(@"nowdate is earlier than date");
					LGWeiBoViewController *weibo = [[LGWeiBoViewController alloc] init];
					weibo.myToken = token;
					weibo.flag = weiboleixing;
					[self.navigationController pushViewController:weibo animated:YES];
					weibo.weiboImageView.image = self.erweimaImageView.image;
					weibo.weiboImageView.image = [self aimage];
					break;
				}
				case NSOrderedDescending:
				{
					[self isRequest];
					break;
				}
				default:
				break;			
			}
		}
		else 
		{
			[self isRequest];
		}
	}
	else 
	{
		weiboleixing = @"tengxun";
		//发腾讯微博请求
		
		NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"tengxunToken"];
		
		if (token) 
		{
			NSDate *nowdate = [NSDate date];
			NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:@"tengxunDate"];
			switch ([nowdate compare:date]) 
			{
				case NSOrderedSame:
				{
					[self tengxunRequest];
					break;
				}
				case NSOrderedAscending: 
				{
					NSString *openid = [[NSUserDefaults standardUserDefaults] objectForKey:@"tengxunopenid"];
					
					LGWeiBoViewController *weibo = [[LGWeiBoViewController alloc] init];
					weibo.myToken = token;
					weibo.openid = openid;
					weibo.flag = weiboleixing;
					[self.navigationController pushViewController:weibo animated:YES];
                    [weibo release];
					weibo.weiboImageView.image = self.erweimaImageView.image;
					break;
				}
				case NSOrderedDescending:
				{
					[self tengxunRequest];
					break;
				}
				default:
					break;			
			}
		}
		else 
		{
			[self tengxunRequest];
		}		
	}
}

- (void) isRequest
{
	self.share = [[UIWebView alloc] initWithFrame:self.view.bounds];
	self.share.delegate = self;
	[self.view addSubview:self.share];
	[_share release];
	
	NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=mobile",AUTHORIZE_URL,CLIENT_KEY,REDIRECT_URL];
	NSURL *url = [NSURL URLWithString:urlString]; 
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[_share loadRequest:request];						
}

- (void) tengxunRequest
{
	self.share = [[UIWebView alloc] initWithFrame:self.view.bounds];
	self.share.delegate = self;
	[self.view addSubview:self.share];
	
	[_share release];
	
	NSString *urlString =@"https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=801371833&response_type=code&redirect_uri=http://www.wanxiangwang.net";
	NSURL *url = [NSURL URLWithString:urlString]; 
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[_share loadRequest:request];							
}

-(NSString *)getcurrenttime
{
    NSDate * date = [NSDate date];
    int xx = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%d",xx];
}
-(NSString *)getSandBoxPahth
{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        return  [paths objectAtIndex:0];
}


- (IBAction)saveTwoDimesionCode:(id)sender 
{
	NSLog(@"333%@",_oneModel.myType);
    [LYGTwoDimensionCodeDao insert:_oneModel];
    UIImageWriteToSavedPhotosAlbum(self.erweimaImageView.image, nil, nil, nil);
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"已经保存到照片库" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{	
//	backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//	backImageView.image = [UIImage imageNamed:@"主页背景1.png"];
//	backImageView.userInteractionEnabled = YES;
//	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//	imageView.image = [UIImage imageNamed:@"顶部.png"];
//	[backImageView addSubview:imageView];
//	[self.view addSubview:backImageView];
//	
//	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(125, 0, 100, 38)];
//	label.text = @"设置图标";
//	label.textColor = [UIColor whiteColor];
//	label.backgroundColor = [UIColor clearColor];
//	[imageView addSubview:label];
//	[label release];
//	
//	self.imageCropper = [[NLImageCropperView alloc] initWithFrame:CGRectMake(0, 44, 320, 436)];
//    [backImageView addSubview:_imageCropper];
//	[_imageCropper release];
//    [_imageCropper setImage:image];
//    [_imageCropper setCropRegionRect:CGRectMake(10, 50, 100, 100)];
//				
//	[self addbackAndOKButton];
//	
//	UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 380, 300, 100)];
//	tishiLabel.text = @"可以通过放大缩小和移动取景框设置图标";
//	tishiLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
//	tishiLabel.backgroundColor = [UIColor clearColor];
//	tishiLabel.textColor = [UIColor redColor];
//	[backImageView addSubview:tishiLabel];
//	[tishiLabel release];
    self.infoImage = image;
    self.erweimaImageView.image = [self image:image];
    
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)addbackAndOKButton
{
	UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(15, 8, 28, 25)];    
    [backImageView addSubview:backBtn];
    
    [backBtn addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
	[backBtn setBackgroundImage:[UIImage imageNamed:@"返回0.png"] forState:UIControlStateNormal];
	
	UIButton *OKbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [OKbtn setFrame:CGRectMake(270, 8, 28, 25)];
    
    [backImageView addSubview:OKbtn];
    
    [OKbtn addTarget:self action:@selector(imageGrop) forControlEvents:UIControlEventTouchUpInside];
	[OKbtn setBackgroundImage:[UIImage imageNamed:@"完成按钮.png"] forState:UIControlStateNormal];	
}

- (void) imageGrop
{
	self.erweimaImageView.image = [self image:[_imageCropper getCroppedImage]];
	[backImageView removeFromSuperview];
}
- (void) backto
{
	[backImageView removeFromSuperview];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	if ([weiboleixing isEqualToString:@"xinlang"]) 
	{
		NSString *urlString = [request.URL absoluteString];
		//登陆授权之后调用
		
		if ([urlString rangeOfString:REDIRECT_URL].location != NSNotFound && [urlString rangeOfString:@"code="].location != NSNotFound) 
		{
			NSString *code = [[[request.URL query] componentsSeparatedByString:@"="] objectAtIndex:1];
			if (code) 
			{
				LGWeiBoViewController *weibo = [[LGWeiBoViewController alloc] init];
				weibo.myCode = code;
				weibo.flag = weiboleixing;
				[self.navigationController pushViewController:weibo animated:YES];
				weibo.weiboImageView.image = self.erweimaImageView.image;
                [weibo release];

				[self.share removeFromSuperview];
			}
			else 
			{
				//[SVProgressHUD showErrorWithStatus:@"登陆失败"];
                [MBProgressHUD showHUDAddedTo:self.view message:@"登陆失败" animated:YES];
			}
		}
		
	}
	else
	{
		//这里写腾讯微博
		
		NSURL *url = request.URL;
		NSString *urlString = url.absoluteString;
		NSLog(@"%@",urlString);
		
		if ([urlString rangeOfString:@"http://www.wanxiangwang.net"].location != NSNotFound && [urlString rangeOfString:@"code="].location != NSNotFound) 
		{
			NSString *xCode = [[url.query componentsSeparatedByString:@"="] objectAtIndex:1];
			NSString *code = [[xCode componentsSeparatedByString:@"&"] objectAtIndex:0];
			//NSLog(@"1111%@",xCode);
			
			if (code) 
			{
				LGWeiBoViewController *weibo = [[LGWeiBoViewController alloc] init];
				weibo.myCode = code;
				weibo.flag = weiboleixing;
				[self.navigationController pushViewController:weibo animated:YES];
				weibo.weiboImageView.image = self.erweimaImageView.image;
                [weibo release];
				[self.share removeFromSuperview];				
			}
			else 
			{
				//[SVProgressHUD showErrorWithStatus:@"登陆失败"];
                [MBProgressHUD showHUDAddedTo:self.view message:@"登陆失败" animated:YES];
			}
		}		
	}
	return YES;
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
	//[SVProgressHUD showWithStatus:@"正在努力的加载"];
    NSLog(@"%@",webView.request.URL);
    [MBProgressHUD showHUDAddedTo:webView message:@"正在努力的加载" animated:YES];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{	
	//[SVProgressHUD dismiss];
    [MBProgressHUD hideHUDForView:webView animated:YES];
	close = [UIButton buttonWithType:UIButtonTypeCustom];
	close.frame = CGRectMake(10, 430, 20, 20);
	[close setBackgroundImage:[UIImage imageNamed:@"close@2x.png"] forState:UIControlStateNormal];
	[close addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
	[self.share addSubview:close];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:webView animated:YES];

}

- (void) closeWebView
{
	[close removeFromSuperview];
	[self.share removeFromSuperview];
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
	[_erweimaImageView release];
	[_imageCropper release];
	[_contentStr release];
	[_myType release];
	[_share release];
    [_oneModel release];
    [infoImage release];
    
    [super dealloc];
}


@end
