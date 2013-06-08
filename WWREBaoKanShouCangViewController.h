//
//  WWREBaoKanShouCangViewController.h
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWRWXBEngine.h"
#import "ArticleModel.h"

@interface WWREBaoKanShouCangViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,WWRWXBEngineEBookFavListDelegate,UIAlertViewDelegate> 
{
	IBOutlet UITableView    *_tableView;
	IBOutlet UILabel        *_titleLabel;
	UIActionSheet           *_actionSheet;
	
	WWRWXBEngine            *_engine;
    NSMutableArray        *_statuesArray;
	
}
@property (nonatomic,retain) UILabel         *titleLabel;
@property (nonatomic,retain) UITableView     *tableView;

@property (nonatomic,retain) NSMutableArray  *statuesArray;

- (IBAction)backButtonClick;
- (IBAction)deleteButtonClick;
- (void)deleteArray;
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;

- (void)showActionSheet;
- (void)actionButonClick:(id)sender;

@end