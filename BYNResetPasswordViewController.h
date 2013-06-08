//
//  BYNResetPasswordViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNResetPasswordViewController : UIViewController 
{
    IBOutlet UITextField  *_pwdTextField;
	IBOutlet UITextField  *_rePwdTextField;
	
}
@property (nonatomic,retain) UITextField  *pwdTextField;
@property (nonatomic,retain) UITextField  *rePwdTextField;

- (IBAction)resetPasswordBackBtnClick;
- (IBAction)downKeyboard;
- (IBAction)resetSuccessBtnClick;

@end
