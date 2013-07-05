//
//  BYNRegisterViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNRegisterViewController.h"
#import "BYNUserCenterEngine.h"



@implementation BYNRegisterViewController
@synthesize phoneNumberField = _phoneNumberField;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	_passwordField.secureTextEntry = YES;
	_scrollView.contentSize = CGSizeMake(320, 520);

}

-(IBAction)DoneBtnClick
{
	BOOL isRegisterSuccess = [self textfieldInputIsOK];
	if (!isRegisterSuccess) 
	{
		return;
	}
	
	__block BYNRegisterViewController * xxx = self;
    [BYNUserCenterEngine sendRegisterPhoneContent:_phoneNumberField.text passwordContent:_passwordField.text emailContent:_emailField.text questionContent:_questionField.text answerContent:_answerField.text completionBlock:^(NSString *msgStr,int num)
		
	 {
//         msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"regist"];
				 
		 if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消",nil];
			 [alertView show];
			 [alertView release];
		 }
		 else
		 {						 
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			 [alertView show];
			 [alertView release];
             [xxx.navigationController popViewControllerAnimated:YES];
		 }		 
	 }];
	
}



-(BOOL)textfieldInputIsOK
{
	//判断电话号码
	NSString *phoneNumStr = [_phoneNumberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([phoneNumStr isEqualToString:@""]) return NO;
	
	
	else if ([phoneNumStr hasPrefix:@"1"] && [phoneNumStr length] == 11) 
	{
		for (int i = 0; i < [phoneNumStr length]; i ++) 
		{
			unichar str = [phoneNumStr characterAtIndex:i];
			
			if (str >= '0' && str <= '9') 
			{
				continue;
			}
			else 
			{
			   [self textfieldBeganInput:_phoneNumberField messageString:@"号码输入不合法"];
				return NO;
			}
		}
		
	}
	else 
	{
		
		[self textfieldBeganInput:_phoneNumberField messageString:@"号码输入不合法"];
		
        return NO;
	}
	
	//判断密码
	NSString *passwordStr = [_passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([passwordStr isEqualToString:@""]) return NO;
	
	else if ([passwordStr length] <= 5)
	{
		
		[self textfieldBeganInput:_passwordField messageString:@"密码不能少于六位"];
		
		return NO;
	}
	
	
	
	//利用正则表达式验证邮箱是否合法
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
	
	NSString *emailStr = [_emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([emailStr isEqualToString:@""]) 
	{
		return NO;
	}
		
	if (![emailTest evaluateWithObject:emailStr]) 
	{
		[self textfieldBeganInput:_emailField messageString:@"邮箱格式不正确"];
		
		return NO;
		
	} 
	//安全问题
	NSString *questionStr = [_questionField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([questionStr isEqualToString:@""])
	{
		return NO;
	}
		

	//答案
	NSString *answerStr = [_answerField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([answerStr isEqualToString:@""]) 
	{
		return NO;
	}
	
	
	return YES;
}


-(void)textfieldBeganInput:(UITextField *)aTextField messageString:(NSString *)aStr 
{
	
			
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"系统提示" message:[NSString stringWithFormat:@"%@",aStr] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	
	[aTextField becomeFirstResponder];		

}



- (IBAction)showPasswordBtnClick
{
	
	if (_passwordField.secureTextEntry == YES) 
	{
		[_showPasswordBtn setBackgroundImage:[UIImage imageNamed:@"登陆记住密码点击后状态.png"] forState:UIControlStateNormal];
		
	}
	else 
	{
		[_showPasswordBtn setBackgroundImage:[UIImage imageNamed:@"记住密码未点击状态.png"] forState:UIControlStateNormal];
		
	}
	_passwordField.secureTextEntry = !_passwordField.secureTextEntry;
	
}



- (IBAction)downKeyboard
{
	[self.view endEditing:YES];

}


- (IBAction)registBackBtnClick
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        //[self dismissModalViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
	[_phoneNumberField release];
	[_passwordField release];
	[_emailField release];
	[_questionField release];
	[_answerField release];
	[_scrollView release];
    [super dealloc];
}


@end
