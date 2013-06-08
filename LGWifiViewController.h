//
//  LGWifiViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGWifiViewController : UIViewController 
{
	IBOutlet UITextField *_accountsTextField;
	IBOutlet UITextField *_passwordTextField;
	IBOutlet UITextField *_typeTextField;
	UITextField          *_currentTextFiled;
	IBOutlet UIView      *_xialaView;
	BOOL                  _isOpen;
}

@property (nonatomic,retain) UITextField *accountsTextField;
@property (nonatomic,retain) UITextField *passwordTextField;
@property (nonatomic,retain) UITextField *typeTextField;
@property (nonatomic,retain) UITextField *currentTextFiled;
@property (nonatomic,retain) UIView      *xialaView;

-(IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;
- (IBAction) xialabtn;
-(IBAction)select:(id)sender;


@end
