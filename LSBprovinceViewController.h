//
//  LSBprovinceViewController.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-3.
//
//

#import <UIKit/UIKit.h>
#import "LSBengine.h"
@interface LSBprovinceViewController : UIViewController <LSBengineDelegate>
{
    NSArray             *_provinceArray;
    NSArray             *_cityArray;
    NSMutableDictionary *_dic;
    NSArray             *_keys;
    id                  _delegate;
    LSBengine           *_engine;
    
    BOOL                flag[100];
    
}
@property(nonatomic,retain) LSBengine           *engine;
@property(nonatomic,retain) NSArray             *cityArray;
@property(nonatomic,retain) NSArray             *provinceArray;
@property(nonatomic,retain) NSMutableDictionary *dic;
@property(nonatomic,retain) NSArray             *keys;
@property(nonatomic,assign) id                  delegate;
- (IBAction)btnClick:(id)sender;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
 
@end
