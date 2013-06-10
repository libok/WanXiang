//
//  LYGEveryPhenomenonStreetViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBengine.h"
@class DAReloadActivityButton;
@interface LYGEveryPhenomenonStreetViewController : UIViewController <LSBengineAdDelegate,UITableViewDelegate>
{
    LSBengine *_engine;
    NSArray   *_adArray;
     DAReloadActivityButton *_viewButton;
    NSArray *_myArray;
    int _v;

}
@property (retain, nonatomic) IBOutlet UITextField *myEdit;

@property(nonatomic,retain) NSArray *myArray;
@property(nonatomic,assign) LSBengine           *engine;
@property(nonatomic,retain) IBOutlet DAReloadActivityButton *viewButton;
- (IBAction)btnClick:(id)sender;
@property(nonatomic,retain) NSArray             *adArray;
@property (retain, nonatomic) IBOutlet UIView   *xialaView;
- (IBAction)buttonClick:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIButton *provincebtn;
- (IBAction)animated:(id)sender;
@property (retain, nonatomic) IBOutlet UIPageControl *adPageC;
 
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *btnArray;
@property (retain, nonatomic) IBOutlet UIImageView *sanjiao;
@property (retain, nonatomic) IBOutlet UIButton *btnwanxiang;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *searchView;
@property (retain, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic,retain)  NSTimer * myTimer;
@property (nonatomic,assign)  BOOL isNeedRefresh;
- (IBAction)end:(id)sender;

@end
