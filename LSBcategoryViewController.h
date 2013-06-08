//
//  LSBcategoryViewController.h
//  wanxiangerweima
//
//  Created by 李帅兵 on 13-4-2.
//
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"
#import "LSBengine.h"
@interface LSBcategoryViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    //cates美食  Folder文件夹
	NSArray *_cates;
	IBOutlet UIFolderTableView *_tableView;
    LSBengine *_engine;
    NSArray *_subCates;
}
@property (retain, nonatomic) NSArray *cates;
@property(retain,nonatomic) LSBengine *engine;
@property(retain,nonatomic) NSArray *subCates;
@property (retain, nonatomic) IBOutlet UIFolderTableView *tableView;
- (IBAction)btnClick:(id)sender;

@end
