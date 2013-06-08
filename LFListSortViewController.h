//
//  LFListSortViewController.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-7.
//
//

#import <UIKit/UIKit.h>
#import "LFESort.h"
@interface LFListSortViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *_gobackBtn;
    IBOutlet UILabel *_listTitle;
    
    IBOutlet UITableView *_listSortTableVC;
}
@property (nonatomic,retain) NSString *kindsSort;
@property (nonatomic,retain) NSArray *kindSortArray;


- (IBAction)gobackBtnClick;

@end
