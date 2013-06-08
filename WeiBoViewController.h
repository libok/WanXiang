//
//  WeiBoViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeiBoViewController : UIViewController<UITextFieldDelegate>
{
	IBOutlet UITextField *_weiboName;
	IBOutlet UITextField *_weiboHttp;
	UITextField          *_currentTextFiled;
}
@property (nonatomic,retain) UITextField *weiboName;
@property (nonatomic,retain) UITextField *weiboHttp;
@property (nonatomic,retain) UITextField *currentTextFiled;

- (IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;

@end
