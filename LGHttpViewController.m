//
//  LGHttpViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGHttpViewController.h"
#import "LJLCodeCreateViewController.h"

@implementation LGHttpViewController

@synthesize httpTextField = _httpTextField;


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
	[self.httpTextField resignFirstResponder];
	
	//输入空格无效
	NSString *str = [self.httpTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if (![str isEqualToString:@""] && ![str isEqualToString:@"http://"])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr    = str;
		codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=1&con=%@",SERVER_URL,str];
        codeCreateViewController.codeType = 1;   
		codeCreateViewController.myType = @"http";
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}
	
}

- (IBAction) keyboard
{
	[self.httpTextField resignFirstResponder];
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
	[_httpTextField release];
    [super dealloc];
}


@end
