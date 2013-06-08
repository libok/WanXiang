//
//  LGCardViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGCardViewController : UIViewController 
{
	IBOutlet UITextField *_xingTextFiled;
	IBOutlet UITextField *_nameTextFiled;
	IBOutlet UITextField *_phoneTextFiled;
	IBOutlet UITextField *_emailTextFiled;
	IBOutlet UITextField *_companyTextFiled;
	IBOutlet UITextField *_httpTextFiled;
	IBOutlet UITextField *_addressTextFiled;
	IBOutlet UITextField *_jobTextFiled;
	UITextField          *_currentTextFiled;
	UIButton			 *doneInKeyboardButton;
}

@property (nonatomic,retain) UITextField *xingTextFiled;
@property (nonatomic,retain) UITextField *nameTextFiled;
@property (nonatomic,retain) UITextField *phoneTextFiled;
@property (nonatomic,retain) UITextField *emailTextFiled;
@property (nonatomic,retain) UITextField *companyTextFiled;
@property (nonatomic,retain) UITextField *httpTextFiled;
@property (nonatomic,retain) UITextField *addressTextFiled;
@property (nonatomic,retain) UITextField *jobTextFiled;
@property (nonatomic,retain) UITextField *currentTextFiled;

- (IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;
- (BOOL) CheckLegitimacy:(NSString *)aString;
- (BOOL)isPartialStringValid:(NSString*)partialString;

@end
