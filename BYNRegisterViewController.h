//
//  svn://banyanan@192.168.1.124/sub1.h
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYNRegisterViewController : UIViewController 
{
	IBOutlet  UITextField   *_phoneNumberField;
	IBOutlet  UITextField   *_passwordField;
	IBOutlet  UITextField   *_emailField;
	IBOutlet  UITextField   *_questionField;
	IBOutlet  UITextField   *_answerField;
	
	IBOutlet  UIButton      *_showPasswordBtn;
	IBOutlet  UIScrollView  *_scrollView;
	
}
@property (nonatomic,retain) UITextField  *phoneNumberField;

- (IBAction)registBackBtnClick;
- (IBAction)showPasswordBtnClick;
- (IBAction)DoneBtnClick;
- (IBAction)downKeyboard;
-(BOOL)textfieldInputIsOK;
-(void)textfieldBeganInput:(UITextField *)aTextField messageString:(NSString *)aStr;



@end
