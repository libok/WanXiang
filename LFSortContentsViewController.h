//
//  LFSortContentsViewController.h
//  wanxiangerweima
//
//  Created by Evan on 13-4-9.
//
//

#import <UIKit/UIKit.h>
#import "LFESort.h"
@interface HuiKanGuangGao:NSObject
{
    
}
-(id)initWithaDictionary:(NSDictionary*)adictionary;

@end

@interface LFSortContentsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

{
     
}
@property (retain, nonatomic) IBOutlet UIScrollView *guangaoScroview;
@property(nonatomic,retain) NSString *categorize;
@property(nonatomic,retain) NSArray  *fenleiArry;
@property(nonatomic,assign) NSArray  * currentArry;
@property(nonatomic,retain) NSMutableDictionary * dict;
@property(nonatomic,assign) int      currentIndex;
@property (nonatomic,retain) LFESort * oneSort;
@property (retain, nonatomic) IBOutlet UIScrollView *mainScrollview;

@property (retain, nonatomic) IBOutlet UILabel *className;

- (IBAction)gobackBtn:(id)sender;
-(void)initGet;
@property (retain, nonatomic) IBOutlet UISegmentedControl *mySegmentController;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UIImageView *huiKanImageView;
- (IBAction)segmentValueChanged:(id)sender;

@end
