//
//  BYNResetPasswordViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNResetPasswordViewController.h"
#import "BYNUserCenterEngine.h"
#import "BYNLoginViewController.h"
#import "NSString+MD5HexDigest.h"

@implementation BYNResetPasswordViewController
@synthesize pwdTextField = _pwdTextField;
@synthesize rePwdTextField = _rePwdTextField;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)resetSuccessBtnClick
{
	if (_pwdTextField.text.length <= 5) {
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"密码不能少于六位" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
		[alertView show];
		return;
		
	}
	
	if (![_rePwdTextField.text isEqualToString:_pwdTextField.text])
	{
		UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"两次密码不相同" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
		[alertView show];
		return;
	}
	
	
	
	[BYNUserCenterEngine getResetPwdContent:[_pwdTextField.text md5EncodeString] completionBlock:^(int num,NSString *msgStr)
	 {
		 msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"resetpwd"];
		 		 
		 if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
			 [alertView show];
			 [alertView release];
		 }
		 
		 else 
		 {
	         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
			 [alertView show];
			 [alertView release];
//			 BYNResetSuccessViewController *resetSuccessVC = [[BYNResetSuccessViewController alloc]init];
//			 [self.navigationController pushViewController:resetSuccessVC animated:YES];
//			 [resetSuccessVC release];
		 }
		 
	 }];
	
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{
		BYNLoginViewController *loginVC = [[BYNLoginViewController alloc] init];
        NSArray * arry = self.navigationController.viewControllers;
        [self.navigationController popToViewController:[arry objectAtIndex:2] animated:NO];
		[self.navigationController pushViewController:loginVC animated:YES];
        
		[loginVC release];
	}
}


- (IBAction)downKeyboard
{
	[self.view endEditing:YES];
}

-(IBAction)resetPasswordBackBtnClick
{
	
	[self.navigationController popViewControllerAnimated:YES];
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
	[_pwdTextField  release];
	[_rePwdTextField release];
    [super dealloc];
}


@end
