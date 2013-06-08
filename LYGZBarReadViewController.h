//
//  LYGZBarReadViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ZBarSDK.h"

@interface LYGZBarReadViewController : ZBarReaderViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
	CGPoint _point;
	UIView  * line;
	NSTimer * timer;
	SystemSoundID           _shakeSoundID;           //摇一摇声音   无符号长整形
    UIView  * _albumView;
}

-(void)back;
@end
