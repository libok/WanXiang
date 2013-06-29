//
//  TextGreatViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TextGreatViewController.h"
#import "NSString+Base64.h"

//#import "ZBarSDK.h"
#import "QRCodeGenerator.h"
#import "LJLCodeCreateViewController.h"


@implementation TextGreatViewController

@synthesize inTextView = _inTextView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.inTextView.scrollEnabled = NO;
	self.inTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
}

- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction) setting
{
	[self.inTextView resignFirstResponder];
	//输入空格无效
	NSString *str = [self.inTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if (![str isEqualToString:@""])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr = str;
        codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=0&con=%@",SERVER_URL,str];
		codeCreateViewController.codeType = 0;        
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}	
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text   
{   
    if (range.length >=50)
    {   
		if ([text isEqualToString:@"\n"])
		{
			NSLog(@"失去第一响应");
			[self.inTextView resignFirstResponder];
		}		
		self.inTextView.text = [self.inTextView.text substringToIndex:50];
		//UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"内容限制50字" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alertView show];
		//[alertView release];
		
		return  NO;   
    }   
    else    
    {   
		if ([text isEqualToString:@"\n"])
		{
			[self.inTextView resignFirstResponder];
		}
		
        return YES;   
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
	[_inTextView release];
    [super dealloc];
}


@end
