//
//  BYNLoginViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNLoginViewController : UIViewController 
{
    IBOutlet   UITextField  *_phoneNumberTF;
	IBOutlet   UITextField  *_passwordTF;
	IBOutlet   UIButton     *_recordBtn;
	BOOL                     _recordPwd;
}

- (IBAction)immediateRegisterBtnClick;
- (IBAction)loginBackBtnClick;
- (IBAction)forgotPasswordBtnClick;
- (IBAction)login;
- (IBAction)recoredBtnClick;
- (IBAction)downKeyboard;


@end
