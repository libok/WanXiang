//
//  LGEmailViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGEmailViewController.h"
#import "LJLCodeCreateViewController.h"

@implementation LGEmailViewController
@synthesize emailTextField = _emailTextField;

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (IBAction) back
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) setting
{
	[self.emailTextField resignFirstResponder];
		
	//输入空格无效
	NSString *str = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if (![self validateEmail:str]) 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入正确的邮箱格式" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	if (![str isEqualToString:@""] && [self validateEmail:str])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr    = str;
		codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=4&con=%@",SERVER_URL,str];
		codeCreateViewController.codeType = 4;        
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}
	
}

- (IBAction) keyboard
{
	[self.emailTextField resignFirstResponder];
}

//判断邮箱格式是否正确
-(BOOL)validateEmail:(NSString*)email
{
    // 首先判断输入中是否含有" @ . " 符号
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy]autorelease];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [email substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
			return NO;
        }
        
        NSString *domainPart = [email substringFromIndex:range1.location+1];
		//
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2)
		{
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
			return NO;
        }
        
        return YES;
    }
    else 
	{
        return NO;
	}
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
	[_emailTextField release];
    [super dealloc];
}

@end