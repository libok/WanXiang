//
//  LGWebViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGWebViewController.h"
#import "LJLCodeCreateViewController.h"

@implementation LGWebViewController

@synthesize wangzhanName = _wangzhanName,wangzhanHttp = _wangzhanHttp,currentTextFiled = _currentTextFiled;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) setting
{
	[self.currentTextFiled resignFirstResponder];
	
	//输入空格无效
	NSString *name = [self.wangzhanName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *http = [self.wangzhanHttp.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if (![name isEqualToString:@""] && ![http isEqualToString:@""] && ![http isEqualToString:@"http://"])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr = [NSString stringWithFormat:@"%@;%@",
										  name,http];
		codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=1&con=%@",SERVER_URL,http];
		codeCreateViewController.codeType = 1;   
		codeCreateViewController.myType = @"web";
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}
	
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
	[_wangzhanName release];
	[_wangzhanHttp release];
	[_currentTextFiled release];
    [super dealloc];
}


@end
