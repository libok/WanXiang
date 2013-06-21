//
//  WWRYHLFatherViewController.h
//  wanxiangerweima
//
//  Created by mac on 13-4-3.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//优惠券 会员卡 礼品券 父类
@interface WWRYHLFatherViewController : UIViewController 
{
	IBOutlet UITableView    *_tableView;
	IBOutlet UILabel        *_titleLabel;
}
@property (nonatomic,retain) UILabel      *titleLabel;
@property (nonatomic,retain) UITableView  *tableView;

- (IBAction)backButtonClick;
- (IBAction)deleteButtonClick:(id)sender;

@end
