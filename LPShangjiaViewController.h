//
//  LPShangjiaViewController.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-20.
//
//

#import <UIKit/UIKit.h>
#import "LSBengine.h"
 
@interface LPShangjiaViewController : UIViewController
{
    NSDictionary *_dateDictionary;
    LSBengine *_engine;
    int _managerID;
    NSArray *_dataArray;
  
    
}
 
@property(nonatomic,retain) NSArray *dataArray;
@property(nonatomic,assign) int managerID;
@property(nonatomic,retain) LSBengine *engine;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)btnClick:(id)sender;
@property(nonatomic,retain) NSDictionary *dataDictionary;
@end
