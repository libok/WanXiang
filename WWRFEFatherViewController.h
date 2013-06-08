//
//  WWRFEFatherViewController.h
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWRWXBEngine.h"
@interface WWRFEFatherViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,WWRWXBEngineYoOKOrderListDelegate,UIAlertViewDelegate> 
{
	
	WWRWXBEngine          *_engine;
    NSMutableArray        *_statuesArray;
	
	IBOutlet UITableView    *_tableView;
	IBOutlet UILabel        *_titleLabel;
	IBOutlet UIButton       *_deleteButton;
}
@property (nonatomic,retain) UILabel          *titleLabel;
@property (nonatomic,retain) UITableView      *tableView;
@property (nonatomic,retain) NSMutableArray   *statuesArray;

- (IBAction)backButtonClick;
- (IBAction)deleteButtonClick;

@end
