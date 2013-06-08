//
//  LGMessagesViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>


@interface LGMessagesViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate> 
{
	IBOutlet UITextField *_phoneTextField;
	IBOutlet UITextView  *_inTextView;
	BOOL                  _isadded;
	BOOL                  _isback;
	UIButton             *doneInKeyboardButton;
}

@property (nonatomic,retain) UITextField *phoneTextField;
@property (nonatomic,retain) UITextView  *inTextView;

- (IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;
- (IBAction) addlinkman;

- (void)pushABPeopleVC;
- (BOOL) CheckLegitimacy:(NSString *)aString;
- (BOOL)isPartialStringValid:(NSString*)partialString;

@end
