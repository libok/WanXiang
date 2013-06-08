//
//  LGHttpViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGHttpViewController : UIViewController 
{
	IBOutlet UITextField *_httpTextField;
}
@property (nonatomic,retain) UITextField *httpTextField;

- (IBAction) back;
- (IBAction) setting;
- (IBAction) keyboard;

@end
