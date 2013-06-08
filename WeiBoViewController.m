//
//  WeiBoViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WeiBoViewController.h"
#import "LJLCodeCreateViewController.h"

@implementation WeiBoViewController

@synthesize weiboHttp = _weiboHttp,weiboName = _weiboName,currentTextFiled = _currentTextFiled;

- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) setting
{
	[self.currentTextFiled resignFirstResponder];
	
	NSCharacterSet *cs;
	cs = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghjklimnopqrstuvwxyz:/,.?=%"] invertedSet]; 
	NSString *filtered = [[self.weiboHttp.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];  //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
	
	BOOL basicTest = [self.weiboHttp.text isEqualToString:filtered];
		
	if(!basicTest) 
		
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"请输入正确的网址"delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		return;
	}    
	
	//输入空格无效
	NSString *weiboname = [self.weiboName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *weibohttp = [self.weiboHttp.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if (![weiboname isEqualToString:@""] && ![weibohttp isEqualToString:@""] && ![weibohttp isEqualToString:@"http://"])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr = [NSString stringWithFormat:@"%@;%@",
										  weiboname,weibohttp];
        codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=1&con=%@",SERVER_URL,weibohttp];
		codeCreateViewController.codeType = 1;
        codeCreateViewController.myType = @"weibo";
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}
	
}

- (IBAction) keyboard
{
	[self.currentTextFiled resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	self.currentTextFiled = textField;
}

#pragma mark -
#pragma mark UITextFieldDelegate


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
	[_weiboName release];
	[_weiboHttp release];
	[_currentTextFiled release];
    [super dealloc];
}


@end
