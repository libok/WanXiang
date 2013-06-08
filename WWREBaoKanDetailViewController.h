//
//  WWREBaoKanDetailViewController.h
//  LPTest
//
//  Created by mac on 13-4-26.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWRWXBEngine.h"

@interface WWREBaoKanDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,WWRWXBEngineEBookMsgDelegate> 
{
	IBOutlet  UIScrollView  *_scrollView;
	IBOutlet  UIButton      *_shouCangBtn;
	IBOutlet  UILabel       *_titleLabel;
	IBOutlet  UILabel       *_dateLabel;
	IBOutlet  UIImageView   *_fenGeImageView;
	IBOutlet  UIImageView   *_contentImageView;
	IBOutlet  UILabel       *_contentLabel;
	IBOutlet  UITableView   *_tableView;
	IBOutlet  UIImageView   *_diBuImageView;
	IBOutlet  UIButton      *_liuYanButton;
	IBOutlet  UIButton      *_aJiaButton;
	IBOutlet  UIButton      *_aJianButton;
	int                     _bookId;
	
	NSString                *_titleStr;
	NSString                *_dateStr;
	NSString                *_contentStr;
	
	WWRWXBEngine            *_engine;
    NSArray                 *_statuesArray;
	
}

@property (nonatomic,retain)UIScrollView  *scrollView;
@property (nonatomic,retain)UILabel       *titleLabel;
@property (nonatomic,retain)UIButton      *shouCangBtn;
@property (nonatomic,retain)UILabel       *dateLabel;
@property (nonatomic,retain)UIImageView   *contentImageView;
@property (nonatomic,retain)UIImageView   *diBuImageView;
@property (nonatomic,retain)UILabel       *contentLabel;
@property (nonatomic,retain)UITableView   *tableView;
@property (nonatomic,assign)int           bookId;

@property (nonatomic,retain)NSString      *titleStr;
@property (nonatomic,retain)NSString      *dateStr;
@property (nonatomic,retain)NSString      *contentStr;

@property (nonatomic,retain) NSArray      *statuesArray;

- (IBAction)backButtonClick;
- (IBAction)requestShouCangBtnClick;

- (IBAction)diBuBtnClick:(id)sender;

@end
