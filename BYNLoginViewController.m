//
//  BYNLoginViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNLoginViewController.h"
#import "BYNRegisterViewController.h"
#import "BYNFoundPasswordViewController.h"
#import "BYNUserCenterEngine.h"
#import "LoginedUserInfo.h"
#import "LYGAppDelegate.h"
#import "BYNLogin.h"
#import "MBProgressHUD.h"

@implementation BYNLoginViewController
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
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
	_passwordTF.secureTextEntry = YES;
	
	//从userDefaults中取_recordPwd的状态，第一次进入时为NO
	_recordPwd = [[NSUserDefaults standardUserDefaults] boolForKey:@"recordPwd"];
   
	//图片初始化
	if (_recordPwd == 0 ) 
	{
		[_recordBtn setBackgroundImage:[UIImage imageNamed:@"记住密码未点击状态.png"] forState:UIControlStateNormal];

	}
	else
	{
		
		[_recordBtn setBackgroundImage:[UIImage imageNamed:@"登陆记住密码点击后状态.png"] forState:UIControlStateNormal];
		//_recordBtn为记住密码状态时取password
		_passwordTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
	}	
	//判断username是否为空
	NSString *phoneNumString = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
	if (phoneNumString != nil) 
	{
		_phoneNumberTF.text = phoneNumString;
	}    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData) name:UIApplicationWillResignActiveNotification object:nil];
}


- (void)saveData
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	[userDefaults setObject:_phoneNumberTF.text forKey:@"username"];
	
	//_recordBtn为记住密码状态时，再将password存入userDefaults
	if (_recordPwd == 1) 
	{
	
		[userDefaults setObject:_passwordTF.text forKey:@"password"];
	}
	
	[userDefaults synchronize];
	
}


//点击是否记住密码
- (IBAction)recoredBtnClick
{
	_recordPwd = !_recordPwd;
	if (_recordPwd) 
	{
		//密码存入userDefaults
		[[NSUserDefaults standardUserDefaults] setObject:_passwordTF.text forKey:@"password"];
        [_recordBtn setBackgroundImage:[UIImage imageNamed:@"登陆记住密码点击后状态.png"] forState:UIControlStateNormal];
		
    }
    else
	{ 
		//清除存储密码
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
		[_recordBtn setBackgroundImage:[UIImage imageNamed:@"记住密码未点击状态.png"] forState:UIControlStateNormal];
	
    }
    //_recordBtn的状态存入UserDefaults
	[[NSUserDefaults standardUserDefaults] setBool:_recordPwd forKey:@"recordPwd"];

}





- (IBAction)login
{
    int x  = [LYGAppDelegate netWorkIsAvailable];
    if (!x) {
        UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"网络连接不可用" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alet show];
        [alet release];
        return;
    }
	NSString *phoneStr = [_phoneNumberTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	NSString *pwdStr = [_passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	if ([phoneStr isEqualToString:@""]||[pwdStr isEqualToString:@""]) return;
	
	[BYNUserCenterEngine getLoginPhoneContent:_phoneNumberTF.text passwordContent:_passwordTF.text completionBlock:^ (NSDictionary *loginDic,int num)
	{
	    [MBProgressHUD hideHUDForView:self.view animated:YES];
		if (num == 0) 
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
			[alertView show];
			[alertView release];
		}
		else
		{
			[self saveData];
			LoginedUserInfo *temp = [LYGAppDelegate getSharedLoginedUserInfo];
			BYNLogin *login = [[BYNLogin alloc] initWithDictionary:loginDic];
			temp.ID = [login.ID intValue];
			temp.pwd = login.pwd;
			temp.group_id = login.group_id; 
			temp.nick_name = login.nick_name; 
			temp.email = login.email;
			temp.clientID = login.clientID;
			temp.phone = login.phone;
			[[NSNotificationCenter defaultCenter] postNotificationName:@"success" object:nil];
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"msg"] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			[alertView show];
			[alertView release];
            [self loginBackBtnClick];
		}
	}];
    [MBProgressHUD showHUDAddedTo:self.view message:@"正在登录中" animated:YES];
}




-(IBAction)forgotPasswordBtnClick
{
	BYNFoundPasswordViewController *foundPasswordVC = [[BYNFoundPasswordViewController alloc]init];
	[self.navigationController pushViewController:foundPasswordVC animated:YES];
	[foundPasswordVC release];
}

-(IBAction)immediateRegisterBtnClick
{
	BYNRegisterViewController *registerVC = [[BYNRegisterViewController alloc]init];
    if (self.navigationController) 
	{
        [self.navigationController pushViewController:registerVC animated:YES];
    }else
    {
        //[self presentModalViewController:registerVC animated:YES];
        [self presentViewController:registerVC animated:YES completion:nil];
    } 
	[registerVC release];
}

- (IBAction)downKeyboard
{
	[self.view endEditing:YES];
}


-(IBAction)loginBackBtnClick
{
    if (self.navigationController) 
	{
        [self.navigationController popViewControllerAnimated:YES];
    }
	else
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


- (void)dealloc {
 
    [[NSNotificationCenter defaultCenter]removeObserver:self];
 
    [super dealloc];
}


@end
