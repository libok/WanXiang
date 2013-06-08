//
//  BYNFeedbackViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNFeedbackViewController.h"
#import "BYNUserCenterEngine.h"
#import "LYGAppDelegate.h"
#import "BYNLoginViewController.h"


@implementation BYNFeedbackViewController

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
	
	_contentTextView.showsVerticalScrollIndicator = NO;
	_scrollView.contentSize = CGSizeMake(320, 530);
	
}

- (IBAction)feedbackSuccess
{

	NSString *str = [_contentTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([str isEqualToString:@""]) return;
	
		
		[BYNUserCenterEngine getFeedbackContent:_contentTextView.text contactStr:_contactTextField.text completionBlock:^ (NSString * msgStr,int num)
		 {
			 int uid = [LYGAppDelegate getSharedLoginedUserInfo].ID;
			 msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"feedback"];
			 
			 if (uid == -1)
			 {
				 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您还没有登录，请先登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录",nil];
				 [alertView show];
				 [alertView release];
			 }
			 
						
			 else if (num == 0) 
			 {
				 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:msgStr message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
				 [alertView show];
				 [alertView release];
				 
			 }
			 else
			 {
				 
				 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
				 [alertView show];
				 [alertView release];
			 }
		 }];
		
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ([text isEqualToString:@"\n"])
	{
		[_contentTextView resignFirstResponder];
	}
	
	return YES;  
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{
		BYNLoginViewController *loginVC = [[BYNLoginViewController alloc] init];
		//[self.navigationController presentModalViewController:loginVC animated:YES];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
		[loginVC release];
			
	}
		
}
	

-(IBAction)feedbackBackBtnClick
{
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)downKeyboard
{
	[self.view endEditing:YES];
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
    [super dealloc];
}


@end
