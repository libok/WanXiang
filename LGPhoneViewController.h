//
//  LGPhoneViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@interface LGPhoneViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
{
	IBOutlet UITextField *_phoneTextField;
	BOOL                  _isadded;
	BOOL                  _isback;
	UIButton *doneInKeyboardButton;
}

@property (nonatomic,retain) UITextField *phoneTextField;

- (IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;
- (IBAction) addlinkman;

- (void)pushABPeopleVC;
- (BOOL) CheckLegitimacy:(NSString *)aString;
- (BOOL)isPartialStringValid:(NSString*)partialString;

@end
