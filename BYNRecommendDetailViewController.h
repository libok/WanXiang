//
//  BYNRecommendDetailViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-17.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface BYNRecommendDetailViewController : UIViewController<MFMessageComposeViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate>  
{
	IBOutlet  UITextView   *_recommendTV;
	IBOutlet  UITextField  *_phoneNumTF;
	IBOutlet  UIButton     *_contactBtn;
}

-(IBAction)recommendContent;
- (void)sendsms:(NSString *)message;
- (void)displaySMS:(NSString *)message; 
- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg;
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller 
				 didFinishWithResult:(MessageComposeResult)result;
-(IBAction)back;
- (IBAction)downKeyboard;

-(IBAction)selectContact;
-(void)pushABPeopleNav;

@end
