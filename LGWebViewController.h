//
//  LGWebViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGWebViewController : UIViewController<UITextFieldDelegate>
{
	IBOutlet UITextField *_wangzhanName;
	IBOutlet UITextField *_wangzhanHttp;
	UITextField          *_currentTextFiled;
}
@property (nonatomic,retain) UITextField *wangzhanName;
@property (nonatomic,retain) UITextField *wangzhanHttp;
@property (nonatomic,retain) UITextField *currentTextFiled;

- (IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;

@end
