//
//  WWRLiPinQuanViewController.h
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWRYHLFatherViewController.h"
#import "WWRWXBEngine.h"
@interface WWRLiPinQuanViewController : WWRYHLFatherViewController<WWRWXBEngineGetGiftListDelegate,UIAlertViewDelegate>

{
	WWRWXBEngine   *_engine;
    NSMutableArray        *_statuesArray;
	
}
@property (nonatomic,retain) NSMutableArray  *statuesArray;


@end