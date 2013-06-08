//
//  BYNRecommendDetailViewController.m
//  wanxiangerweima
//
//  Created by usr on 13-4-17.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BYNRecommendDetailViewController.h"


@implementation BYNRecommendDetailViewController


- (void)viewDidLoad 
{
    [super viewDidLoad];
	_recommendTV.text = @"我在么么么么么看到么么么么么么，推荐给你！";
}

-(IBAction)recommendContent
{
	NSString *str = [_recommendTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];	
	
	if ([str isEqualToString:@""]) return;
	
	[self sendsms:_recommendTV.text];
	
}

-(IBAction)selectContact
{
	[self pushABPeopleNav];
}

#pragma mark -
#pragma mark MFMessageComposeViewController

- (void)sendsms:(NSString *)message 
{
	
	Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
	
	if (messageClass != nil) 
	{
		if ([messageClass canSendText])
		{
			[self displaySMS:message];
		} 
		else 
		{
			[self alertWithTitle:nil msg:@"设备没有短信功能"];
		}
	} 
	else 
	{
		[self alertWithTitle:nil msg:@"iOS版本过低，iOS4.0以上才支持程序内发送短信"];
	}
	
}


- (void)displaySMS:(NSString *)message  
{
	
	MFMessageComposeViewController*picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate= self;
	// 默认信息内容
	picker.body = message; 
	// 默认收件人(可多个)
	picker.recipients = [NSArray arrayWithObjects:_phoneNumTF.text,nil];
	//[self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:nil];
	[picker release];
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg 
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
				message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result 
{
	NSString *msg;
	
	switch (result) 
	{
		case MessageComposeResultCancelled:
			msg = @"发送取消";
			break;
		case MessageComposeResultSent:
			msg = @"发送成功";
			[self alertWithTitle:nil msg:msg];
			break;
	    case MessageComposeResultFailed:
			msg = @"发送失败";
			[self alertWithTitle:nil msg:msg];
			break;
		default:
			break;
	}	
	//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
} 



#pragma mark -
#pragma mark 通讯录

-(void)pushABPeopleNav
{
	ABPeoplePickerNavigationController *peopleNav = [[ABPeoplePickerNavigationController alloc] init];
	peopleNav.peoplePickerDelegate = self;
	//[self presentModalViewController:peopleNav animated:YES];
    [self presentViewController:peopleNav animated:YES completion:nil];
	[peopleNav release];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	//[peoplePicker dismissModalViewControllerAnimated:YES];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
	return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	
	ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
	
	if (property == kABPersonPhoneProperty)
	{
		int index = ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);
		NSString *phone = (NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
		_phoneNumTF.text = phone;
				
		//[peoplePicker dismissModalViewControllerAnimated:YES];
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
	}
	
	return NO;
}





#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if ([text isEqualToString:@"\n"])
	{
		[_recommendTV resignFirstResponder];
	}
	
	return YES;  
}


- (IBAction)downKeyboard
{
	[self.view endEditing:YES];
}


-(IBAction)back
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


- (void)dealloc {
    [super dealloc];
}


@end
