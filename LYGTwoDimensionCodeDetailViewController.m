//
//  LYGTwoDimensionCodeDetailViewController.m
//  wanxiangerweima
//
//  Created by  on 13-4-15.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LYGTwoDimensionCodeDetailViewController.h"
#import "QRCodeGenerator.h"
@implementation LYGTwoDimensionCodeDetailViewController
@synthesize titleLabel;
@synthesize myImageView;
@synthesize myLabel;
@synthesize amodel = _amodel;
@synthesize Myview = _Myview;
@synthesize Name   = _Name;
@synthesize Http   = _Http;
@synthesize NameLabel = _NameLabel;
@synthesize HttpLabel = _HttpLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	NSLog(@"%@",self.amodel.content);
    [super viewDidLoad];
		
	NSArray *typeArray = [[[NSArray alloc] initWithObjects:@"文本详情",@"网址详情",@"名片详情",@"电话详情",@"E-mail详情",@"",@"短信详情",@"wifi详情",@"地图详情",nil] autorelease];
	NSArray *Array = [[[NSArray alloc] initWithObjects:@"文本内容：",@"网址连接：",@"名片详情",@"电话号码：",@"邮箱地址：",@"",@"短信详情：",@"wifi详情",@"地图坐标：",nil] autorelease];
	titleLabel.text = [typeArray objectAtIndex:self.amodel.type];
	myLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18.0f];
	myLabel.text = [Array objectAtIndex:self.amodel.type];
	
    UIImage * image = nil;
    BOOL isSecret   = self.amodel.isSecret;
    if (isSecret) {
        image = [QRCodeGenerator qrImageForString:self.amodel.encryptedString imageSize:400 color:[UIColor blackColor]];
    }else
    {
        image = [QRCodeGenerator qrImageForString:self.amodel.content imageSize:400 color:[UIColor blackColor]];
    }
    self.myImageView.image  = image;
	
	[self moreMessege];
}

- (void) viewWillAppear:(BOOL)animated
{
	if (self.amodel.type == 1 || (self.amodel.type == 2 && ![self.amodel.myType isEqualToString:@"http"]) || self.amodel.type == 7 || self.amodel.type == 8) 
	{
		self.Myview.hidden = NO;
	}
	else
	{
		self.Myview.hidden = YES;
	}
}

- (void) moreMessege
{
	switch (self.amodel.type) 
	{
		case 0:
		{	
			UIImageView *beijingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(77, 303, 162, 122)];
			beijingImageView.image = [UIImage imageNamed:@"文本生码的背景框.png"];
			[self.view addSubview:beijingImageView];
			UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(78, 304, 160, 120)];
			textView.font = [UIFont systemFontOfSize:15];
			textView.editable = NO;
			//NSLog(@"11111%@",self.amodel.content);
			textView.text = self.amodel.content;
			[self.view addSubview:textView];
			[textView release];
			[beijingImageView release];
			break;
		}
		case 1:
		{
            if ([self.amodel.myType isEqualToString:@"weibo"]) 
			{
				NSString *name = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:0];
				NSString *http = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
				self.NameLabel.text = @"微博名称";
				self.HttpLabel.text = @"网址链接";
				self.Name.text = name;
				self.Http.text = http;
				
				UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
				btn.frame = CGRectMake(85, 410,150, 40);
				[btn setBackgroundImage:[UIImage imageNamed:@"二维码扫描结果按钮2.png"] forState:UIControlStateNormal];
				btn.tag = 001;
				[btn setTitle:@"打开链接" forState:UIControlStateNormal];
				[btn addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
				[self.view addSubview:btn];
				
			}
			else if([self.amodel.myType isEqualToString:@"web"]) 
			{
				NSString *name = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:0];
				NSString *http = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
				self.NameLabel.text = @"书签名称";
				self.HttpLabel.text = @"网址链接";
				self.Name.text = name;
				self.Http.text = http;		
				
				UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
				btn.frame = CGRectMake(85, 410,150, 40);
				[btn setBackgroundImage:[UIImage imageNamed:@"二维码扫描结果按钮2.png"] forState:UIControlStateNormal];
				btn.tag = 002;
				[btn setTitle:@"打开链接" forState:UIControlStateNormal];
				[btn addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
				[self.view addSubview:btn];
			}
			else //if ([self.amodel.myType isEqualToString:@"http"]) 
			{
				UIImageView *beijingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 308, 160, 82)];
				beijingImageView.image = [UIImage imageNamed:@"文本生码的背景框.png"];
				[self.view addSubview:beijingImageView];
				UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(81, 312, 158, 80)];
				textView.font = [UIFont systemFontOfSize:15];
				textView.editable = NO;
				textView.text = self.amodel.content;
				[self.view addSubview:textView];
				[textView release];
				[beijingImageView release];
				
				UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
				btn.frame = CGRectMake(85, 410,150, 40);
				[btn setBackgroundImage:[UIImage imageNamed:@"二维码扫描结果按钮2.png"] forState:UIControlStateNormal];
				btn.tag = 003;
				[btn setTitle:@"打开链接" forState:UIControlStateNormal];
				[btn addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
				[self.view addSubview:btn];
				
			}
			
			break;
		}
		case 2:
		{
			
			NSString *xing = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:0];
			NSString *ming = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
			NSString *phone = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:2];
			self.NameLabel.text = @"姓  名：";
			self.HttpLabel.text = @"电  话：";
			self.Name.text = [NSString stringWithFormat:@"%@%@",xing,ming];
			self.Http.text = phone;
			break;
		}
		case 3:
		{
			UITextField *phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(82, 324, 120, 30)]; 
			phoneTextField.enabled = NO;
			phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
			[self.view addSubview:phoneTextField];
			phoneTextField.text = self.amodel.content;
			[phoneTextField release];
			
			UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			phoneBtn.frame = CGRectMake(210, 324, 30, 30);
			[phoneBtn setImage:[UIImage imageNamed:@"电话.png"] forState:UIControlStateNormal];
			[phoneBtn addTarget:self action:@selector(callPhone_sendMessage) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:phoneBtn];
			break;
		}
		case 4:
		{
			UIImageView *beijingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 303, 152, 80)];
			beijingImageView.image = [UIImage imageNamed:@"文本生码的背景框.png"];
			[self.view addSubview:beijingImageView];
			UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(86, 304, 150, 78)];
			textView.font = [UIFont systemFontOfSize:15];
			textView.editable = NO;
			textView.text = self.amodel.content;
			[self.view addSubview:textView];
			[textView release];
			[beijingImageView release];
			
			UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.frame = CGRectMake(95, 400,130, 40);
			[btn setBackgroundImage:[UIImage imageNamed:@"二维码扫描结果按钮2.png"] forState:UIControlStateNormal];
			btn.tag = 004;
			[btn setTitle:@"打开邮箱" forState:UIControlStateNormal];
			[btn addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btn];
			break;
		}
		case 6:
		{
			NSString *name = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:0];
			NSString *http = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
			
			UITextField *phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(82, 304, 120, 30)]; 
			phoneTextField.enabled = NO;
			phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
			[self.view addSubview:phoneTextField];
			phoneTextField.text = name;
			[phoneTextField release];
			
			UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			phoneBtn.frame = CGRectMake(208, 304, 30, 30);
			[phoneBtn setImage:[UIImage imageNamed:@"duanxin.png"] forState:UIControlStateNormal];
			[phoneBtn addTarget:self action:@selector(callPhone_sendMessage) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:phoneBtn];
			
			UIImageView *beijingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 348, 157, 82)];
			beijingImageView.image = [UIImage imageNamed:@"文本生码的背景框.png"];
			[self.view addSubview:beijingImageView];
			UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(81, 349, 155, 80)];
			textView.font = [UIFont systemFontOfSize:15];
			textView.text = http;
			textView.editable = NO;
			[self.view addSubview:textView];
			[textView release];
			[beijingImageView release];
			
			break;
			
		}
		case 7:
		{
			NSString *name = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:0];
			NSString *http = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
			self.NameLabel.text = @"wifi帐号";
			self.HttpLabel.text = @"wifi密码";
			self.Name.text = name;
			self.Http.text = http;			
			break;
		}
		case 8:
		{
			NSString *lat = [[self.amodel.content componentsSeparatedByString:@","] objectAtIndex:0];
			NSString *lng = [[self.amodel.content componentsSeparatedByString:@","] objectAtIndex:1];
			self.NameLabel.text = @"纬 度：";
			self.HttpLabel.text = @"经 度：";
			self.Name.text = lat;
			self.Http.text = lng;		
			break;
		}
			
		default:
			break;
	}	
}

- (void) openURL:(UIButton *)btn
{
	switch (btn.tag) 
	{
		case 001:
		{
			NSString *http = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",http]]];
			break;
		}
		case 002:
		{
			NSString *http = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",http]]];
			break;
		}
		case 003:
		{
            NSLog(@"%@",self.amodel.content);
//			NSString *http = [[self.amodel.content componentsSeparatedByString:@"/"] objectAtIndex:2];
//			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",http]]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.amodel.content]];
			break;
		}
		case 004:
		{
			MFMailComposeViewController*mailPicker = [[MFMailComposeViewController alloc]init];

			mailPicker.mailComposeDelegate=self;

			//设置主题  
			[mailPicker setSubject:@"eMail主题"];

			// 添加发送者  
			NSArray*toRecipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",self.amodel.content]];
			
			[mailPicker setToRecipients:toRecipients];

			NSString *emailBody=@"eMail正文";  //邮件内容
			[mailPicker setMessageBody:emailBody isHTML:YES];

			//[self presentModalViewController:mailPicker animated:YES];
            [self presentViewController:mailPicker animated:YES completion:nil];
			[mailPicker release];
			
			break;			
		}
			
		default:
			break;
	}
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate
-(void)mailComposeController:(MFMailComposeViewController*)controller
didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch(result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
}

//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) callPhone_sendMessage
{
	if (self.amodel.type == 6) 
	{
		NSString *phone = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:0];
		NSString *message = [[self.amodel.content componentsSeparatedByString:@";"] objectAtIndex:1];
		
		if( [MFMessageComposeViewController canSendText] )
		{
			MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init]; //autorelease];
			controller.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",phone]];
			controller.body = [NSString stringWithFormat:@"%@",message];
			controller.messageComposeDelegate = self;
			
			//[self presentModalViewController:controller animated:YES];
            [self presentViewController:controller animated:YES completion:nil];
			[[[[controller viewControllers] lastObject] navigationItem] setTitle:@"发送短信"];//修改短信界面标题
			[controller release];
		}
		else
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" 
															message:@"该设备不支持短信功能" 
														   delegate:self 
												  cancelButtonTitle:nil
												  otherButtonTitles:@"确定", nil];
			[alert show];
			[alert release];
		}
	}	
	else
	{
        UIWebView * web = [[UIWebView alloc]init];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.amodel.content]]]];
	}
}

#pragma mark -
#pragma mark MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	//[controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    [controller dismissViewControllerAnimated:NO completion:nil];
	switch ( result ) {
		case MessageComposeResultCancelled:
        {
			//click cancel button
		}
			break;
		case MessageComposeResultFailed:// send failed
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" 
															message:@"短信发送失败" 
														   delegate:self 
												  cancelButtonTitle:nil
												  otherButtonTitles:@"确定", nil];
			[alert show];
			[alert release];			
			break;
		}
		case MessageComposeResultSent:
		{
			
			//do something
		}
			break;
		default:
			break;
	}
	
}
- (void)viewDidUnload
{
    [self setMyImageView:nil];
    [self setMyLabel:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_amodel release];
    [myImageView release];
    [myLabel release];
    [titleLabel release];
	[_NameLabel release];
	[_HttpLabel release];
	[_Myview release];
	[_Name release];
	[_Http release];
    [super dealloc];
}
- (IBAction)buttonClick:(id)sender {
}

- (IBAction)backBUttonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
