//
//  ScanViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
//#include "helpClass.h"
#import <UIKit/UIKit.h>
#import "ZhuanPanView.h"
@interface HelpClass:NSObject
{
    
}
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * Contents;
-(id)initWithDict:(NSDictionary *)dict;
@end
@interface LYGScanViewController : UIViewController
{
   int _currentIndex;
	
}
- (IBAction)createButtonClick:(id)sender;
- (IBAction) btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet ZhuanPanView *bigZhuanPanView;
@property (retain, nonatomic) IBOutlet UILabel *kindOfLabel;
@property (retain, nonatomic) IBOutlet UILabel *detailOfLabel;
@property (nonatomic,assign)  int               currentIndex;
@property (nonatomic,retain)  NSArray          * kindsArry;

@end
