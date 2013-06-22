//
//  LSBmyViewController.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-2.
//
//

#import <UIKit/UIKit.h>
#import "LSBengine.h"
#import "SVSegmentedControl.h"
@interface LSBmyViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    LSBengine *_engine;
    NSMutableArray *_dataArray;                                                                                                   
    UIActionSheet *_actionSheet;
    NSArray *_datilData;
}
@property(nonatomic,retain) NSArray *datilData;
@property(nonatomic,retain) UIActionSheet *actionSheet;
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain) LSBengine *engine;
- (IBAction)btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)  SVSegmentedControl   * navSc;

@end
