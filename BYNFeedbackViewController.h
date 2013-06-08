//
//  BYNFeedbackViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNFeedbackViewController : UIViewController<UITextViewDelegate>
{
    IBOutlet UITextView     *_contentTextView;
	IBOutlet UITextField    *_contactTextField;
	IBOutlet UIScrollView   *_scrollView;
}
- (IBAction)feedbackSuccess;

- (IBAction)feedbackBackBtnClick;
- (IBAction)downKeyboard;

@end
