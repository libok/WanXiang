//
//  LGWifiViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGWifiViewController.h"
#import "LJLCodeCreateViewController.h"

@implementation LGWifiViewController
@synthesize accountsTextField = _accountsTextField,passwordTextField = _passwordTextField,typeTextField = _typeTextField,currentTextFiled = _currentTextFiled;
@synthesize xialaView = _xialaView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.xialaView.frame = CGRectMake(209, 246, 75, 0);
	self.xialaView.clipsToBounds = YES;
}



- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) setting
{
	//输入空格无效
	NSString *accounts = [self.accountsTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *type = [self.typeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	
	if (![accounts isEqualToString:@""] && ![password isEqualToString:@""] && ![type isEqualToString:@""])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr = [NSString stringWithFormat:@"%@;%@;%@",accounts,password,type];
        codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=7&whao=%@&wmi=%@&wtype=%@",SERVER_URL,accounts,password,type];
		codeCreateViewController.codeType = 7;        
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}
	
}
- (IBAction) xialabtn
{
	//if not open then open
	if (_isOpen == NO) 
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		self.xialaView.frame = CGRectMake(209, 246, 75, 124);
		
		[UIView commitAnimations];
		_isOpen = YES;
	}
	else {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		self.xialaView.frame = CGRectMake(209, 246, 75, 0);
		
		[UIView commitAnimations];
		_isOpen = NO;		
	}

}

-(void)select:(id)sender
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	self.xialaView.frame = CGRectMake(209, 246, 75, 0);	
	[UIView commitAnimations];
	_isOpen = NO;
	UIButton *btn = (UIButton *)sender;
	self.typeTextField.text = btn.titleLabel.text;
}

- (IBAction) keyboard
{
	[self.currentTextFiled resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	self.currentTextFiled = textField;
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
	[_accountsTextField release];
	[_passwordTextField release];
	[_currentTextFiled release];
	[_typeTextField release];
	[_xialaView release];
    [super dealloc];
}


@end
