//
//  LGEmailViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGEmailViewController : UIViewController 
{
	IBOutlet UITextField *_emailTextField;
}
@property (nonatomic,retain) UITextField *emailTextField;

- (IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;
-(BOOL)validateEmail:(NSString*)email;

@end
