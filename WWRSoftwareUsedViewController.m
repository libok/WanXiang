//
//  WWRSoftwareUsedViewController.m
//  wanxiangerweima
//
//  Created by mac on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "WWRSoftwareUsedViewController.h"
#import "BYNUserCenterEngine.h"
#import "BYNUserCenter.h"


@implementation WWRSoftwareUsedViewController
@synthesize aboutUsTV = _aboutUsTV;
@synthesize newsID = _newsID;
@synthesize contentStr = _contentStr;


- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	
	[BYNUserCenterEngine getSoftwareUsedContentWithID:_newsID completionBlock:^(NSString *msgStr,int num)
	 {
		 msgStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"aboutus"];
		 if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:msgStr message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消",nil];
			 [alertView show];
			 [alertView release];
			 
		 }
		 else
		 {
			 self.aboutUsTV.text = _contentStr;
		 }
		 
		 
	 }];	
	
}

- (void)dealloc 
{
	
	[_aboutUsTV release];
	[_newsID release];
    [_contentStr release];
    [super dealloc];

}

- (IBAction)backButtonClick
{
	[self.navigationController popViewControllerAnimated:YES];
}


@end
