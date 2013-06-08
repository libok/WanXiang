//
//  BYNSoftwareSettingViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//#define SWITCH_KEY  @"switchStates"


#import "BYNSoftwareSettingViewController.h"
#import "BYNUserCenterEngine.h"
#import "SDImageCache.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"

@implementation BYNSoftwareSettingViewController

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

	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];    
	
    //检查是否是第一次运行
    if ([userDefaults boolForKey:@"hasRunBefore"] != YES)
		
    {
		
		//设置个标记使此if中字段只在第一次运行时执行
		[userDefaults setBool:YES forKey:@"hasRunBefore"];
		

		[userDefaults setBool:_notifySwicth.on forKey:@"isNotify"];
		[userDefaults setBool:_sinaSwitch.on forKey:@"sinaWeibo"];
		[userDefaults setBool:_tencentSwitch.on forKey:@"tencentWeibo"];
		
		[userDefaults synchronize];// 把设置的键值对同步
		
    }
	
	
	//从userDefaults取出
	_notifySwicth.on = [userDefaults boolForKey:@"isNotify"];
		
	_sinaSwitch.on = [userDefaults boolForKey:@"sinaWeibo"];
	_tencentSwitch.on = [userDefaults boolForKey:@"tencentWeibo"];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData) name:UIApplicationWillResignActiveNotification object:nil];
		 
}	
-(void)saveData
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setBool:_notifySwicth.on forKey:@"isNotify"];
	[userDefaults setBool:_sinaSwitch.on forKey:@"sinaWeibo"];
	[userDefaults setBool:_tencentSwitch.on forKey:@"tencentWeibo"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
}
	

- (IBAction)notifySwicthSetting
{
	
	int currentValue = _notifySwicth.on;
	
	[BYNUserCenterEngine switchPushSetting:currentValue completionBlock:^(int value,NSString *msgStr)
	{
		msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"msg"];
	
		int uid = [LYGAppDelegate getSharedLoginedUserInfo].ID;
		if (uid == -1)
		{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有登录，请先登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
			[alertView setTag:1];
			[alertView show];
			[alertView release];
		}
		
		
		else if (value == 0 ) 
		{
			if (currentValue == 0 ) 
			{
				[self switchSettingAlertView:msgStr];
				_notifySwicth.on = YES;
			}else 
			{
				[self switchSettingAlertView:msgStr];
				_notifySwicth.on = NO;
			}
			
		}
		else 
		{
			if (currentValue == 0) 
			{
				[self switchSettingAlertView:msgStr];
			}
			else 
			{
				[self switchSettingAlertView:msgStr];
			}		
		}
	
	}];
	
}


-(IBAction)weiboSwitch:(id)sender
{
	
	UISwitch *weiboSwitch = (UISwitch *)sender;
	int currentValue = -1;;
	switch (weiboSwitch.tag) 
	{
		case 1:
			currentValue = _sinaSwitch.on;
			break;
		case 2:
			currentValue = _tencentSwitch.on;
			break;
		default:
			break;
	}

	[BYNUserCenterEngine switchPushSetting:currentValue completionBlock:^(int value,NSString *msgStr)
	 {
		 msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"msg"];
		 
		 int uid = [LYGAppDelegate getSharedLoginedUserInfo].ID;
		 if (uid == -1)
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有登录，请先登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
			 [alertView setTag:2];
			 [alertView show];
			 [alertView release];
		 }
		 
				 
		 else if (value == 0 ) 
		 {
			 if (currentValue == 0 ) 
			 {
				 [self switchSettingAlertView:msgStr];
				 _sinaSwitch.on = YES;
				 _tencentSwitch.on = YES;
				 
			 }else 
			 {
				 [self switchSettingAlertView:msgStr];
				 _sinaSwitch.on = NO;
				 _tencentSwitch.on = NO;
			 }
			 
		 }
		 else 
		 {
			 if (currentValue == 0) 
			 {
				 [self switchSettingAlertView:msgStr];
			 }
			 else 
			 {
				 [self switchSettingAlertView:msgStr];
			 }		
		 }
		 
	 }];
	
}


-(void)switchSettingAlertView:(NSString *)aStr
{
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"\n%@\n",aStr]  message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	
}

-(IBAction)clearImageCache
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否清除图片缓存？"  message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
	[alertView setTag:3];
	[alertView show];
	[alertView release];
	
}


#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 1 || alertView.tag == 2) 
	{
		if(buttonIndex == 1)
		{
			BYNLoginViewController *loginVC = [[BYNLoginViewController alloc] init];
			//[self.navigationController presentModalViewController:loginVC animated:YES];
            [self.navigationController presentViewController:loginVC animated:YES completion:nil];
			[loginVC release];
			
		}
	}
	else if (alertView.tag == 3)
	{
		if(buttonIndex == 1)
		{
			[[SDImageCache sharedImageCache] clearDisk];
			
			[[SDImageCache sharedImageCache] clearMemory];
			
			[self switchSettingAlertView:@"已清除"];
		}
	}
		
}



-(IBAction)softwareSettingBackBtnClick
{
	[self saveData];
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


- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}


@end
