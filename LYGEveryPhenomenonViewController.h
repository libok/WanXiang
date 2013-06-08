//
//  LYGEveryPhenomenonViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYGEveryPhenomenonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UITableView   *_tableView;
	NSArray                *_ePCellLabelArray;
}
@property (nonatomic,retain) UITableView   * tableView;
@property (nonatomic,retain) NSArray       *ePCellLabelArray;
@property (nonatomic,retain) NSArray       *numArry;

- (IBAction)backButtonClick;

@end
