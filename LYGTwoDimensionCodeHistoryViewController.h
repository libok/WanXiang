//
//  LYGTwoDimensionCodeHistoryViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"


@interface LYGTwoDimensionCodeHistoryViewController : UIViewController<UIActionSheetDelegate,UITableViewDelegate>
{
}
@property(nonatomic,retain)NSMutableArray * myarry;
@property(nonatomic,retain)NSArray * imagenameArry;
- (IBAction)backButtonClick:(id)sender;
- (IBAction)segmentvalueChanged:(id)sender;
- (IBAction)deleteButtonClick:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UIButton *moveToTrashButton;
@property (retain, nonatomic) IBOutlet UISegmentedControl *mySegmentController;
@property (retain, nonatomic) SVSegmentedControl *navSc;


@end
