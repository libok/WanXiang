//
//  WWRSoftwareUsedViewController.h
//  wanxiangerweima
//
//  Created by mac on 13-4-7.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WWRSoftwareUsedViewController : UIViewController 
{
	IBOutlet  UITextView  *_aboutUsTV;
	NSString			  *_newsID ;
	NSString              *_contentStr;
}
@property (nonatomic,retain) UITextView  *aboutUsTV;
@property (nonatomic,retain) NSString    *newsID;
@property (nonatomic,retain) NSString    *contentStr;


- (IBAction)backButtonClick;

@end
