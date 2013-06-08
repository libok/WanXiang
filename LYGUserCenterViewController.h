//
//  LYGUserCenterViewController.h
//  wanxiangerweima
//
//  Created by  on 13-4-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYGUserCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	IBOutlet UITableView     *_tableView;
		
	NSMutableArray           *_imageArray;
	NSArray                  *_contentArray;
    //NSJSONSerialization
    //CFSocketRef
    //NSJson
    //CFNet
	
}

-(IBAction)backBtnClick;

@end
