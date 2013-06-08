//
//  BYNFoundPasswordViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNFoundPasswordViewController : UIViewController 
{
	IBOutlet UITextField   *_phoneNumTF;

}
@property (nonatomic,retain) UITextField   *phoneNumTF;

- (IBAction)foundPasswordBackBtnClick;
- (IBAction)enterNextFoundPassword;
- (IBAction)downKeyboard;

@end
