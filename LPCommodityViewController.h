//
//  LPCommodityViewController.h
//  wanxiangerweima
//
//  
//
//

#import <UIKit/UIKit.h>
#import "ShopViewController.h"
@class LSBengine;
@interface LPCommodityViewController : UIViewController
{
    LSBengine *_engine;
    NSArray *_dataArray;
    int _class_id;
    NSString *_searchStr;
}
@property(nonatomic,retain) NSString *searchStr;
@property(nonatomic,retain) NSArray *dataArray;
@property(nonatomic,assign) int class_id;
@property(nonatomic,retain) LSBengine *engine;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain) ShopInfo  *m_ShopInfo;
- (IBAction)btnClick:(id)sender;

@end
