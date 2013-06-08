//
//  BYNSafetyQuestionViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BYNSafetyQuestionViewController : UIViewController 
{
    IBOutlet  UITextField  *_answerTF;
	IBOutlet  UITextField  *_questionTF;
		
}
@property (nonatomic,retain) UITextField  *answerTF;
@property (nonatomic,retain) UITextField  *questionTF;

-(IBAction)safetyQuestionBackBtnClick;
-(IBAction)enterNextFoundPassword;
- (IBAction)downKeyboard;

@end
