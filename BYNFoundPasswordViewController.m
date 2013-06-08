//
//  BYNFoundPasswordViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNFoundPasswordViewController.h"
#import "BYNSafetyQuestionViewController.h"
#import "BYNUserCenterEngine.h"

@implementation BYNFoundPasswordViewController
@synthesize phoneNumTF = _phoneNumTF;


- (void)viewDidLoad 
{
    [super viewDidLoad];
	
}


-(IBAction)enterNextFoundPassword
{
	
	NSString *str = [_phoneNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([str isEqualToString:@""]) return;
	

		[BYNUserCenterEngine getFoundPwdPhoneContent:_phoneNumTF.text completionBlock:^(NSString *msgStr,int num)
		 {
			 
			 msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"findpwd"];
						
			 if (num == 0) 
			 {
				 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
				 [alertView show];
				 [alertView release];
			 }
			 
			 else 
			 {
				 
				 BYNSafetyQuestionViewController *safetyQuestionVC = [[BYNSafetyQuestionViewController alloc]init];
				 [self.navigationController pushViewController:safetyQuestionVC animated:YES];
				 [safetyQuestionVC release];
			 }
			 
		 }];
			
}


- (IBAction)downKeyboard
{
	[self.view endEditing:YES];
}


-(IBAction)foundPasswordBackBtnClick
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
	
	[_phoneNumTF release];
	[super dealloc];
}


@end
