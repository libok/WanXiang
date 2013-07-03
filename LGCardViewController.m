//
//  LGCardViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGCardViewController.h"
#import "LJLCodeCreateViewController.h"

@implementation LGCardViewController

@synthesize xingTextFiled = _xingTextFiled,nameTextFiled = _nameTextFiled,phoneTextFiled = _phoneTextFiled,emailTextFiled = _emailTextFiled,companyTextFiled = _companyTextFiled,httpTextFiled = _httpTextFiled,addressTextFiled = _addressTextFiled,jobTextFiled = _jobTextFiled,currentTextFiled = _currentTextFiled;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.mySCroview.contentSize = CGSizeMake(320, self.view.frame.size.height + 300);
	
	//注册通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];	
	
}

- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) setting
{
	[self.currentTextFiled resignFirstResponder];
	
	if (![self CheckLegitimacy:self.phoneTextFiled.text])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"输入号码不合法" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	//输入空格无效
	NSString *xingStr = [self.xingTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *nameStr = [self.nameTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	NSString *phoneStr = [self.phoneTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *emailStr = [self.emailTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *companyStr = [self.companyTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	NSString *httpStr = [self.httpTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *addressStr = [self.addressTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *jobStr = [self.jobTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];		
#pragma mark 名片生成-西瓜修改-
	if (![xingStr isEqualToString:@""] && ![nameStr isEqualToString:@""] && ![phoneStr isEqualToString:@""] && [self CheckLegitimacy:self.phoneTextFiled.text])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr =
        [NSString stringWithFormat:@"姓名:%@%@\n电话:%@\n邮箱:%@\n公司:%@\n网址:%@\n地址:%@\n职位:%@\n",
                                          xingStr,
                                          nameStr,
                                          phoneStr,
                                          (emailStr?emailStr:@""),
                                          (companyStr?companyStr:@""),
                                          (httpStr?httpStr:@""),
                                          (addressStr?addressStr:@""),
                                          (jobStr?jobStr:@"")];
        codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=2&n=%@&m=%@&p=%@&e=%@&d=%@&u=%@&z=%@&w=%@",SERVER_URL,xingStr,nameStr,phoneStr,emailStr,companyStr,httpStr,addressStr,jobStr];
		codeCreateViewController.codeType = 2;        
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}
	
}

- (IBAction) keyboard
{
	[self.currentTextFiled resignFirstResponder];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (textField.tag == 11) 
	{
		NSCharacterSet *cs;
		cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet]; 
		//invertedSet 方法是去反字符,把所有的除了数字的字符都找出来
		
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];  //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
		
		BOOL basicTest = [string isEqualToString:filtered];
		
		if ([string isEqualToString:@"\n"]) 
		{
			[self.currentTextFiled resignFirstResponder];
			return NO;
		}
		
		if(!basicTest) 
		{
			UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"请输入数字"delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alert show];
			[alert release];
			return NO;
		}    
		return basicTest;		
	}
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect rect = textField.frame;
    //NSLog(@"%f  %f",rect.origin.y,self.mySCroview.contentOffset.y);
    if (rect.origin.y - self.mySCroview.contentOffset.y > 108) {
        //self.myScrollview.contentOffset = CGPointMake(0, rect.origin.y - 100);
        [self.mySCroview setContentOffset:CGPointMake(0, rect.origin.y - 110) animated:YES];
    }else if (rect.origin.y - self.mySCroview.contentOffset.y < 108 && textField!= self.xingTextFiled)
    {
        [self.mySCroview setContentOffset:CGPointMake(0, rect.origin.y - 110) animated:YES];
    }

	self.currentTextFiled = textField;
	
	if (textField.tag == 11) 
	{
		
		doneInKeyboardButton.hidden = NO;
	}
}



- (void)textFieldDidEndEditing:(UITextField *)textField
{
       	if (textField.tag == 11)
	{
		doneInKeyboardButton.hidden = YES;

		if (![self.phoneTextFiled.text isEqualToString:@""])
		{
			if (![self CheckLegitimacy:self.phoneTextFiled.text])
			{
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"输入号码不合法" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
			}		
		}		
	}
}

//判断输入号码长度是否合法 
- (BOOL) CheckLegitimacy:(NSString *)aString
{
	int length = [aString length];
	if (length != 11 || ![aString hasPrefix:@"1"])
	{
		return NO;
	}
	else {
		return [self isPartialStringValid:aString];
	}
	
}

//判断输入类型是否合法
- (BOOL)isPartialStringValid:(NSString*)partialString
{
    int length = [partialString length];
    
    int index = 0;
    for (index = 0; index < length; index++)
    {
        unichar endCharacter = [partialString characterAtIndex:index];
        if (endCharacter >= '0' && endCharacter <= '9')
            continue;
        else
            return NO;
    }
    
    return YES;
}

#pragma mark 键盘
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (doneInKeyboardButton.superview)
    {
        [doneInKeyboardButton removeFromSuperview];
    }
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    if (doneInKeyboardButton == nil)
    {
        doneInKeyboardButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
		doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
		doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        //图片直接抠腾讯财付通里面的= =!
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up@2x.png"] forState:UIControlStateNormal];
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down@2x.png"] forState:UIControlStateHighlighted];
        [doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    if (doneInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:doneInKeyboardButton];    // 注意这里直接加到window上
    }
    
	if (self.currentTextFiled.tag == 11) 
	{
		doneInKeyboardButton.hidden = NO;
	}
	else 
	{
		doneInKeyboardButton.hidden = YES;
	}
}

-(void)finishAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setMySCroview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{   
	[_xingTextFiled release];
	[_nameTextFiled release];
	[_phoneTextFiled release];
	[_emailTextFiled release];
	[_companyTextFiled release];
	[_httpTextFiled release];
	[_addressTextFiled release];
	[_jobTextFiled release];
	[_currentTextFiled release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [_mySCroview release];
    [super dealloc];
}


@end
