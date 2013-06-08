//
//  LGHelpViewController.h
//  wanxiangerweima
//
//  Created by LG on 13-4-15.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LGHelpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
	IBOutlet UIView *_helpView;
}

@property (nonatomic,retain) UIView *helpView;

- (IBAction) back;
- (IBAction) btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray*myArry;
@end
