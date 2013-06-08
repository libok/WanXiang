//
//  TextGreatViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

//
@interface TextGreatViewController : UIViewController <ASIHTTPRequestDelegate>
{
	IBOutlet UITextView *_inTextView;
}

@property (nonatomic,retain) UITextView *inTextView;

- (IBAction) back;
- (IBAction) setting;
@end
