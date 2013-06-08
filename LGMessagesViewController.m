//
//  LGMessagesViewController.m
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LGMessagesViewController.h"
#import "LJLCodeCreateViewController.h"

@implementation LGMessagesViewController
@synthesize phoneTextField = _phoneTextField;
@synthesize inTextView = _inTextView;

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
	_isback = YES;
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) setting
{
	[self.inTextView resignFirstResponder];
	//输入空格无效
	NSString *dhao = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *dcontent = [self.inTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if ([self CheckLegitimacy:dhao] && ![dcontent isEqualToString:@""])
	{				
		LJLCodeCreateViewController * codeCreateViewController = [[LJLCodeCreateViewController alloc] init];
        codeCreateViewController.contentStr    = [NSString stringWithFormat:@"%@;%@",dhao,dcontent];
        codeCreateViewController.urlString = [NSString stringWithFormat:@"%@/API/QR/QRmi.aspx?Type=6&dhao=%@&dcontent=%@",SERVER_URL,dhao,dcontent];
		codeCreateViewController.codeType = 6;        
		[self.navigationController pushViewController:codeCreateViewController animated:YES];
		[codeCreateViewController release];
	}
	
}


- (IBAction) addlinkman
{
	_isadded = YES;
	[self pushABPeopleVC];
}

- (IBAction) keyboard
{
	[self.phoneTextField resignFirstResponder];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSCharacterSet *cs;
	cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet]; 
	//invertedSet 方法是去反字符,把所有的除了数字的字符都找出来
	
	NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];  //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
	
	
	BOOL basicTest = [string isEqualToString:filtered];
	
	if ([string isEqualToString:@"\n"]) 
	{
		[self.phoneTextField resignFirstResponder];
		return NO;
	}
	
	if(!basicTest) 
		
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"请输入数字"delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return NO;
	}    
	return basicTest;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];	
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if (doneInKeyboardButton.superview)
    {
        [doneInKeyboardButton removeFromSuperview];
    }
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	if (_isadded == YES) 
	{
		_isadded = NO;
		return;
	}
	if (_isback == YES) 
	{
		return;
	}	
	
	if (![self.phoneTextField.text isEqualToString:@""])
	{
		if (![self CheckLegitimacy:self.phoneTextField.text])
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"输入号码不合法" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}		
	}		
}

#pragma mark -
#pragma mark 通讯录

//要用通讯录时，首先要导入两个框架 AddressBook.framework | AddressBookUI.framework
- (void)pushABPeopleVC
{
    ABPeoplePickerNavigationController *peopleVC = [[ABPeoplePickerNavigationController alloc] init]; 
    peopleVC.peoplePickerDelegate = self;
    //[self presentModalViewController:peopleVC animated:YES];
    [self presentViewController:peopleVC animated:YES completion:nil];
    [peopleVC release];
    
}
//点击cacel按钮时调用方法
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    //[peoplePicker dismissModalViewControllerAnimated:YES];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}
//选中一个人的时候应该进行什么操作
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}
//选中一个人之后又
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{    
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    //查询现在选中的属性索引
    int index =  ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);
    
    //根据索引去数组中找出相应的属性
    NSString *phone =  (NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
	
	NSCharacterSet *cs;
	// 去除字符串中除了"0123456789" 之外的所有字符
	cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789" ] invertedSet];
	//invertedSet 方法是去反字符,把所有的除了数字的字符都找出来
	
	self.phoneTextField.text = [[phone componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];  //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
	
    //[peoplePicker dismissModalViewControllerAnimated:YES];
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;    
}

//判断输入号码长度是否合法 
- (BOOL) CheckLegitimacy:(NSString *)aString
{
	int length = [aString length];
	if (length != 11 || ![aString hasPrefix:@"1"])
	{
		return NO;
	}
	else {
		return [self isPartialStringValid:aString];
	}
	
}

//判断输入类型是否合法
- (BOOL)isPartialStringValid:(NSString*)partialString
{
    int length = [partialString length];
    
    int index = 0;
    for (index = 0; index < length; index++)
    {
        unichar endCharacter = [partialString characterAtIndex:index];
        if (endCharacter >= '0' && endCharacter <= '9')
            continue;
        else
            return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text   
{   
    if (range.location>=50)    
    {   
		if ([text isEqualToString:@"\n"])
		{
			NSLog(@"失去第一响应");
			[self.inTextView resignFirstResponder];
		}		
		self.inTextView.text = [self.inTextView.text substringToIndex:50];
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

#pragma mark 键盘
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (doneInKeyboardButton.superview)
    {
        [doneInKeyboardButton removeFromSuperview];
    }
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    if (doneInKeyboardButton == nil)
    {
        doneInKeyboardButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
		doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
		doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up@2x.png"] forState:UIControlStateNormal];
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down@2x.png"] forState:UIControlStateHighlighted];
        [doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    if (doneInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:doneInKeyboardButton];    // 注意这里直接加到window上
    }
}

-(void)finishAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
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
	[_phoneTextField release];
	[_inTextView release];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}


@end
