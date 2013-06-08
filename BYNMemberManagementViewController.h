//
//  BYNMemberManagementViewController.h
//  wanxiangerweima
//
//  Created by usr on 13-4-4.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYNMemberManagementViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> 
{
	IBOutlet UITableView    *_tableView;
	NSMutableArray          *_memberArray;
	NSString                *_suidStr;
	NSUInteger              _buttonRow;
}
@property (nonatomic,retain) NSMutableArray      *memberArray;

-(void)getMemberNickname;
-(IBAction)memberManagementBackBtnClick;

@end
