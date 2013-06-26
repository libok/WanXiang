//
//  WWROrderViewController.h
//  wanxiangerweima
//
//  Created by lygn128 on 13-6-25.
//
//

#import <UIKit/UIKit.h>
#import "WWRYHLFatherViewController.h"
#import "WWRWXBEngine.h"
#import "WWRYHLFatherCell.h"
#import "LPCommodityViewController.h"
@interface WWROrderViewController : WWRYHLFatherViewController<UIActionSheetDelegate>
{
	WWRWXBEngine   *_engine;
}
@property (nonatomic,retain) NSMutableArray  *statuesArray;
@property(nonatomic,assign)  int type;
@end

