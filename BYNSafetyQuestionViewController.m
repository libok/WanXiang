//
//  BYNSafetyQuestionViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNSafetyQuestionViewController.h"
#import "BYNResetPasswordViewController.h"
#import "LYGAppDelegate.h"
#import "BYNUserCenterEngine.h"

@implementation BYNSafetyQuestionViewController
@synthesize answerTF = _answerTF;
@synthesize questionTF = _questionTF;

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
		
}



-(IBAction)enterNextFoundPassword
{
	
	NSString *str1 = [_questionTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	NSString *str2 = [_answerTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([str1 isEqualToString:@""]||[str2 isEqualToString:@""]) return;	
	
	
	[BYNUserCenterEngine getSafetyQuestionContent:_answerTF.text  completionBlock:^(NSString *msgStr,int num)
	 {
		 NSString *questionStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"question"];
		 NSLog(@"-----3333333---%@",questionStr);
		  
		 if (![_questionTF.text isEqualToString:questionStr])
		 {
			
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"问题不正确" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			 [alertView show];
			 [alertView release];
			 
			 return;
		 }
		 
		 msgStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"safetyquestion"];
		 
		 if (num == 0) 
		 {
			 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
			 [alertView show];
			 [alertView release];
		 }
		 
		 else 
		 {
			 
			 BYNResetPasswordViewController *resetPasswordVC = [[BYNResetPasswordViewController alloc]init];
			 [self.navigationController pushViewController:resetPasswordVC animated:YES];
			 [resetPasswordVC release];			 
		 }
		 
	 }];

	

		
}

- (IBAction)downKeyboard
{
	[self.view endEditing:YES];
}


-(IBAction)safetyQuestionBackBtnClick
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
    [_answerTF release];
	[_questionTF release];
	[super dealloc];
}


@end
