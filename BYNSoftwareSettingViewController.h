//
//  BYNSoftwareSettingViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNSoftwareSettingViewController : UIViewController
{
    IBOutlet  UISwitch  *_notifySwicth;
	IBOutlet  UISwitch  *_sinaSwitch;
	IBOutlet  UISwitch  *_tencentSwitch;
	
	NSMutableDictionary *_dic;
	
	
}
-(IBAction)clearImageCache;
-(IBAction)notifySwicthSetting;
-(IBAction)weiboSwitch:(id)sender;

-(IBAction)softwareSettingBackBtnClick;
-(void)switchSettingAlertView:(NSString *)aStr;

@end
